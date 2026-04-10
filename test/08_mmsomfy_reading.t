use strict;
use warnings;
use Test2::V1 "-import";
no warnings 'once';

use lib 'test/lib';
require 'MMSOMFY/TestHelper.pm';
MMSOMFY::TestHelper::load_module();

# Test Description:
# - What: Validates standard PositionUpdate reading writes.
# - How: Calls PositionUpdate with non-inverted configuration.
# - Steps: Verifies factor, position and movement reading values.
# - Expectation: Readings reflect direct factor-to-position mapping.
subtest 'PositionUpdate stores factor, position and movement' => sub {
    my $hash = MMSOMFY::TestHelper::make_device(name => 'reading_plain');

    MMSOMFY::Reading::PositionUpdate(0.25, MMSOMFY::Movement::up(), $hash);

    is($hash->{READINGS}{factor}{VAL}, 0.25, 'factor reading is updated');
    is($hash->{READINGS}{position}{VAL}, 25, 'position reading reflects factor in normal mode');
    is($hash->{READINGS}{movement}{VAL}, MMSOMFY::Movement::up(), 'movement reading is updated');
};

done_testing;


