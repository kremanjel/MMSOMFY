package MMSOMFY::TestHelper;

use strict;
use warnings;

use lib 'test/lib';

our $MODULE_LOADED = 0;

sub load_module {
    require 'FhemMock.pm';
    main::FhemMock_Init();

    if (!$MODULE_LOADED) {
        require './10_MMSOMFY.pm';
        $MODULE_LOADED = 1;
    }

    main::FhemMock_Reset();
}

sub make_device {
    my (%args) = @_;

    my $name = $args{name} // 'device';
    my $model = $args{model} // MMSOMFY::Model::shutter();
    my $timing = $args{timing} // MMSOMFY::Timing::basic();
    my $address = $args{address} // 'ABCDEF';
    my $factor = defined($args{factor}) ? $args{factor} : 0.4;
    my $movement = $args{movement} // MMSOMFY::Movement::none();

    my $hash = {
        NAME => $name,
        STATE => MMSOMFY::State::opened(),
        READINGS => {
            factor => { VAL => $factor },
            movement => { VAL => $movement },
        },
    };

    $hash->{MMSOMFY::Internal::MODEL()} = $model;
    $hash->{MMSOMFY::Internal::TIMING()} = $timing;
    $hash->{ADDRESS} = $address;

    $main::defs{$name} = $hash;
    $main::FHEM_Hash = $hash;
    $main::modules{MMSOMFY}{defptr}{$address}{$name} = $hash;

    if (!exists $args{with_timings} || $args{with_timings}) {
        $main::attr{$name}{MMSOMFY::Attribute::driveTimeClosedToOpened()} = $args{drive_closed_to_opened} // 12.0;
        $main::attr{$name}{MMSOMFY::Attribute::driveTimeOpenedToClosed()} = $args{drive_opened_to_closed} // 12.0;
        $main::attr{$name}{MMSOMFY::Attribute::driveTimeDownToOpened()} = $args{drive_down_to_opened} // 4.0;
        $main::attr{$name}{MMSOMFY::Attribute::driveTimeOpenedToDown()} = $args{drive_opened_to_down} // 8.0;
    }

    return $hash;
}

1;