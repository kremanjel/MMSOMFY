use strict;
use warnings;
use Test2::V1 "-import";
no warnings 'once';

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates timer command movement start behavior.
# - How: Calls CalculateAwningShutter with open_for_timer/close_for_timer.
# - Steps: Checks movement reading direction and TimerStopTime creation.
# - Expectation: Simulation starts in correct direction with stop timestamp.
subtest 'timer commands create simulated movement' => sub {
    my $hash_open_timer = MMSOMFY::TestHelper::make_device(
        name => 'dev_open_timer',
        factor => 0.5,
        movement => MMSOMFY::Movement::none(),
    );
    my $open_cmd = MMSOMFY::Command::open_for_timer();
    my $open_arg = 3;
    MMSOMFY::DeviceModel::CalculateAwningShutter($open_cmd, $open_arg);

    is($hash_open_timer->{READINGS}{movement}{VAL}, MMSOMFY::Movement::up(), 'open_for_timer starts up movement');
    ok(defined($hash_open_timer->{SimulationKey}{TimerStopTime}), 'open_for_timer sets TimerStopTime');

    my $hash_close_timer = MMSOMFY::TestHelper::make_device(
        name => 'dev_close_timer',
        factor => 0.3,
        movement => MMSOMFY::Movement::none(),
    );
    my $close_cmd = MMSOMFY::Command::close_for_timer();
    my $close_arg = 4;
    MMSOMFY::DeviceModel::CalculateAwningShutter($close_cmd, $close_arg);

    is($hash_close_timer->{READINGS}{movement}{VAL}, MMSOMFY::Movement::down(), 'close_for_timer starts down movement');
    ok(defined($hash_close_timer->{SimulationKey}{TimerStopTime}), 'close_for_timer sets TimerStopTime');
};

# Test Description:
# - What: Validates position target direction selection (from go_my conversion).
# - How: Configures factor and position argument then executes position.
# - Steps: Runs CalculateAwningShutter and inspects SimulationKey command.
# - Expectation: Movement direction is chosen according to target delta.
subtest 'position derives direction and timer from target delta' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_go_my',
        factor => 0.8,
        movement => MMSOMFY::Movement::none(),
    );

    my $cmd = MMSOMFY::Command::position();
    my $cmdarg = 20;
    MMSOMFY::DeviceModel::CalculateAwningShutter($cmd, $cmdarg);

    is($hash->{SimulationKey}{Command}, MMSOMFY::Command::open(), 'position(20) selects open direction for more-open target when factor=0.8');
};

# Test Description:
# - What: Validates calibration abort ownership in DeviceModel::CalculateAwningShutter.
# - How: Executes position and stop while CalibrationData is active.
# - Steps: Verifies calibration cleanup and command behavior in calculate phase.
# - Expectation: CalculateAwningShutter aborts calibration for stop/position commands.
subtest 'calculate aborts calibration for stop and position' => sub {
    my $hash_pos = MMSOMFY::TestHelper::make_device(
        name => 'dev_calculate_abort_position',
        factor => 0.8,
        movement => MMSOMFY::Movement::none(),
    );
    $main::FHEM_Hash = $hash_pos;
    $hash_pos->{CalibrationData} = { type => 'basic', step => 1, waitingForInput => 1 };

    my $position_cmd = MMSOMFY::Command::position();
    my $position_arg = 20;
    MMSOMFY::DeviceModel::CalculateAwningShutter($position_cmd, $position_arg);
    ok(!defined($hash_pos->{CalibrationData}), 'position aborts active calibration in calculate phase');
    is($hash_pos->{SimulationKey}{Command}, MMSOMFY::Command::open(), 'position command still continues after abort');

    my $hash_stop = MMSOMFY::TestHelper::make_device(
        name => 'dev_calculate_abort_stop',
        factor => 0.4,
        movement => MMSOMFY::Movement::down(),
    );
    $main::FHEM_Hash = $hash_stop;
    $hash_stop->{CalibrationData} = { type => 'basic', step => 1, waitingForInput => 1 };
    $hash_stop->{SimulationKey} = {
        StartTime => main::gettimeofday() - 1,
        StartFactor => 0.4,
        Command => MMSOMFY::Command::close(),
    };

    my $stop_cmd = MMSOMFY::Command::stop();
    my $stop_arg = undef;
    MMSOMFY::DeviceModel::CalculateAwningShutter($stop_cmd, $stop_arg);
    ok(!defined($hash_stop->{CalibrationData}), 'stop aborts active calibration in calculate phase');
    ok(!defined($hash_stop->{SimulationKey}), 'stop still stops active movement after abort');
};

