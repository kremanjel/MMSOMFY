use strict;
use warnings;
use Test2::V1 "-import";

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates constants in package MMSOMFY::State.
# - How: Checks representative fixed values and enum serialization.
# - Steps: Read opened/closed/on/off and inspect ToString content.
# - Expectation: State constants stay backward compatible.
subtest 'state constants and list' => sub {
    is(MMSOMFY::State::opened(), 'opened', 'opened constant is stable');
    is(MMSOMFY::State::closed(), 'closed', 'closed constant is stable');
    is(MMSOMFY::State::on(), 'on', 'on constant is stable');
    is(MMSOMFY::State::off(), 'off', 'off constant is stable');
    like(MMSOMFY::State::ToString(','), qr/receiving/, 'state list contains receiving');
};

done_testing;


