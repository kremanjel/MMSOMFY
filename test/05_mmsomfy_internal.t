use strict;
use warnings;
use Test2::V1 "-import";

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates helpers in package MMSOMFY::Internal.
# - How: Checks constants, ToString output and Clear behavior.
# - Steps: Create a device hash, seed internal keys, call Clear.
# - Expectation: Internal keys are exposed and removable.
subtest 'internal constants and clear' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'internal_case');

    is(MMSOMFY::Internal::MODEL(), 'MODEL', 'MODEL key is stable');
    is(MMSOMFY::Internal::TIMING(), 'TIMING', 'TIMING key is stable');
    like(MMSOMFY::Internal::ToString(','), qr/MODEL/, 'internal list contains MODEL');

    $hash->{MMSOMFY::Internal::MODEL()} = MMSOMFY::Model::awning();
    $hash->{MMSOMFY::Internal::TIMING()} = MMSOMFY::Timing::basic();
    MMSOMFY::Internal::Clear($hash);

    ok(!exists $hash->{MMSOMFY::Internal::MODEL()}, 'Clear removes MODEL key');
    ok(!exists $hash->{MMSOMFY::Internal::TIMING()}, 'Clear removes TIMING key');
};

done_testing;