# Test Description:
# - What: Validates direct switch state mapping.
# - How: Executes CalculateSwitch for on and off commands.
# - Steps: Reads STATE after each command call.
# - Expectation: STATE matches on/off command semantics.
subtest 'switch devices map on/off directly to state' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_switch',
        model => MMSOMFY::Model::switch(),
        timing => MMSOMFY::Timing::off(),
        with_timings => 0,
    );
    $main::FHEM_Hash = $hash;

    MMSOMFY::DeviceModel::CalculateSwitch(MMSOMFY::Command::on(), undef);
    is($hash->{STATE}, MMSOMFY::State::on(), 'switch on maps to on state');

    MMSOMFY::DeviceModel::CalculateSwitch(MMSOMFY::Command::off(), undef);
    is($hash->{STATE}, MMSOMFY::State::off(), 'switch off maps to off state');
};

# Test Description:
# - What: Validates adaptive update frequency helper thresholds.
# - How: Calls GetAdaptiveUpdateFrequency with representative remaining times.
# - Steps: Compares return values against expected frequency bands.
# - Expectation: Adaptive frequency policy is applied deterministically.
subtest 'update frequency helpers select expected intervals' => sub {
    is(MMSOMFY::DeviceModel::GetAdaptiveUpdateFrequency(0.2), 0.10, 'very short remaining time uses fastest update');
    is(MMSOMFY::DeviceModel::GetAdaptiveUpdateFrequency(2), 0.20, 'short remaining time uses medium update');
    is(MMSOMFY::DeviceModel::GetAdaptiveUpdateFrequency(20), MMSOMFY::DeviceModel::UpdateFrequency(), 'long remaining time uses default update');
};

# Test Description:
# - What: Validates scheduling of next simulation callback.
# - How: Seeds SimulationKey and runs ScheduleNextTimerCallback.
# - Steps: Inspects mocked internal timer queue for new entry.
# - Expectation: At least one follow-up timer is queued.
subtest 'ScheduleNextTimerCallback enqueues timer' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_schedule',
        factor => 0.6,
        movement => MMSOMFY::Movement::up(),
    );

    $hash->{SimulationKey} = {
        Command => MMSOMFY::Command::open(),
        StartTime => main::gettimeofday() - 1,
        StartFactor => 0.6,
    };

    @main::FHEM_MOCK_TIMERS = ();
    MMSOMFY::DeviceModel::ScheduleNextTimerCallback($hash);
    ok(scalar(@main::FHEM_MOCK_TIMERS) >= 1, 'timer callback scheduling adds internal timer');
};

# Test Description:
# - What: Validates timer callback abort safety checks.
# - How: Runs TimerCallback with negative and excessive elapsed time.
# - Steps: Uses manipulated StartTime values and checks cleanup.
# - Expectation: SimulationKey is removed in both invalid timing cases.
subtest 'TimerCallback handles negative and excessive elapsed times' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_timer_errors',
        factor => 0.5,
        movement => MMSOMFY::Movement::up(),
    );

    $hash->{SimulationKey} = {
        Command => MMSOMFY::Command::open(),
        StartTime => main::gettimeofday() + 5,
        StartFactor => 0.5,
    };
    MMSOMFY::DeviceModel::TimerCallback($hash);
    ok(!defined($hash->{SimulationKey}), 'negative elapsed time cancels simulation');

    $hash->{SimulationKey} = {
        Command => MMSOMFY::Command::close(),
        StartTime => main::gettimeofday() - (MMSOMFY::Timing::MovementTimeoutSeconds() + 1),
        StartFactor => 0.5,
    };
    MMSOMFY::DeviceModel::TimerCallback($hash);
    ok(!defined($hash->{SimulationKey}), 'timeout cancels simulation');
};

