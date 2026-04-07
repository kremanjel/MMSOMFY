use strict;
use warnings;
use Test2::V1 "-import";
no warnings 'once';

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates callback wiring in module initialization.
# - How: Calls MMSOMFY_Initialize on fresh hash.
# - Steps: Verifies DefFn/SetFn/AttrFn/ParseFn assignments.
# - Expectation: Main callbacks are registered to expected symbols.
subtest 'initialize wires core callbacks' => sub {
    my $hash = {};

    MMSOMFY_Initialize($hash);

    is($hash->{DefFn}, 'MMSOMFY_Define', 'DefFn is registered');
    is($hash->{SetFn}, 'MMSOMFY_Set', 'SetFn is registered');
    is($hash->{AttrFn}, 'MMSOMFY_Attr', 'AttrFn is registered');
    is($hash->{ParseFn}, 'MMSOMFY_Parse', 'ParseFn is registered');
};

# Test Description:
# - What: Validates define input rejection for malformed definitions.
# - How: Calls MMSOMFY_Define with invalid address and model.
# - Steps: Compares return strings against expected error patterns.
# - Expectation: Invalid inputs are rejected with specific diagnostics.
subtest 'define rejects malformed addresses and models' => sub {
    my $hash = { NAME => 'logical' };
    local $main::FHEM_Hash = $hash;

    my $ret = MMSOMFY_Define($hash, 'logical MMSOMFY 12345 shutter');
    like($ret, qr/Wrong format of <address>/, 'invalid addresses are rejected');

    $ret = MMSOMFY_Define($hash, 'logical MMSOMFY 123456 invalidModel');
    like($ret, qr/Unknown <model>/, 'unknown models are rejected');
};

# Test Description:
# - What: Validates successful define path for a valid declaration.
# - How: Calls MMSOMFY_Define with valid shutter definition.
# - Steps: Checks undef return and normalized address assignment.
# - Expectation: Device definition is accepted and address stored.
subtest 'define accepts valid base definition' => sub {
    my $hash = { NAME => 'logical' };
    local $main::FHEM_Hash = $hash;

    my $ret = MMSOMFY_Define($hash, 'logical MMSOMFY 123456 shutter');
    is($ret, undef, 'valid device definition is accepted');
    is($hash->{ADDRESS}, '123456', 'address is stored in the device hash');
};

# Test Description:
# - What: Validates Attr dispatch behavior for missing and known devices.
# - How: Calls MMSOMFY_Attr with invalid device then with prepared hash.
# - Steps: Checks missing-device error and successful delegated validation.
# - Expectation: Unknown device fails, known device passes.
subtest 'attr returns useful error for missing device and validates known device' => sub {
    my $ret = MMSOMFY_Attr('set', 'missing_device', MMSOMFY::Attribute::myPosition(), 50);
    like($ret, qr/does not exist/, 'missing device is rejected by Attr');

    my $hash = MMSOMFY::TestHelper::make_device(name => 'attr_main');
    $main::defs{$hash->{NAME}} = $hash;
    my $attr_value = 30;
    $ret = MMSOMFY_Attr('set', $hash->{NAME}, MMSOMFY::Attribute::myPosition(), $attr_value);
    is($ret, undef, 'valid Attr invocation delegates to package validation');
};

# Test Description:
# - What: Validates Parse fallback for unknown addresses.
# - How: Parses a valid frame without matching defptr device.
# - Steps: Reads returned UNDEFINED helper command.
# - Expectation: Parse returns define hint for remote creation.
subtest 'parse returns UNDEFINED for unknown addresses' => sub {
    my $caller = { NAME => 'io_parse', TYPE => 'CUL' };
    my $ret = MMSOMFY_Parse($caller, 'YsAA2F18F00085E8');
    like($ret, qr/^UNDEFINED MMSOMFY_E88500 MMSOMFY E88500 remote$/, 'unknown parsed address yields UNDEFINED hint');
};

# Test Description:
# - What: Validates Parse update path for known remote device.
# - How: Defines matching remote and parses incoming frame.
# - Steps: Checks affected device list and updated readings.
# - Expectation: Parse updates remote readings and returns device name.
subtest 'parse updates known remote and returns affected list' => sub {
    my $remote = MMSOMFY::TestHelper::make_device(
        name => 'parse_remote',
        model => MMSOMFY::Model::remote(),
        address => 'E88500',
        timing => MMSOMFY::Timing::off(),
        with_timings => 0,
    );

    my $caller = { NAME => 'io_parse_known', TYPE => 'CUL' };
    my $ret = MMSOMFY_Parse($caller, 'YsAA2F18F00085E8');

    is($ret, 'parse_remote', 'parse returns list with affected remote');
    is($remote->{READINGS}{enc_key}{VAL}, 'AA', 'parse updates enc_key reading');
    is($remote->{READINGS}{rolling_code}{VAL}, '18F0', 'parse updates rolling_code reading');
    is($remote->{READINGS}{received}{VAL}, '20', 'parse stores received command code');
};

# Test Description:
# - What: Validates Set behavior in send and virtual modes.
# - How: Calls MMSOMFY_Set with implicit send and explicit virtual mode.
# - Steps: Executes on/off and verifies resulting switch state.
# - Expectation: Both paths succeed and update modeled state consistently.
subtest 'set supports default send mode and virtual mode' => sub {
    my $switch = MMSOMFY::TestHelper::make_device(
        name => 'set_switch',
        model => MMSOMFY::Model::switch(),
        timing => MMSOMFY::Timing::off(),
        with_timings => 0,
    );
    $switch->{IODev} = { TYPE => 'CUL', NAME => 'mock_io' };

    my $ret = MMSOMFY_Set($switch, $switch->{NAME}, 'on');
    is($ret, undef, 'set on succeeds with implicit send mode');
    is($switch->{STATE}, MMSOMFY::State::on(), 'set on updates switch state');

    $ret = MMSOMFY_Set($switch, $switch->{NAME}, MMSOMFY::Mode::virtual(), 'off');
    is($ret, undef, 'set off succeeds in virtual mode');
    is($switch->{STATE}, MMSOMFY::State::off(), 'virtual set still updates model state');
};

done_testing;


