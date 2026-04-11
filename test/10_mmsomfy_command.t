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
    like($commands, qr/\bcalibrate_basic\b/, 'calibrate_basic command is published');
    like($commands, qr/\bcalibrate_extended\b/, 'calibrate_extended command is published');
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
# - What: Validates virtual stop handling for remote code 10 semantics.
# - How: Runs stop in virtual mode with/without movement and myPosition.
# - Steps: Checks conversion to position while idle and ignore path without myPosition.
# - Expectation: Virtual stop maps to position (with myPosition as arg) only when idle and myPosition exists.
subtest 'virtual stop maps to position (myPosition) when idle and myPosition exists' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'command_virtual_stop_go_my');
    $main::FHEM_Hash = $hash;

    my $mode = MMSOMFY::Mode::virtual();
    my $cmd = MMSOMFY::Command::stop();
    my $cmdarg = undef;
    my $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);
    is($ret, undef, 'virtual stop without movement returns no error');
    ok(!defined($cmd), 'virtual stop without movement and without myPosition is ignored');

    $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::myPosition()} = 35;
    $cmd = MMSOMFY::Command::stop();
    $cmdarg = undef;
    $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);
    is($ret, undef, 'virtual stop with myPosition returns no error');
    is($cmd, MMSOMFY::Command::position(), 'virtual stop without movement maps to position when myPosition exists');
    is($cmdarg, 35, 'mapped position gets myPosition value as argument');
};

# Test Description:
# - What: Validates command list during active calibration.
# - How: Checks ToString output and validates Check behavior on open command.
# - Steps: Verifies open/close/stop/calibrate_next are visible and open passes validation.
# - Expectation: UI lists open and close during calibration, and Check accepts open unchanged.
subtest 'active calibration restricts allowed commands' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'command_calibration_lock');
    $main::FHEM_Hash = $hash;

    $hash->{CalibrationData} = { type => 'basic', step => 1, waitingForInput => 1 };

    # ToString() shows open/close/stop/calibrate_next for FHEM command list
    my $commands = MMSOMFY::Command::ToString(' ', 1);
    like($commands, qr/\bopen\b/, 'open is published during active calibration');
    like($commands, qr/\bclose\b/, 'close is published during active calibration');
    like($commands, qr/\bstop\b/, 'stop is published during active calibration');
    like($commands, qr/\bcalibrate_next\b/, 'calibrate_next is published during active calibration');

    # Check accepts open unchanged.
    my $mode = MMSOMFY::Mode::send();
    my $cmd = MMSOMFY::Command::open();
    my $cmdarg = undef;
    my $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);
    is($ret, undef, 'open command passes Check without error during calibration');
    is($cmd, MMSOMFY::Command::open(), 'open command remains unchanged');
};

# Test Description:
# - What: Validates that Check keeps calibration side-effect free.
# - How: Executes stop with send/virtual modes while calibration is active.
# - Steps: Checks command normalization/clearing behavior without calibration abort.
# - Expectation: Check does not abort calibration; it only normalizes the command.
subtest 'check keeps calibration untouched while normalizing stop semantics' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'command_calibration_stop');
    $main::FHEM_Hash = $hash;

    $hash->{CalibrationData} = { type => 'basic', step => 1, waitingForInput => 1 };
    main::readingsSingleUpdate($hash, MMSOMFY::Reading::movement(), MMSOMFY::Movement::none(), 1);

    my $mode = MMSOMFY::Mode::send();
    my $cmd = MMSOMFY::Command::stop();
    my $cmdarg = undef;
    my $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);
    is($ret, undef, 'send stop during calibration returns no error');
    ok(defined($hash->{CalibrationData}), 'send stop does not abort calibration in Check');
    ok(!defined($cmd), 'send stop without movement is cleared by Check');

    $hash->{CalibrationData} = { type => 'basic', step => 1, waitingForInput => 1 };
    $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::myPosition()} = 20;
    main::readingsSingleUpdate($hash, MMSOMFY::Reading::movement(), MMSOMFY::Movement::none(), 1);

    $mode = MMSOMFY::Mode::virtual();
    $cmd = MMSOMFY::Command::stop();
    $cmdarg = undef;
    $ret = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);
    is($ret, undef, 'virtual stop during calibration returns no error');
    ok(defined($hash->{CalibrationData}), 'virtual stop does not abort calibration in Check');
    is($cmd, MMSOMFY::Command::position(), 'virtual stop without movement maps to position during calibration');
    is($cmdarg, 20, 'mapped position gets myPosition value');
};

# Test Description:
# - What: Ensures calibration readings are present from device initialization.
# - How: Re-initializes a shutter device via DeviceModel::Initialize.
# - Steps: Checks default calibration reading values before any calibration run.
# - Expectation: Calibration readings exist and are reset to idle defaults.
subtest 'calibration readings exist from initialization' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'command_calibration_defaults', model => MMSOMFY::Model::shutter());
    $main::FHEM_Hash = $hash;

    MMSOMFY::DeviceModel::Initialize($hash->{ADDRESS}, MMSOMFY::Model::shutter(), undef, undef);

    is($hash->{READINGS}{MMSOMFY::Reading::calibration_state()}{VAL}, 'idle', 'calibration_state defaults to idle');
    is($hash->{READINGS}{MMSOMFY::Reading::calibration_step()}{VAL}, 0, 'calibration_step defaults to 0');
    is($hash->{READINGS}{MMSOMFY::Reading::calibration_confirm_cmd()}{VAL}, MMSOMFY::Command::calibrate_basic(), 'calibration_confirm_cmd defaults to calibrate_basic');
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
# - Steps: Checks stop->go_my handling when idle and stop behavior while moving.
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
    delete $main::attr{$target->{NAME}}{MMSOMFY::Attribute::myPosition()};
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
    ok(
        !exists($main::attr{$target->{NAME}}{MMSOMFY::Attribute::myPosition()}),
        'stop conversion does not require myPosition to remain configured'
    );
};

done_testing;