# Test Description:
# - What: Validates physical stop send behavior for timer-based target stops.
# - How: Runs TimerCallback with an expired timer-limited simulation.
# - Steps: Intercepts Send2Device and asserts stop send only for intermediate target.
# - Expectation: Timer target sends stop away from endpoints and suppresses stop near 0/1.
subtest 'timer target stop sends physical stop except near endpoints' => sub {
    my @sent;
    no warnings 'redefine';
    local *MMSOMFY::Command::Send2Device = sub {
        my ($cmd, $arg) = @_;
        push @sent, [$cmd, $arg];
        return undef;
    };

    my $hash_mid = MMSOMFY::TestHelper::make_device(
        name => 'dev_timer_physical_stop_mid',
        factor => 0.4,
        movement => MMSOMFY::Movement::down(),
    );
    $hash_mid->{SimulationKey} = {
        Command => MMSOMFY::Command::close(),
        StartTime => main::gettimeofday() - 2,
        StartFactor => 0.4,
        TimerStopTime => main::gettimeofday() - 1,
        RequiresPhysicalStop => 1,
    };

    MMSOMFY::DeviceModel::TimerCallback($hash_mid);
    is($sent[0][0], MMSOMFY::Command::stop(), 'timer-based intermediate stop sends physical stop');

    @sent = ();

    my $hash_edge = MMSOMFY::TestHelper::make_device(
        name => 'dev_timer_physical_stop_edge',
        factor => 0.95,
        movement => MMSOMFY::Movement::down(),
    );
    $hash_edge->{SimulationKey} = {
        Command => MMSOMFY::Command::close(),
        StartTime => main::gettimeofday() - 2,
        StartFactor => 0.95,
        TimerStopTime => main::gettimeofday() - 1,
        RequiresPhysicalStop => 1,
    };

    MMSOMFY::DeviceModel::TimerCallback($hash_edge);
    is(scalar(@sent), 0, 'no physical stop is sent near end positions');
};

# Test Description:
# - What: Validates explicit calibration start in off mode and virtual Calculate behavior.
# - How: Calls StartInteractiveCalibration in off mode and Calculate in virtual mode.
# - Steps: Checks first instruction plus cmd/cmdarg clearing semantics.
# - Expectation: Calibration starts from off mode and virtual mode suppresses send command.
subtest 'calibration start from off mode and virtual calculate behavior' => sub {
    my $off_hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_cal_off',
        timing => MMSOMFY::Timing::off(),
        with_timings => 0,
    );

    my $ret = MMSOMFY::DeviceModel::StartInteractiveCalibration($off_hash, 'basic');
    is($ret, undef, 'calibration start is non-blocking for set return flow');
    like(
        $off_hash->{READINGS}{MMSOMFY::Reading::calibration_instruction()}{VAL},
        qr/Calibration will now move the shutter to COMPLETELY OPEN/,
        'calibration start instruction is exposed via calibration_instruction reading'
    );

    my $switch_hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_virtual_switch',
        model => MMSOMFY::Model::switch(),
        timing => MMSOMFY::Timing::off(),
        with_timings => 0,
    );
    $main::FHEM_Hash = $switch_hash;
    my $cmd = MMSOMFY::Command::on();
    my $cmdarg = undef;
    my $calculate_ret = MMSOMFY::DeviceModel::Calculate(MMSOMFY::Mode::virtual(), $cmd, $cmdarg);
    is($calculate_ret, undef, 'virtual calculate returns no message');
    ok(!defined($cmd), 'virtual mode clears command for send phase');
    ok(!defined($cmdarg), 'virtual mode clears command argument for send phase');
    is($switch_hash->{STATE}, MMSOMFY::State::on(), 'virtual calculate still updates switch state');
};

# Test Description:
# - What: Validates that explicit calibration start commands are handled in CalculateAwningShutter.
# - How: Calls CalculateAwningShutter directly with calibrate_basic while timing is off.
# - Steps: Inspects returned command/error tuple.
# - Expectation: Awning/shutter calculation path accepts explicit calibration start in timing off.
subtest 'calibration commands are handled in awning shutter path' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_awning_calibration_path',
        timing => MMSOMFY::Timing::off(),
        with_timings => 0,
    );
    $main::FHEM_Hash = $hash;

    my $cmd = MMSOMFY::Command::calibrate_basic();
    my $cmdarg = undef;
    my $ret = MMSOMFY::DeviceModel::CalculateAwningShutter($cmd, $cmdarg);
    ok(!defined($cmd), 'calibrate_basic does not return a send command');
    ok(!defined($cmdarg), 'calibrate_basic does not return a send argument');
    is($ret, undef, 'calibration start is non-blocking for set return flow');
    like(
        $hash->{READINGS}{MMSOMFY::Reading::calibration_instruction()}{VAL},
        qr/Calibration will now move the shutter to COMPLETELY OPEN/,
        'first calibration instruction is published as reading'
    );
};

