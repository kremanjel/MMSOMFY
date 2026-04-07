use strict;
use warnings;
use Test2::V1 "-import";

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates basic timing accessor behavior.
# - How: Reads timing values from a device configured with basic timing.
# - Steps: Queries Closed2Opened, Opened2Closed and Closed2Down.
# - Expectation: Basic values are available, extended-only accessor is undef.
subtest 'basic timing accessors' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'timing_basic',
        timing => MMSOMFY::Timing::basic(),
        drive_closed_to_opened => 14,
        drive_opened_to_closed => 11,
    );

    is(MMSOMFY::Timing::Closed2Opened($hash), 14, 'Closed2Opened reads configured value');
    is(MMSOMFY::Timing::Opened2Closed($hash), 11, 'Opened2Closed reads configured value');
    is(MMSOMFY::Timing::Closed2Down($hash), undef, 'Closed2Down is unavailable in basic timing mode');
};

# Test Description:
# - What: Validates extended timing accessors and derived values.
# - How: Uses device with all extended timing attributes populated.
# - Steps: Reads derived segments and runs ValidateTimingAttributes.
# - Expectation: Derived values are consistent and validation succeeds.
subtest 'extended timing accessors and validation' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'timing_extended',
        timing => MMSOMFY::Timing::extended(),
        drive_closed_to_opened => 14,
        drive_opened_to_closed => 11,
        drive_down_to_opened => 4,
        drive_opened_to_down => 8,
    );

    is(MMSOMFY::Timing::Closed2Down($hash), 10, 'Closed2Down is derived from Closed2Opened and Down2Opened');
    is(MMSOMFY::Timing::Down2Opened($hash), 4, 'Down2Opened reads configured value');
    is(MMSOMFY::Timing::Opened2Down($hash), 8, 'Opened2Down reads configured value');
    is(MMSOMFY::Timing::Down2Closed($hash), 3, 'Down2Closed is derived from Opened2Closed and Opened2Down');
    ok(MMSOMFY::Timing::ValidateTimingAttributes($hash), 'consistent extended timing passes validation');
};

# Test Description:
# - What: Validates rejection of inconsistent timing configurations.
# - How: Runs ValidateTimingAttributes on impossible extended timings.
# - Steps: Uses contradictory timing values for derived segments.
# - Expectation: Validation returns false.
subtest 'timing validation rejects impossible data' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'timing_invalid',
        timing => MMSOMFY::Timing::extended(),
        drive_closed_to_opened => 3,
        drive_opened_to_closed => 2,
        drive_down_to_opened => 4,
        drive_opened_to_down => 8,
    );

    ok(!MMSOMFY::Timing::ValidateTimingAttributes($hash), 'inconsistent timing data is rejected');
};

# Test Description:
# - What: Validates CheckTiming edge and error paths.
# - How: Calls CheckTiming with multiple operators and value types.
# - Steps: Covers valid numeric, relation errors, non-numeric and bad operator.
# - Expectation: Accepted values normalize and invalid inputs return errors.
subtest 'CheckTiming handles operator and value edge cases' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'timing_check');

    my $value = 1.234;
    my $err = MMSOMFY::Timing::CheckTiming('x', $value, 'y', 5, 'smaller', $hash);
    is($err, undef, 'numeric value with smaller relation is valid');
    is($value, '1.2', 'numeric value is normalized to one decimal place');

    $value = 5;
    $err = MMSOMFY::Timing::CheckTiming('x', $value, 'y', 4, 'smaller', $hash);
    like($err, qr/must be smaller/, 'smaller relation violations are rejected');

    $value = 1;
    $err = MMSOMFY::Timing::CheckTiming('x', $value, 'y', 2, 'greater', $hash);
    like($err, qr/must be greater/, 'greater relation violations are rejected');

    $value = 0;
    $err = MMSOMFY::Timing::CheckTiming('x', $value, 'y', undef, 'greater', $hash);
    like($err, qr/must be greater 0/, 'non-positive values are rejected');

    $value = 'abc';
    $err = MMSOMFY::Timing::CheckTiming('x', $value, 'y', undef, 'greater', $hash);
    like($err, qr/is not numeric/, 'non-numeric values are rejected');

    $value = 1;
    $err = MMSOMFY::Timing::CheckTiming('x', $value, 'y', undef, 'invalid', $hash);
    like($err, qr/Operator 'invalid' is unknown/, 'unknown operators are rejected');
};

# Test Description:
# - What: Validates accessor behavior when timing mode is off.
# - How: Calls timing getters on off-mode device.
# - Steps: Reads Opened2Closed, Closed2Opened and Opened2Down.
# - Expectation: Accessors return undef while timing is off.
subtest 'off timing returns undef for accessors' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'timing_off',
        timing => MMSOMFY::Timing::off(),
        with_timings => 1,
    );

    is(MMSOMFY::Timing::Opened2Closed($hash), undef, 'Opened2Closed is undefined in off mode');
    is(MMSOMFY::Timing::Closed2Opened($hash), undef, 'Closed2Opened is undefined in off mode');
    is(MMSOMFY::Timing::Opened2Down($hash), undef, 'Opened2Down is undefined in off mode');
};

done_testing;


