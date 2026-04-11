use strict;
use warnings;
use Test2::V1 "-import";

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates constants in package MMSOMFY::State.
# - How: Checks all public accessors and deterministic enum serialization.
# - Steps: Read every state constant and inspect ToString output.
# - Expectation: Stable API values and deterministic enum string.
subtest 'state constants and list' => sub {
    is(MMSOMFY::State::disabled(), 'disabled', 'disabled constant is stable');
    is(MMSOMFY::State::opened(), 'opened', 'opened constant is stable');
    is(MMSOMFY::State::closed(), 'closed', 'closed constant is stable');
    is(MMSOMFY::State::ignored(), 'ignored', 'ignored constant is stable');
    is(MMSOMFY::State::off(), 'off', 'off constant is stable');
    is(MMSOMFY::State::on(), 'on', 'on constant is stable');
    is(MMSOMFY::State::receiving(), 'receiving', 'receiving constant is stable');
    is(MMSOMFY::State::unknown(), 'unknown', 'unknown constant is stable');
    is(MMSOMFY::State::ToString(','), 'closed,disabled,ignored,off,on,opened,receiving,unknown', 'state list is serialized');
};

done_testing;


