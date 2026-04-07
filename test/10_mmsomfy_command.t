use strict;
use warnings;
use Test2::V1 "-import";
no warnings 'once';

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates model-specific command list generation.
# - How: Builds command list from configured shutter hash.
# - Steps: Enables myPosition and checks published command names.
# - Expectation: Expected commands appear in the available set list.
subtest 'command list exposes model commands' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'command_list');
    $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::myPosition()} = 50;
    $main::FHEM_Hash = $hash;

    my $commands = MMSOMFY::Command::ToString(' ', 1);
    like($commands, qr/\bopen\b/, 'open command is published');
    like($commands, qr/\bgo_my\b/, 'go_my command is published');
    like($commands, qr/\bclose_for_timer\b/, 'timer close command is published');
    like($commands, qr/\bcalibrate\b/, 'single calibrate command is published');
};

# Test Description:
# - What: Validates position command boundary normalization.
# - How: Runs Command::Check with out-of-range and boundary values.
# - Steps: Checks error on >ENDPOS and rewrite at STARTPOS.
# - Expectation: Out-of-range is rejected, boundary maps to open command.
subtest 'position command validation adjusts boundaries' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'command_check');
    $main::FHEM_Hash = $hash;

    my $mode = MMSOMFY::Mode::send();
    my $cmd = MMSOMFY::Command::position();
    my $cmdarg = MMSOMFY::Position::ENDPOS() + 1;
    my $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);
    like($ret, qr/Position value out of range/, 'position command rejects values above ENDPOS');

    $cmd = MMSOMFY::Command::position();
    $cmdarg = MMSOMFY::Position::STARTPOS();
    $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);
    is($ret, undef, 'boundary position passes validation');
    is($cmd, MMSOMFY::Command::open(), 'boundary position is normalized to open command');
};

# Test Description:
# - What: Validates decode handling of control and payload frames.
# - How: Calls Decode with Yr and Ys sample frames.
# - Steps: Asserts ignore path and parsed address/command fields.
# - Expectation: Yr is ignored, Ys frame is decoded correctly.
subtest 'decode ignores Yr and decodes Ys frames' => sub {
    my $caller = { NAME => 'io', TYPE => 'CUL' };

    my %decoded = MMSOMFY::Command::Decode($caller, 'YrAA2F18F00085E8');
    is(scalar(keys %decoded), 0, 'Yr messages are ignored');

    %decoded = MMSOMFY::Command::Decode($caller, 'YsAA2F18F00085E8');
    is($decoded{address}, 'E88500', 'address is decoded from RTS payload');
    is($decoded{command}, '20', 'command nibble is decoded');
};

# Test Description:
# - What: Validates send path updates for known commands.
# - How: Sends open command through SIGNALduino-mocked IO.
# - Steps: Checks enc_key, rolling_code and DEF updates.
# - Expectation: Send succeeds and transport readings are incremented.
subtest 'Send2Device emits output for known commands' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'command_send', address => '123456');
    $hash->{IODev} = { TYPE => 'SIGNALduino', NAME => 'sig' };
    $main::FHEM_Hash = $hash;

    my $ret = MMSOMFY::Command::Send2Device(MMSOMFY::Command::open(), undef);
    is($ret, undef, 'sending open command succeeds');
    is($hash->{READINGS}{enc_key}{VAL}, 'A1', 'sending updates the encryption key reading');
    is($hash->{READINGS}{rolling_code}{VAL}, '0001', 'sending increments the rolling code reading');
    like($hash->{DEF}, qr/^123456 shutter A1 0001$/, 'sending updates the DEF representation');
};

