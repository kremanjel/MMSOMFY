package main;

use strict;
use warnings;

sub SetExtensions {
    my ($hash, $list, $name, $cmd, @rest) = @_;
    return "choose one of $list" if defined($cmd) && $cmd eq "?";
    return "Unknown argument $cmd, choose one of $list";
}

sub SetExtensionsCancel {
    return;
}

1;