# Test Description:
# - What: Validates info-first calibration handshake.
# - How: Starts basic calibration and triggers calibrate_next twice.
# - Steps: Intercepts Send2Device and checks command sequence/state transitions.
# - Expectation: First confirm opens to known start position; second confirm starts first timed measurement.
subtest 'basic calibration starts opening on first confirm and measures on second' => sub {
    my @sent;
    no warnings 'redefine';
    local *MMSOMFY::Command::Send2Device = sub {
        my ($cmd, $arg) = @_;
        push @sent, [$cmd, $arg];
        return undef;
    };

    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_calibration_open_handshake',
        timing => MMSOMFY::Timing::off(),
        with_timings => 0,
    );
    $main::FHEM_Hash = $hash;

    my $cmd = MMSOMFY::Command::calibrate_basic();
    my $cmdarg = undef;
    MMSOMFY::DeviceModel::CalculateAwningShutter($cmd, $cmdarg);

    is(scalar(@sent), 0, 'start step is informational and sends no movement command');

    $cmd = MMSOMFY::Command::calibrate_next();
    $cmdarg = undef;
    MMSOMFY::DeviceModel::CalculateAwningShutter($cmd, $cmdarg);

    is($sent[0][0], MMSOMFY::Command::open(), 'first calibrate_next sends open command');
    ok(!defined($hash->{CalibrationData}{startTime}), 'first calibrate_next does not start timed measurement');

    $cmd = MMSOMFY::Command::calibrate_next();
    $cmdarg = undef;
    MMSOMFY::DeviceModel::CalculateAwningShutter($cmd, $cmdarg);

    is($sent[1][0], MMSOMFY::Command::close(), 'second calibrate_next starts first measurement movement');
    ok(defined($hash->{CalibrationData}{startTime}), 'second calibrate_next starts timed measurement');
    is(scalar(@{$hash->{CalibrationData}{measurements}}), 0, 'no measurement is recorded until next confirmation');
};

# Test Description:
# - What: Validates that the complete step finalizes calibration immediately.
# - How: Seeds a basic calibration directly at step 'complete' and executes step processing.
# - Steps: Verifies calibration cleanup, completed reading state, and unlocked command list.
# - Expectation: Completion removes CalibrationData and restores normal command availability.
subtest 'basic calibration complete step finalizes and unlocks commands' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_calibration_complete_finalize',
        timing => MMSOMFY::Timing::off(),
        with_timings => 0,
    );
    $main::FHEM_Hash = $hash;

    $hash->{CalibrationData} = {
        type => 'basic',
        step => 4,
        measurements => [26, 30],
        startTime => undef,
        waitingForInput => 0,
    };

    MMSOMFY::DeviceModel::ProcessBasicCalibrationStep($hash);

    ok(!defined($hash->{CalibrationData}), 'complete step clears active calibration data');
    is(
        $hash->{READINGS}{MMSOMFY::Reading::calibration_state()}{VAL},
        'completed',
        'calibration state reading is set to completed'
    );

    my $commands = MMSOMFY::Command::ToString(' ', 1);
    like($commands, qr/\bcalibrate_basic\b/, 'normal command list is restored after completion');
    unlike($commands, qr/^calibrate_next\s+stop$|^stop\s+calibrate_next$/, 'restricted in-calibration command list is no longer active');
};

# Test Description:
# - What: Prevents unintended stop/my at endpoint confirmations in basic calibration.
# - How: Confirms a running endpoint measurement step and captures outgoing RF commands.
# - Steps: Executes HandleCalibrationInput at basic step 3 (measure_open).
# - Expectation: No stop command is sent at endpoint confirmation.
subtest 'basic endpoint confirm does not send stop command' => sub {
    my @sent;
    no warnings 'redefine';
    local *MMSOMFY::Command::Send2Device = sub {
        my ($cmd, $arg) = @_;
        push @sent, [$cmd, $arg];
        return undef;
    };

    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_calibration_no_stop_at_endpoint',
        timing => MMSOMFY::Timing::off(),
        with_timings => 0,
    );
    $main::FHEM_Hash = $hash;

    $hash->{CalibrationData} = {
        type => 'basic',
        step => 3,
        measurements => [26],
        startTime => time() - 5,
        waitingForInput => 1,
    };

    MMSOMFY::DeviceModel::HandleCalibrationInput($hash);

    is(scalar(@sent), 0, 'no stop command is sent when confirming endpoint in basic calibration');
};

