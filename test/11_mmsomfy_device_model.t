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
    MMSOMFY::DeviceModel::CalculateAwningShutter(MMSOMFY::Command::open_for_timer(), 3);

    is($hash_open_timer->{READINGS}{movement}{VAL}, MMSOMFY::Movement::up(), 'open_for_timer starts up movement');
    ok(defined($hash_open_timer->{SimulationKey}{TimerStopTime}), 'open_for_timer sets TimerStopTime');

    my $hash_close_timer = MMSOMFY::TestHelper::make_device(
        name => 'dev_close_timer',
        factor => 0.3,
        movement => MMSOMFY::Movement::none(),
    );
    MMSOMFY::DeviceModel::CalculateAwningShutter(MMSOMFY::Command::close_for_timer(), 4);

    is($hash_close_timer->{READINGS}{movement}{VAL}, MMSOMFY::Movement::down(), 'close_for_timer starts down movement');
    ok(defined($hash_close_timer->{SimulationKey}{TimerStopTime}), 'close_for_timer sets TimerStopTime');
};

# Test Description:
# - What: Validates go_my target direction selection.
# - How: Configures factor and myPosition then executes go_my.
# - Steps: Runs CalculateAwningShutter and inspects SimulationKey command.
# - Expectation: Movement direction is chosen according to target delta.
subtest 'go_my derives direction and timer from target delta' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_go_my',
        factor => 0.8,
        movement => MMSOMFY::Movement::none(),
    );
    $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::myPosition()} = 20;

    MMSOMFY::DeviceModel::CalculateAwningShutter(MMSOMFY::Command::go_my(), undef);

    is($hash->{SimulationKey}{Command}, MMSOMFY::Command::open(), 'go_my selects open direction for more-open target');
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
# - What: Validates calibration reset attribute cleanup.
# - How: Sets calibration attr and calls ResetCalibrationData.
# - Steps: Checks removal of calibration and timing attributes.
# - Expectation: Relevant attrs are deleted from attr hash.
subtest 'calibration reset clears calibration and timing attributes' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'dev_calibration');
    $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::calibrationMode()} = 'basic';

    MMSOMFY::DeviceModel::ResetCalibrationData($hash);

    ok(!exists $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::calibrationMode()}, 'calibrationMode is removed');
    ok(!exists $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeClosedToOpened()}, 'timing attributes are removed');
};

# Test Description:
# - What: Validates update interval helper thresholds.
# - How: Calls UpdateInterval and GetAdaptiveUpdateFrequency with test values.
# - Steps: Compares return values against expected frequency bands.
# - Expectation: Adaptive frequency policy is applied deterministically.
subtest 'update frequency helpers select expected intervals' => sub {
    is(MMSOMFY::DeviceModel::UpdateInterval(0.05), 0.05, 'interval keeps remaining time below update frequency');
    is(MMSOMFY::DeviceModel::UpdateInterval(1.0), MMSOMFY::DeviceModel::UpdateFrequency(), 'interval is capped by update frequency');

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
        StartTime => main::gettimeofday() - 301,
        StartFactor => 0.5,
    };
    MMSOMFY::DeviceModel::TimerCallback($hash);
    ok(!defined($hash->{SimulationKey}), 'timeout cancels simulation');
};

# Test Description:
# - What: Validates calibration guard and virtual Calculate return behavior.
# - How: Calls StartInteractiveCalibration in off mode and Calculate in virtual mode.
# - Steps: Checks guard message plus cmd/cmdarg clearing semantics.
# - Expectation: Calibration is blocked and virtual mode suppresses send command.
subtest 'calibration start guard and virtual calculate behavior' => sub {
    my $off_hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_cal_off',
        timing => MMSOMFY::Timing::off(),
        with_timings => 0,
    );

    my $ret = MMSOMFY::DeviceModel::StartInteractiveCalibration($off_hash, 'basic');
    like($ret, qr/Calibration not possible/, 'calibration cannot start in off timing');

    my $switch_hash = MMSOMFY::TestHelper::make_device(
        name => 'dev_virtual_switch',
        model => MMSOMFY::Model::switch(),
        timing => MMSOMFY::Timing::off(),
        with_timings => 0,
    );
    $main::FHEM_Hash = $switch_hash;
    my ($cmd, $cmdarg) = MMSOMFY::DeviceModel::Calculate(MMSOMFY::Mode::virtual(), MMSOMFY::Command::on(), undef);
    ok(!defined($cmd), 'virtual mode clears command for send phase');
    ok(!defined($cmdarg), 'virtual mode clears command argument for send phase');
    is($switch_hash->{STATE}, MMSOMFY::State::on(), 'virtual calculate still updates switch state');
};

done_testing;


