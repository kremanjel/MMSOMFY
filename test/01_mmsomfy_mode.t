use strict;
use warnings;
use Test2::V1 "-import";

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates constants in package MMSOMFY::Mode.
# - How: Compares public constant accessors and ToString output.
# - Steps: Read virtual/send and serialize the enum.
# - Expectation: Stable API values and deterministic enum string.
subtest 'mode constants and list' => sub {
    is(MMSOMFY::Mode::virtual(), 'virtual', 'virtual constant is stable');
    is(MMSOMFY::Mode::send(), 'send', 'send constant is stable');
    is(MMSOMFY::Mode::ToString(','), 'send,virtual', 'mode list is serialized');
};

done_testing;


