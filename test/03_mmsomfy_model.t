use strict;
use warnings;
use Test2::V1 "-import";

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates constants in package MMSOMFY::Model.
# - How: Compares all public accessors and checks deterministic serialization.
# - Steps: Read awning/shutter/remote/switch and call ToString.
# - Expectation: Stable API values and deterministic enum string.
subtest 'model constants and list' => sub {
    is(MMSOMFY::Model::awning(), 'awning', 'awning constant is stable');
    is(MMSOMFY::Model::shutter(), 'shutter', 'shutter constant is stable');
    is(MMSOMFY::Model::remote(), 'remote', 'remote constant is stable');
    is(MMSOMFY::Model::switch(), 'switch', 'switch constant is stable');
    is(MMSOMFY::Model::ToString(','), 'awning,remote,shutter,switch', 'model list is serialized');
};

done_testing;