# Test Description:
# - What: Validates Command::Check edge behavior matrix.
# - How: Exercises timer/manual/go_my/stop/z_custom argument paths.
# - Steps: Calls Check repeatedly with invalid and valid combinations.
# - Expectation: Invalid inputs fail and rewrite rules are applied.
subtest 'Check handles timer/manual/custom edge cases' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'command_edges');
    $main::FHEM_Hash = $hash;
    $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::myPosition()} = 50;

    my $mode = MMSOMFY::Mode::send();
    my $cmd = MMSOMFY::Command::close_for_timer();
    my $cmdarg = 'bad';
    my $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);
    like($ret, qr/Bad time spec/, 'bad timer value is rejected');
    ok(!defined($cmd), 'bad timer value clears command');

    main::readingsSingleUpdate($hash, MMSOMFY::Reading::movement(), MMSOMFY::Movement::up(), 1);
    $cmd = MMSOMFY::Command::go_my();
    $cmdarg = undef;
    $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);
    is($ret, undef, 'go_my while moving is accepted as replacement flow');
    is($cmd, MMSOMFY::Command::stop(), 'go_my is replaced by stop while moving');

    main::readingsSingleUpdate($hash, MMSOMFY::Reading::movement(), MMSOMFY::Movement::none(), 1);
    $cmd = MMSOMFY::Command::stop();
    $cmdarg = undef;
    $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);
    is($ret, undef, 'stop while not moving is silently ignored');
    ok(!defined($cmd), 'stop is cleared while not moving');

    $cmd = MMSOMFY::Command::manual();
    $cmdarg = 'x';
    $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);
    like($ret, qr/Bad position value/, 'manual command rejects invalid position value');

    $cmd = MMSOMFY::Command::z_custom();
    $cmdarg = 'XYZ';
    $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);
    like($ret, qr/2 digit hex codes only/, 'z_custom rejects invalid custom code');
};

# Test Description:
# - What: Validates go_my->stop rewrite order when go_my is not listed.
# - How: Leaves myPosition unset, marks movement as down, then checks go_my.
# - Steps: Runs Command::Check and inspects normalized command result.
# - Expectation: Command is rewritten to stop before command-list validation.
subtest 'go_my while moving is normalized before validation' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'command_go_my_prevalidate');
    $main::FHEM_Hash = $hash;

    my $mode = MMSOMFY::Mode::send();
    my $cmd = MMSOMFY::Command::go_my();
    my $cmdarg = undef;

    main::readingsSingleUpdate($hash, MMSOMFY::Reading::movement(), MMSOMFY::Movement::down(), 1);
    my $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);

    is($ret, undef, 'go_my while moving remains valid after normalization');
    is($cmd, MMSOMFY::Command::stop(), 'go_my is normalized to stop before list validation');
};

# Test Description:
# - What: Validates command restriction while interactive calibration is active.
# - How: Simulates CalibrationMode and checks published/validated command set.
# - Steps: Ensures open is blocked while calibrate_next and calibrate_abort stay valid.
# - Expectation: Only calibration flow commands are accepted in active calibration mode.
subtest 'active calibration restricts allowed commands' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'command_calibration_lock');
    $main::FHEM_Hash = $hash;

    $hash->{CalibrationMode} = 1;
    $hash->{CalibrationData} = { type => 'basic', step => 1, waitingForInput => 1 };

    my $commands = MMSOMFY::Command::ToString(' ', 1);
    like($commands, qr/\bcalibrate_next\b/, 'calibrate_next is published during active calibration');
    like($commands, qr/\bcalibrate_abort\b/, 'calibrate_abort is published during active calibration');
    unlike($commands, qr/\bopen\b/, 'open is hidden during active calibration');

    my $mode = MMSOMFY::Mode::send();
    my $cmd = MMSOMFY::Command::open();
    my $cmdarg = undef;
    my $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);
    like($ret, qr/calibrate_next/, 'blocked command returns restricted command list');
    ok(!defined($cmd), 'blocked command is cleared while calibration is active');
};

# Test Description:
# - What: Ensures calibration internals are present from device initialization.
# - How: Re-initializes a shutter device via DeviceModel::Initialize.
# - Steps: Checks default calibration internal values before any calibration run.
# - Expectation: Calibration internals exist and are reset to idle defaults.
subtest 'calibration internals exist from initialization' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'command_calibration_defaults', model => MMSOMFY::Model::shutter());
    $main::FHEM_Hash = $hash;

    MMSOMFY::DeviceModel::Initialize($hash->{ADDRESS}, MMSOMFY::Model::shutter(), undef, undef);

    is($hash->{MMSOMFY::Internal::CALIBRATION_STATE()}, 'idle', 'CALIBRATION_STATE defaults to idle');
    is($hash->{MMSOMFY::Internal::CALIBRATION_STEP()}, 0, 'CALIBRATION_STEP defaults to 0');
    is($hash->{MMSOMFY::Internal::CALIBRATION_CONFIRM_CMD()}, MMSOMFY::Command::calibrate(), 'CALIBRATION_CONFIRM_CMD defaults to calibrate');
};

