use strict;
use warnings;
use Test2::V1 "-import";

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates constants in package MMSOMFY::Movement.
# - How: Compares all public accessors and checks deterministic serialization.
# - Steps: Read none/go_my/up/down and inspect ToString output.
# - Expectation: Stable API values and deterministic enum string.
subtest 'movement constants and list' => sub {
    is(MMSOMFY::Movement::none(), 'none', 'none constant is stable');
    is(MMSOMFY::Movement::go_my(), 'go_my', 'go_my constant is stable');
    is(MMSOMFY::Movement::up(), 'up', 'up constant is stable');
    is(MMSOMFY::Movement::down(), 'down', 'down constant is stable');
    is(MMSOMFY::Movement::ToString(','), 'down,go_my,none,up', 'movement list is serialized');
};

done_testing;


