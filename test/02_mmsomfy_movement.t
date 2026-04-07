use strict;
use warnings;
use Test2::V1 "-import";

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates constants in package MMSOMFY::Movement.
# - How: Compares fixed accessor values and checks list content.
# - Steps: Read none/up and inspect ToString output.
# - Expectation: Known movement values stay stable and include go_my.
subtest 'movement constants and list' => sub {
    is(MMSOMFY::Movement::none(), 'none', 'none constant is stable');
    is(MMSOMFY::Movement::up(), 'up', 'up constant is stable');
    like(MMSOMFY::Movement::ToString(' '), qr/\bgo_my\b/, 'movement list contains go_my');
};

done_testing;


