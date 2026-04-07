use strict;
use warnings;
use Test2::V1 "-import";

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates constants in package MMSOMFY::Position.
# - How: Reads exported constants directly.
# - Steps: Check STARTPOS, ENDPOS and RANGE.
# - Expectation: Position frame remains 0..100 with range 100.
subtest 'position constants' => sub {
    is(MMSOMFY::Position::STARTPOS(), 0, 'STARTPOS is 0');
    is(MMSOMFY::Position::ENDPOS(), 100, 'ENDPOS is 100');
    is(MMSOMFY::Position::RANGE(), 100, 'RANGE is 100');
};

done_testing;