# Test Description:
# - What: Validates malformed decode and unknown send error paths.
# - How: Decodes invalid short frame and sends unknown command.
# - Steps: Verifies empty decode result and explicit send error text.
# - Expectation: Both branches fail safely without crashes.
subtest 'Decode and Send2Device reject malformed input' => sub {
    my $caller = { NAME => 'io', TYPE => 'CUL' };
    my %decoded = MMSOMFY::Command::Decode($caller, 'YsAA2F18F00085');
    is(scalar(keys %decoded), 0, 'malformed frame is ignored');

    my $hash = MMSOMFY::TestHelper::make_device(name => 'command_unknown_send', address => '222222');
    $main::FHEM_Hash = $hash;
    my $ret = MMSOMFY::Command::Send2Device('not_a_command', undef);
    like($ret, qr/Unknown command 'not_a_command'/, 'Send2Device returns error for unknown command');
};

# Test Description:
# - What: Validates remote dispatch robustness without rawDevice attribute.
# - How: Calls DispatchRemote on remote hash missing rawDevice.
# - Steps: Executes dispatch in eval and checks exception state.
# - Expectation: Function completes without dying.
subtest 'DispatchRemote tolerates missing rawDevice' => sub {
    my $remote = MMSOMFY::TestHelper::make_device(
        name => 'remote_dispatch',
        model => MMSOMFY::Model::remote(),
        timing => MMSOMFY::Timing::off(),
        with_timings => 0,
    );

    my %cmd = (
        command => '20',
        command_desc => 'up',
        enc_key => 'AA',
        rolling_code => '0002',
        address => $remote->{ADDRESS},
    );

    eval { MMSOMFY::Command::DispatchRemote($remote, \%cmd); 1 };
    is($@, '', 'DispatchRemote does not die when rawDevice is not defined');
};

# Test Description:
# - What: Validates remote RTS code 10 My/Stop behavior during dispatch.
# - How: Dispatches code 10 to a linked shutter while idle and while moving.
# - Steps: Checks go_my execution when idle and stop conversion while moving.
# - Expectation: Idle starts go_my movement, moving state is canceled to stop.
subtest 'DispatchRemote maps code 10 to dynamic go_my/stop handling' => sub {
    my $remote = MMSOMFY::TestHelper::make_device(
        name => 'remote_cmd10',
        model => MMSOMFY::Model::remote(),
        timing => MMSOMFY::Timing::off(),
        address => '270507',
        with_timings => 0,
    );
    my $target = MMSOMFY::TestHelper::make_device(
        name => 'target_cmd10',
        model => MMSOMFY::Model::shutter(),
        address => 'FFFFFF',
        factor => 0.4,
    );

    $main::attr{$remote->{NAME}}{MMSOMFY::Attribute::rawDevice()} = 'FFFFFF';
    $main::attr{$target->{NAME}}{MMSOMFY::Attribute::myPosition()} = 20;

    my %cmd = (
        command => '10',
        command_desc => 'go_my',
        enc_key => 'AA',
        rolling_code => '0002',
        address => $remote->{ADDRESS},
    );

    MMSOMFY::Command::DispatchRemote($remote, \%cmd);
    is(
        main::ReadingsVal($target->{NAME}, MMSOMFY::Reading::movement(), undef),
        MMSOMFY::Movement::up(),
        'code 10 triggers go_my movement while idle'
    );

    main::readingsSingleUpdate($target, MMSOMFY::Reading::movement(), MMSOMFY::Movement::down(), 1);
    $target->{SimulationKey} = {
        StartTime => main::gettimeofday() - 1,
        StartFactor => 0.4,
        Command => MMSOMFY::Command::close(),
    };

    MMSOMFY::Command::DispatchRemote($remote, \%cmd);
    ok(!defined($target->{SimulationKey}), 'code 10 while moving cancels simulation as stop');
    is(
        main::ReadingsVal($target->{NAME}, MMSOMFY::Reading::movement(), undef),
        MMSOMFY::Movement::none(),
        'movement is set to none after stop conversion'
    );
};

done_testing;


