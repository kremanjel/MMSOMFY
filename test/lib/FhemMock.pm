package main;

use strict;
use warnings;

our %FHEM_MOCK_KEYSTORE;
our @FHEM_MOCK_TIMERS;
our @FHEM_MOCK_IOWRITES;

sub FhemMock_Reset {
    our (%defs, %attr, %modules, $init_done, $readingFnAttributes, $FW_addJs, $FHEM_Hash);
    %defs = ();
    %attr = ();
    %modules = ();
    $init_done = 1;
    $readingFnAttributes = '';
    $FW_addJs = undef;
    $FHEM_Hash = undef;
    %FHEM_MOCK_KEYSTORE = ();
    @FHEM_MOCK_TIMERS = ();
    @FHEM_MOCK_IOWRITES = ();
}

sub FhemMock_Init {
    our (%defs, %attr, %modules, $init_done, $readingFnAttributes, $FW_addJs, $FHEM_Hash);
    $init_done = 1;
    $readingFnAttributes = '';

    no warnings 'redefine';

    *Log3 = sub { return; };
    *IsIgnored = sub { return 0; };
    *IsDisabled = sub { return 0; };
    *addToDevAttrList = sub { return; };
    *TimeNow = sub { return 'now'; };
    *FmtDateTime = sub { return '1970-01-01 00:00:00'; };
    *AssignIoPort = sub { return; };
    *AnalyzeCommand = sub { return ''; };
    *DoTrigger = sub { return; };
    *RemoveInternalTimer = sub { return; };
    *InternalTimer = sub {
        my ($when, $fn, $arg, $repeat) = @_;
        push @FHEM_MOCK_TIMERS, {
            when => $when,
            fn => $fn,
            arg => $arg,
            repeat => $repeat,
        };
        return;
    };
    *gettimeofday = sub {
        my $now = time();
        return wantarray ? ($now, 0) : $now;
    };

    *AttrVal = sub {
        my ($devName, $attrName, $default) = @_;
        return exists $attr{$devName} && exists $attr{$devName}{$attrName}
            ? $attr{$devName}{$attrName}
            : $default;
    };

    *ReadingsVal = sub {
        my ($devName, $reading, $default) = @_;
        return exists $defs{$devName}
            && exists $defs{$devName}{READINGS}
            && exists $defs{$devName}{READINGS}{$reading}
            && exists $defs{$devName}{READINGS}{$reading}{VAL}
            ? $defs{$devName}{READINGS}{$reading}{VAL}
            : $default;
    };

    *readingsBeginUpdate = sub { return; };
    *readingsEndUpdate = sub { return; };

    *readingsBulkUpdate = sub {
        my ($hash, $reading, $value) = @_;
        $hash->{READINGS}{$reading}{VAL} = $value;
    };

    *readingsSingleUpdate = sub {
        my ($hash, $reading, $value) = @_;
        $hash->{READINGS}{$reading}{VAL} = $value;
    };

    *readingsDelete = sub {
        my ($hash, $reading) = @_;
        delete $hash->{READINGS}{$reading};
    };

    *setReadingsVal = sub {
        my ($hash, $reading, $value) = @_;
        $hash->{READINGS}{$reading}{VAL} = $value;
    };

    *IOWrite = sub {
        my ($hash, @payload) = @_;
        push @FHEM_MOCK_IOWRITES, {
            hash => $hash,
            payload => [@payload],
        };
        return;
    };

    *CallFn = sub { return undef; };
    *CommandSave = sub { return undef; };
    *setKeyValue = sub {
        my ($key, $value) = @_;
        $FHEM_MOCK_KEYSTORE{$key} = $value;
        return undef;
    };
    *getKeyValue = sub {
        my ($key) = @_;
        return (undef, $FHEM_MOCK_KEYSTORE{$key});
    };
    *minNum = sub {
        my ($a, $b) = @_;
        return $a < $b ? $a : $b;
    };
    *maxNum = sub {
        my ($a, $b) = @_;
        return $a > $b ? $a : $b;
    };

    FhemMock_Reset();
}

1;