# Test Description:
# - What: Keeps explicit stop behavior at extended down checkpoints.
# - How: Confirms a running extended measurement at step 2 (open->down).
# - Steps: Executes HandleCalibrationInput and captures outgoing RF commands.
# - Expectation: A stop command is sent at down checkpoint confirmation.
subtest 'extended down checkpoint confirm sends stop command' => sub {
    my @sent;
    no warnings 'redefine';
    local *MMSOMFY::Command::Send2Device = sub {
        my ($cmd, $arg) = @_;
        push @sent, [$cmd, $arg];
        return undef;
    };

    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_calibration_stop_at_down',
        timing => MMSOMFY::Timing::off(),
        with_timings => 0,
    );
    $main::FHEM_Hash = $hash;

    $hash->{CalibrationData} = {
        type => 'extended',
        step => 2,
        measurements => [],
        startTime => time() - 5,
        waitingForInput => 1,
    };

    MMSOMFY::DeviceModel::HandleCalibrationInput($hash);

    is($sent[0][0], MMSOMFY::Command::stop(), 'stop command is sent at extended down checkpoint');
};

# Test Description:
# - What: Validates that Calculate receives position (from go_my conversion) and derives direction.
# - How: Calls Calculate with position on a timed shutter (simulating go_my→position from Check).
# - Steps: Ensures position is processed and converted to appropriate direction.
# - Expectation: Position is converted to open/close based on delta; no message returned.
subtest 'calculate converts position to direction for send phase' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_go_my_send_phase',
        factor => 0.8,
        movement => MMSOMFY::Movement::none(),
    );
    $main::FHEM_Hash = $hash;

    my $cmd = MMSOMFY::Command::position();
    my $cmdarg = 20;  # myPosition (was in go_my conversion)
    my $ret = MMSOMFY::DeviceModel::Calculate(MMSOMFY::Mode::send(), $cmd, $cmdarg);
    is($ret, undef, 'position calculate returns no message');
    is($cmd, MMSOMFY::Command::open(), 'send phase receives normalized direction command from Calculate');
    is($cmdarg, undef, 'position argument is consumed during normalization');
};

# Test Description:
# - What: Validates that calibrate_next is unavailable without active calibration.
# - How: Runs calibrate_next without CalibrationData.
# - Steps: Calls MMSOMFY_Set and checks returned command list.
# - Expectation: Command is rejected, list does not include calibrate_next, and no RF send is issued.
subtest 'set rejects calibrate_next without active calibration' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_set_calculate_retval',
        timing => MMSOMFY::Timing::basic(),
    );
    $main::FHEM_Hash = $hash;

    my $ret = main::MMSOMFY_Set($hash, $hash->{NAME}, MMSOMFY::Command::calibrate_next());

    like($ret, qr/calibrate_basic/, 'MMSOMFY_Set returns available command list including calibration start');
    unlike($ret, qr/calibrate_next/, 'returned command list does not include calibrate_next without active calibration');
    ok(!defined($hash->{READINGS}{MMSOMFY::Reading::calibration_instruction()}{VAL}), 'no calibration guidance reading is written for invalid command');
    ok(!defined($hash->{READINGS}{enc_key}{VAL}), 'no RF send happened while calibration was rejected');
};

# Test Description:
# - What: Validates the awning/shutter fallback for unknown commands.
# - How: Calls CalculateAwningShutter directly with an unsupported command string.
# - Steps: Checks returned error text and that both outgoing parameters are cleared.
# - Expectation: Unknown commands are logged as errors and suppressed before send phase.
subtest 'awning shutter path rejects unknown commands' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'dev_awning_unknown_command');
    $main::FHEM_Hash = $hash;

    my $cmd = 'unsupported_command';
    my $cmdarg = 'arg';
    my $ret = MMSOMFY::DeviceModel::CalculateAwningShutter($cmd, $cmdarg);

    like($ret, qr/Unknown command 'unsupported_command'/, 'unknown command returns explicit error');
    ok(!defined($cmd), 'unknown command clears command');
    ok(!defined($cmdarg), 'unknown command clears command argument');
};

done_testing;


