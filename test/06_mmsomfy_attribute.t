use strict;
use warnings;
use Test2::V1 "-import";

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates myPosition input constraints.
# - How: Calls CheckAttribute with valid and invalid myPosition values.
# - Steps: Tests out-of-range and float normalization behavior.
# - Expectation: Invalid values are rejected and valid floats are rounded.
subtest 'myPosition validation and normalization' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'attr_shutter');

    my $out_of_range = MMSOMFY::Position::ENDPOS() + 1;
    my $err = MMSOMFY::Attribute::CheckAttribute('set', MMSOMFY::Attribute::myPosition(), $out_of_range, 1, $hash);
    like($err, qr/must be between '0' and '100'/, 'myPosition rejects values above ENDPOS');

    my $my_pos = 42.7;
    $err = MMSOMFY::Attribute::CheckAttribute('set', MMSOMFY::Attribute::myPosition(), $my_pos, 1, $hash);
    is($err, undef, 'valid myPosition is accepted');
    is($my_pos, 43, 'myPosition is normalized to integer');
};

# Test Description:
# - What: Validates positionInverse value domain.
# - How: Calls CheckAttribute with accepted and rejected values.
# - Steps: Tests 2 as invalid and 1 as valid input.
# - Expectation: Only 0/1 are accepted.
subtest 'positionInverse validation' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'attr_inverse');

    my $err = MMSOMFY::Attribute::CheckAttribute('set', MMSOMFY::Attribute::positionInverse(), 2, 1, $hash);
    like($err, qr/must be 0 or 1/, 'positionInverse only accepts 0 or 1');

    $err = MMSOMFY::Attribute::CheckAttribute('set', MMSOMFY::Attribute::positionInverse(), 1, 1, $hash);
    is($err, undef, 'positionInverse accepts 1 for shutter devices');
};

# Test Description:
# - What: Validates model restrictions for myPosition.
# - How: Evaluates myPosition on a remote model.
# - Steps: Calls CheckAttribute with remote hash and numeric value.
# - Expectation: Remote devices reject shutter/awning-only attributes.
subtest 'model restrictions are enforced' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'attr_remote',
        model => MMSOMFY::Model::remote(),
        with_timings => 0,
        timing => MMSOMFY::Timing::off(),
    );

    my $err = MMSOMFY::Attribute::CheckAttribute('set', MMSOMFY::Attribute::myPosition(), 10, 1, $hash);
    like($err, qr/supported for MODEL shutter and awning only/, 'myPosition stays unavailable on remotes');
};

# Test Description:
# - What: Validates protection of webCmd and userattr after init.
# - How: Calls CheckAttribute with init_done true and false.
# - Steps: Tests rejection post-init and normalization during init.
# - Expectation: Post-init edits fail, init-time value normalization succeeds.
subtest 'webCmd and userattr are protected after init' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'attr_protected');
    $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::webCmd()} = 'open:close';
    $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::userattr()} = 'foo';

    my $web_cmd = 'legacy';
    my $err = MMSOMFY::Attribute::CheckAttribute('set', MMSOMFY::Attribute::webCmd(), $web_cmd, 1, $hash);
    like($err, qr/cannot be modified/, 'webCmd cannot be changed after init');

    my $userattr = 'legacy';
    $err = MMSOMFY::Attribute::CheckAttribute('set', MMSOMFY::Attribute::userattr(), $userattr, 1, $hash);
    like($err, qr/cannot be modified/, 'userattr cannot be changed after init');

    my $during_init = 'legacy';
    $err = MMSOMFY::Attribute::CheckAttribute('set', MMSOMFY::Attribute::webCmd(), $during_init, 0, $hash);
    is($err, undef, 'webCmd check during init is accepted');
    is($during_init, 'open:close', 'webCmd value is normalized to current attribute during init');
};

# Test Description:
# - What: Validates remote state transitions for ignore/disable attrs.
# - How: Calls CheckAttribute on ignore/disable with remote model.
# - Steps: Applies 1 and 0 values and checks resulting STATE.
# - Expectation: State switches to ignored/disabled/receiving as defined.
subtest 'remote ignore and disable update state' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(
        name => 'attr_remote_states',
        model => MMSOMFY::Model::remote(),
        with_timings => 0,
        timing => MMSOMFY::Timing::off(),
    );

    my $err = MMSOMFY::Attribute::CheckAttribute('set', MMSOMFY::Attribute::ignore(), 1, 1, $hash);
    is($err, undef, 'ignore=1 accepted');
    is($hash->{STATE}, MMSOMFY::State::ignored(), 'ignore=1 sets ignored state');

    $err = MMSOMFY::Attribute::CheckAttribute('set', MMSOMFY::Attribute::disable(), 1, 1, $hash);
    is($err, undef, 'disable=1 accepted');
    is($hash->{STATE}, MMSOMFY::State::disabled(), 'disable=1 sets disabled state');

    $err = MMSOMFY::Attribute::CheckAttribute('set', MMSOMFY::Attribute::ignore(), 0, 1, $hash);
    is($err, undef, 'ignore=0 accepted');
    is($hash->{STATE}, MMSOMFY::State::receiving(), 'ignore=0 sets receiving state');
};

done_testing;


