use strict;
use warnings;
use Test2::V1 "-import";

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates constants in package MMSOMFY::Model.
# - How: Compares exposed model accessors and serialized enum content.
# - Steps: Read shutter/awning/switch/remote and call ToString.
# - Expectation: Model constants remain unchanged and discoverable.
subtest 'model constants and list' => sub {
    is(MMSOMFY::Model::shutter(), 'shutter', 'shutter constant is stable');
    is(MMSOMFY::Model::remote(), 'remote', 'remote constant is stable');
    like(MMSOMFY::Model::ToString(','), qr/awning/, 'model list contains awning');
    like(MMSOMFY::Model::ToString(','), qr/switch/, 'model list contains switch');
};

done_testing;


