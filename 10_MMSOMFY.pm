################################################################################
#
#     10_MMSOMFY.pm
#
#     This file is part of Fhem.
#
#     Fhem is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 2 of the License, or
#     (at your option) any later version.
#
#     Fhem is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with Fhem.  If not, see <http://www.gnu.org/licenses/>.
#
################################################################################
#
# MMSOMFY RTS / Simu Hz protocol module for FHEM
# (c) Jan Merkel
# Based on

# SOMFY RTS / Simu Hz protocol module for FHEM
# (c) Johannes Viegener / https://github.com/viegener/Telegram-fhem/tree/master/Somfy
#
# Discussed in FHEM Forum: https://forum.fhem.de/index.php/topic,53319.msg450080.html#msg450080
#
################################################################################

# Enumeration implementation for MMSOMFY::Mode
package MMSOMFY::Mode;

    use strict;
    use warnings;

    #enumeration items
    use constant {
        virtual => "virtual",
        send => "send",
    };

    # Get string with all items of enumeratione separated by given character
    # If separation charcter is not set space will be used.
    sub ToString {
        my ($sepChar) = @_;
        $sepChar = " " unless defined $sepChar;

        no strict 'refs';
        my $pkg = __PACKAGE__;
        my $stash = $pkg . "::";
        my @consts;

        for my $name (sort keys %$stash)
        {
            ### is it a subentry?
            my $sub = $pkg->can($name);
            next unless defined $sub;
            next unless defined prototype($sub) and not length prototype($sub);
            push @consts, $name;
        }

        return join($sepChar, @consts);
    }

1;

################################################################################

# Enumeration implementation for MMSOMFY::Movement
package MMSOMFY::Movement;

    use strict;
    use warnings;

    # enumeration items
    use constant {
        none => "none",
        go_my => "go_my",
        up => "up",
        down => "down",
    };

    # Get string with all items and values of enumeratione separated by given character.
    # If separation charcter is not set space will be used.
    sub ToString {
        my ($sepChar) = @_;
        $sepChar = " " unless defined $sepChar;

        no strict 'refs';
        my $pkg = __PACKAGE__;
        my $stash = $pkg . "::";
        my @consts;

        for my $name (sort keys %$stash)
        {
            ### is it a subentry?
            my $sub = $pkg->can($name);
            next unless defined $sub;
            next unless defined prototype($sub) and not length prototype($sub);
            push @consts, $name;
        }

        return join($sepChar, @consts);
    }

1;

################################################################################

# Enumeration implementation for MMSOMFY::Model
package MMSOMFY::Model;

    use strict;
    use warnings;

    #enumeration items
    use constant {
        awning => 'awning',
        shutter => 'shutter',
        remote => 'remote',
        switch => 'switch',
    };

    # Get string with all items of enumeratione separated by given character.
    # If separation charcter is not set space will be used.
    sub ToString {
        my ($sepChar) = @_;
        $sepChar = " " unless defined $sepChar;

        no strict 'refs';
        my $pkg = __PACKAGE__;
        my $stash = $pkg . "::";
        my @consts;

        for my $name (sort keys %$stash)
        {
            ### is it a subentry?
            my $sub = $pkg->can($name);
            next unless defined $sub;
            next unless defined prototype($sub) and not length prototype($sub);
            push @consts, $name;
        }

        return join($sepChar, @consts);
    }

1;

################################################################################

# Enumeration implementation for MMSOMFY::State
package MMSOMFY::State;

    use strict;
    use warnings;

    # enumeration items
    use constant {
        movingup => "movingup",
        movingdown => "movingdown",
        mypos => "mypos",
        opened => "opened",
        off => "off",
        down => "down",
        closed => "closed",
        on => "on",
        position => "position",
        receiving => "receiving",
        ignored => "ignored",
        unknown => "unknown",
    };

    # Get string with all items of enumeratione separated by given character.
    # If separation charcter is not set space will be used.
    sub ToString {
        my ($sepChar) = @_;
        $sepChar = " " unless defined $sepChar;

        no strict 'refs';
        my $pkg = __PACKAGE__;
        my $stash = $pkg . "::";
        my @consts;

        for my $name (sort keys %$stash)
        {
            ### is it a subentry?
            my $sub = $pkg->can($name);
            next unless defined $sub;
            next unless defined prototype($sub) and not length prototype($sub);
            push @consts, $name;
        }

        return join($sepChar, @consts);
    }

1;

################################################################################

# Enumeration implementation for MMSOMFY::Internal
package MMSOMFY::Internal;

    use strict;
    use warnings;

    # enumeration items
    use constant {
        MODEL => "MODEL",
        TIMING => "TIMING"
    };

    # Get string with all items of enumeration separated by given character.
    # If separation character is not set, space will be used.
    sub ToString {
        my ($sepChar) = @_;
        $sepChar = " " unless defined $sepChar;

        no strict 'refs';
        my $pkg = __PACKAGE__;
        my $stash = $pkg . "::";
        my @consts;

        for my $name (sort keys %$stash)
        {
            ### is it a subentry?
            my $sub = $pkg->can($name);
            next unless defined $sub;
            next unless defined prototype($sub) and not length prototype($sub);
            push @consts, $name;
        }

        return join($sepChar, @consts);
    }

    # Clear all device specific definitions.
    sub Clear(;$) {
        my ($hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Internal ($hash->{NAME}): Enter 'Clear'"
        );

        my ($sepChar) = @_;
        $sepChar = " " unless defined $sepChar;

        no strict 'refs';
        my $pkg = __PACKAGE__;
        my $stash = $pkg . "::";
        my @consts;

        for my $name (sort keys %$stash)
        {
            ### is it a subentry?
            my $sub = $pkg->can($name);
            next unless defined $sub;
            next unless defined prototype($sub) and not length prototype($sub);
            main::Log3(
                $hash->{NAME},
                5,
                "MMSOMFY::Internal ($hash->{NAME}): Remvove '$name'"
            );
            delete($hash->{$name})
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Internal ($hash->{NAME}): Exit 'Clear'"
        );
    }

1;

################################################################################

# Enumeration implementation for MMSOMFY::Attribute providing
# all attributes of the module to FHEM.
package MMSOMFY::Attribute;

    use strict;
    use warnings;
    use Data::Dumper;

    #enumeration items
    use constant {
        driveTimeOpenedToDown => 'driveTimeOpenedToDown',
        driveTimeOpenedToClosed => 'driveTimeOpenedToClosed',
        driveTimeClosedToDown => 'driveTimeClosedToDown',
        driveTimeClosedToOpened => 'driveTimeClosedToOpened',
        myPosition => 'myPosition',
        additionalPosReading => 'additionalPosReading',
        positionInverse => 'positionInverse',
        symbolLength => 'symbolLength',
        repetition => 'repetition',
        fixedEnckey => 'fixedEnckey',
        ignore => 'ignore',
        rawDevice => 'rawDevice',
        userattr => 'userattr',
        webCmd => 'webCmd',
        devStateIcon => 'devStateIcon',
        cmdIcon => 'cmdIcon',
        stateFormat => 'stateFormat',
    };

    sub Clear(;$) {
        my ($hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Attribute ($hash->{NAME}): Enter 'Clear'"
        );

        no strict 'refs';
        my $pkg = __PACKAGE__;
        my $stash = $pkg . "::";
        my @consts;

        for my $name (sort keys %$stash)
        {
            ### is it a subentry?
            my $sub = $pkg->can($name);
            next unless defined $sub;
            next unless defined prototype($sub) and not length prototype($sub);

            if (defined($main::attr{$hash->{NAME}}{$name}))
            {
                main::Log3(
                    $hash->{NAME},
                    5,
                    "MMSOMFY::Attribute ($hash->{NAME}): Remove '$name'"
                );

                delete($main::attr{$hash->{NAME}}{$name});
            }
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Attribute ($hash->{NAME}): Exit 'Clear'"
        );
    }

    # Get string with all items and values of enumeratione separated by given character.
    # If separation charcter is not set space will be used.
    # item and value are separated by ":"
    sub AddSpecificAttributes(;$) {
        my ($hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Attribute ($hash->{NAME}): Enter 'AddSpecificAttributes'"
        );

        # values for enumeration items.
        # if set they must be separated by colon from the itemname.
        # Separator is part of value for convenience
        my %values = (
            driveTimeOpenedToDown => "",
            driveTimeOpenedToClosed => "",
            driveTimeClosedToDown => "",
            driveTimeClosedToOpened => "",
            myPosition => "",
            additionalPosReading => "",
            positionInverse => ":1,0",
            symbolLength => "",
            repetition => "",
            fixedEnckey => ":1,0",
            ignore => ":0,1",
            rawDevice => "",
            userattr => "",
            webCmd => "",
			stateFormat => "",
        );

        my ($sepChar) = @_;
        $sepChar = " " unless defined $sepChar;

        no strict 'refs';
        my $pkg = __PACKAGE__;
        my $stash = $pkg . "::";
        my @consts;

        for my $name (sort keys %$stash)
        {
            ### is it a subentry?
            my $sub = $pkg->can($name);
            next unless defined $sub;
            next unless defined prototype($sub) and not length prototype($sub);

            if
                (
                    # ... attribute is for all models ...
                    # ... currently none ...

                    # ... or attribute belongs to set model ...
                    (
                        # ... remotes ...
                        ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::remote) &&
                        (
                            ($name eq MMSOMFY::Attribute::ignore) ||
                            ($name eq MMSOMFY::Attribute::rawDevice)
                        )
                    ) || (
                        # ... switches ...
                        ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::switch) &&
                        (
                            ($name eq MMSOMFY::Attribute::symbolLength) ||
                            ($name eq MMSOMFY::Attribute::repetition) ||
                            ($name eq MMSOMFY::Attribute::fixedEnckey)
                        )
                    ) || (
                        # ... awnings and shutters ...
                        (
                            ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::awning) ||
                            ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::shutter)
                        ) && (
                            ($name eq MMSOMFY::Attribute::symbolLength) ||
                            ($name eq MMSOMFY::Attribute::repetition) ||
                            ($name eq MMSOMFY::Attribute::fixedEnckey) ||
                            ($name eq MMSOMFY::Attribute::driveTimeOpenedToDown) ||
                            ($name eq MMSOMFY::Attribute::driveTimeOpenedToClosed) ||
                            ($name eq MMSOMFY::Attribute::driveTimeClosedToDown) ||
                            ($name eq MMSOMFY::Attribute::driveTimeClosedToOpened) ||
                            ($name eq MMSOMFY::Attribute::myPosition) ||
                            ($name eq MMSOMFY::Attribute::additionalPosReading) ||
                            ($name eq MMSOMFY::Attribute::positionInverse)
                        )
                    )
                )
            {
                main::Log3(
                    $hash->{NAME},
                    4,
                    "MMSOMFY::Attribute ($hash->{NAME}): Add $name$values{$name}"
                );
                
                main::addToDevAttrList($hash->{NAME}, $name . $values{$name});
            }
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Attribute ($hash->{NAME}): Exit 'AddSpecificAttributes'"
        );
    }

    # Checks that changing attribute values results in valid states.
    sub CheckAttribute($$$$;$) {
        my ($cmd, $attrName, $attrValue, $init_done, $hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3($hash->{NAME}, 4, "MMSOMFY::Attribute ($hash->{NAME}): Enter 'CheckAttribute'");

        my $name = $hash->{NAME};
        my $retval = undef;

        # if attribute is part of attribut package ...
        if (MMSOMFY::Attribute->can($attrName))
        {
            # ... then continue depending on attribute name ...
            if ($attrName eq MMSOMFY::Attribute::webCmd)
            {
                # If init is already done ...
                if ($init_done)
                {
                    # ... web commands shall not be modified by user therefore error is returned.
                    $retval = "MMSOMFY::Attribute::CheckAttribute ($hash->{NAME}): Error - Attribute $attrName cannot be modified.";
                }
                # ... otherwise ...
                else
                {
                    # ... just keep the web commands as they are already set properly by definition.
                    # Value to be set here comes from fhem.cfg and can contain obsolete attributes in case of update.
                    $_[2] = main::AttrVal($name, MMSOMFY::Attribute::webCmd, $_[2]);
                }
            }
            elsif ($attrName eq MMSOMFY::Attribute::userattr)
            {
                # If init is already done ...
                if ($init_done)
                {
                    # ... user attributes shall not be modified by user therefore error is returned.
                    $retval = "MMSOMFY::Attribute::CheckAttribute ($hash->{NAME}): Error - Attribute $attrName cannot be modified.";
                }
                # ... otherwise ...
                else
                {
                    # ... just keep the user attributes as they are already set properly by definition.
                    # Value to be set here comes from fhem.cfg and can contain obsolete attributes in case of update.
                    $_[2] = main::AttrVal($name, MMSOMFY::Attribute::userattr, $_[2]);
                }
            }
            elsif ($attrName eq MMSOMFY::Attribute::driveTimeOpenedToDown)
            {
                # ... if attribute shall be set ...
                if ($cmd eq "set")
                {
                    # ... if model is a shutter, attribute is supported ...
                    if ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::shutter)
                    {
                        # ... check validity of value to be set ...
                        $retval = MMSOMFY::Timing::CheckTiming($attrName, $_[2], MMSOMFY::Attribute::driveTimeOpenedToClosed, $main::attr{$name}{MMSOMFY::Attribute::driveTimeOpenedToClosed}, "smaller");
                    }
                    # ... otherwise attribute is not supported ...
                    else
                    {
                        # ... error is returned.
                        $retval = "MMSOMFY::Attribute::CheckAttribute ($hash->{NAME}): Error - Attribute $attrName is supported for " . MMSOMFY::Internal::MODEL . " " . MMSOMFY::Model::shutter . " only.";
                    }
                }

                # ... update Timing Setting if there is no error.
                MMSOMFY::DeviceModel::Update($attrName, $attrValue) unless (defined($retval));
            }
            elsif ($attrName eq MMSOMFY::Attribute::driveTimeOpenedToClosed)
            {
                # ... if attribute shall be set ...
                if ($cmd eq "set")
                {
                    # ... if model is a shutter or awning, attribute is supported ...
                    if
                        (
                            ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::shutter) ||
                            ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::awning)
                        )
                    {
                        # ... check validity of value to be set ...
                        $retval = MMSOMFY::Timing::CheckTiming($attrName, $_[2], MMSOMFY::Attribute::driveTimeOpenedToDown, $main::attr{$name}{MMSOMFY::Attribute::driveTimeOpenedToDown}, "greater");
                    }
                    # ... otherwise attribute is not supported ...
                    else
                    {
                        # ... error is returned.
                        $retval = "MMSOMFY::Attribute::CheckAttribute ($hash->{NAME}): Error - Attribute $attrName is supported for " . MMSOMFY::Internal::MODEL . " " . MMSOMFY::Model::shutter . " and " . MMSOMFY::Model::awning . " only.";
                    }
                }

                # ... update Timing Setting if there is no error.
                MMSOMFY::DeviceModel::Update($attrName, $attrValue) unless (defined($retval));
            }
            elsif ($attrName eq MMSOMFY::Attribute::driveTimeClosedToDown)
            {
                # ... if attribute shall be set ...
                if ($cmd eq "set")
                {
                    # ... if model is a shutter, attribute is supported ...
                    if ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::shutter)
                    {
                        # ... check validity of value to be set ...
                        $retval = MMSOMFY::Timing::CheckTiming($attrName, $_[2], MMSOMFY::Attribute::driveTimeClosedToOpened, $main::attr{$name}{MMSOMFY::Attribute::driveTimeClosedToOpened}, "smaller");
                    }
                    # ... otherwise attribute is not supported ...
                    else
                    {
                        # ... error is returned.
                        $retval = "MMSOMFY::Attribute::CheckAttribute ($hash->{NAME}): Error - Attribute $attrName is supported for " . MMSOMFY::Internal::MODEL . " " . MMSOMFY::Model::shutter . " only.";
                    }
                }

                # ... update Timing Setting if there is no error.
                MMSOMFY::DeviceModel::Update($attrName, $attrValue) unless (defined($retval));
            }
            elsif ($attrName eq MMSOMFY::Attribute::driveTimeClosedToOpened)
            {
                # ... if attribute shall be set ...
                if ($cmd eq "set")
                {
                    # ... if model is a shutter or awning, attribute is supported ...
                    if
                        (
                            ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::shutter) ||
                            ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::awning)
                        )
                    {
                        # ... check validity of value to be set ...
                        $retval = MMSOMFY::Timing::CheckTiming($attrName, $_[2], MMSOMFY::Attribute::driveTimeClosedToDown, $main::attr{$name}{MMSOMFY::Attribute::driveTimeClosedToDown}, "greater");
                    }
                    # ... otherwise attribute is not supported ...
                    else
                    {
                        # ... error is returned.
                        $retval = "MMSOMFY::Attribute::CheckAttribute ($hash->{NAME}): Error - Attribute $attrName is supported for " . MMSOMFY::Internal::MODEL . " " . MMSOMFY::Model::shutter . " and " . MMSOMFY::Model::awning . " only.";
                    }
                }

                # ... update Timing Setting if there is no error.
                MMSOMFY::DeviceModel::Update($attrName, $attrValue) unless (defined($retval));
            }
            elsif ($attrName eq MMSOMFY::Attribute::myPosition)
            {
                # ... if attribute shall be set ...
                if ($cmd eq "set")
                {
                    # ... if model is a shutter or awning, attribute is supported ...
                    if
                        (
                            ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::shutter) ||
                            ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::awning)
                        )
                    {
                        # ... check if it is within position range ...
                        if ($attrValue > MMSOMFY::Position::MaxPos() || $attrValue < MMSOMFY::Position::MinPos())
                        {
                            # ... if outside bounds return error.
                            $retval = "MMSOMFY::Attribute::CheckAttribute: Value for $attrName ($attrValue) must be between opened (" . MMSOMFY::Position::FromState(MMSOMFY::State::opened) . ") and closed (" . MMSOMFY::Position::FromState(MMSOMFY::State::closed) . ").";
                        }
                    }
                    # ... otherwise attribute is not supported ...
                    else
                    {
                        # ... error is returned.
                        $retval = "MMSOMFY::Attribute::CheckAttribute ($hash->{NAME}): Error - Attribute $attrName is supported for " . MMSOMFY::Internal::MODEL . " " . MMSOMFY::Model::shutter . " and " . MMSOMFY::Model::awning . " only.";
                    }
                }
            }
            elsif ($attrName eq MMSOMFY::Attribute::additionalPosReading)
            {
                # ... if attribute shall be set ...
                if ($cmd eq "set")
                {
                    # ... if model is a shutter or awning, attribute is supported ...
                    if
                        (
                            ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::shutter) ||
                            ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::awning)
                        )
                    {
                        # ... if there is already a reading with given name ...
                        if (MMSOMFY::Reading->can($attrValue))
                        {
                            # ... return an error.
                            $retval = "MMSOMFY::Attribute::CheckAttribute: Value for $attrName ($attrValue) cannot be set. Reading with same name exists.";
                        }
                    }
                    # ... otherwise attribute is not supported ...
                    else
                    {
                        # ... error is returned.
                        $retval = "MMSOMFY::Attribute::CheckAttribute ($hash->{NAME}): Error - Attribute $attrName is supported for " . MMSOMFY::Internal::MODEL . " " . MMSOMFY::Model::shutter . " and " . MMSOMFY::Model::awning . " only.";
                    }
                }
            }
            # for remotes only
            elsif ($attrName eq MMSOMFY::Attribute::ignore)
            {
                # ...  preset state to receving ...
                $hash->{STATE} = MMSOMFY::State::receiving;

                # ... if attribute shall be set ...
                if ($cmd eq "set" && $attrValue eq 1)
                {
                    # ... state is changed to ignored.
                    $hash->{STATE} = MMSOMFY::State::ignored;
                }
            }
        }

        main::Log3($hash->{NAME}, 1, $retval) if (defined($retval));

        main::Log3($hash->{NAME}, 4, "MMSOMFY::Attribute ($hash->{NAME}): Exit 'CheckAttribute'");
        
        return $retval;
    }

1;

################################################################################

# Encapsulation of MMSOMFY::Timing.
# ======================================================== opened
#  opened2down -> | | <- opened2closed ↑ ↑
#                 | |                  | |
#                 | |                  | |
#                 | |                  | |
#                 | |                  | |
#                 | |                  | |
#                 ↓ |                  | | <- down2opened
# ==================|==================|================== down
#  down2closed -> | |                  | ↑
#                 ↓ ↓ closed2opened -> | | <- closed2down
# ======================================================== closed
package MMSOMFY::Timing;

    use strict;
    use warnings;
    use Scalar::Util qw(looks_like_number);

    # enumeration items
    use constant {
        off => "off",
        basic => "basic",
        extended => "extended",
    };

    # Check given timing attribute against a reference attribute with operator.
    sub CheckTiming($$$$$;$) {
        my ($attrName, $attrValue, $referenceName, $referenceValue, $operator, $hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Enter 'CheckTiming'"
        );

        my $retval = undef;
        
        # Check if valid operator is used ...
        if ($operator !~ /^(smaller|greater)$/)
        {
            # ... if not return error ...
            $retval = "MMSOMFY::Timing::CheckTiming ($hash->{NAME}): Operator '$operator' is unknown.";
        }
        # ... if operator is ok ...
        else
        {
            # ... check if value is numeric ...
            if (looks_like_number($attrValue))
            {
                main::Log3($hash->{NAME}, 5, "MMSOMFY::Timing::CheckTiming ($hash->{NAME}): Set timing value ($attrValue) to format %.1f");

                # ... format value to float with one decimal place and change the reference of attribute value ...
                $attrValue = sprintf "%.1f", $attrValue;
                $_[1] = $attrValue;
        
                main::Log3(
                    $hash->{NAME},
                    5,
                    "MMSOMFY::Timing::CheckTiming ($hash->{NAME}): Corrected timing value ($attrValue)"
                );

                # ... check if value is > 0 ...
                if ($attrValue > 0)
                {
                    # ... perform check with operator smaller ...
                    if ($operator eq "smaller")
                    {
                        # ... if reference value is defined it must be greater ...
                        if (defined($referenceValue) && $referenceValue <= $attrValue)
                        {
                            # ... otherwise it is an error.
                            $retval = "MMSOMFY::Timing::CheckTiming ($hash->{NAME}): Value $attrName ($attrValue) must be smaller than $referenceName ($referenceValue)";
                        }
                    }
                    # ... perform check with operator greater ...
                    elsif ($operator eq "greater")
                    {
                        # ... if reference value is defined it must be smaller ...
                        if (defined($referenceValue) && $referenceValue >= $attrValue)
                        {
                            # ... otherwise it is an error.
                            $retval = "MMSOMFY::Timing::CheckTiming ($hash->{NAME}): Value $attrName ($attrValue) must be greater than $referenceName ($referenceValue)";
                        }
                    }
                }
                # ... otherwise value is <= 0 ...
                else
                {
                    # ... then return error as all timings shall always be greater 0.
                    $retval = "MMSOMFY::Timing::CheckTiming ($hash->{NAME}): Value for $attrName must be greater 0.";
                }
            }
            # ... if value is not numeric ...
            else
            {
                # ... then return error as timing values must be numeric.
                $retval = "MMSOMFY::Timing::CheckTiming ($hash->{NAME}): Value for $attrName ($attrValue) is not numeric.";
            }
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Exit 'CheckTiming'"
        );

        return $retval;
    }

    # Get time from opened position to closed position.
    # If timing is not at least basic undef is returned.
    sub Opened2Closed(;$) {
        my ($hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Enter 'Opened2Closed'"
        );

        my $retval = undef;
      
        if ($hash->{MMSOMFY::Internal::TIMING} ne off)
        {
            $retval = $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeOpenedToClosed};
        }
        
        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Exit 'Opened2Closed'"
        );

        return $retval;
    }

    # Get time from opened position to down position.
    # If timing is not extended undef is returned.
    sub Opened2Down(;$) {
        my ($hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Enter 'Opened2Down'"
        );

        my $retval = undef;
        
        if ($hash->{MMSOMFY::Internal::TIMING} eq extended)
        {
            $retval = $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeOpenedToDown};
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Exit 'Opened2Down'"
        );

        return $retval;
    }

    # Get time from down position to closed position.
    # If timing is not extended undef is returned.
    sub Down2Closed(;$) {
        my ($hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Enter 'Down2Closed'"
        );
    
        my $retval = undef;
        
        if ($hash->{TIMING} eq extended)
        {
            $retval = $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeOpenedToClosed} - $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeOpenedToDown};
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Exit 'Down2Closed'"
        );

        return $retval;
    }

    # Get time from closed position to opened position.
    # If timing is not at least basic undef is returned.
    sub Closed2Opened(;$) {
        my ($hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Enter 'Closed2Opened'"
        );

        my $retval = undef;
        
        if ($hash->{MMSOMFY::Internal::TIMING} ne off)
        {
            $retval = $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeClosedToOpened};
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Exit 'Closed2Opened'"
        );

        return $retval;
    }

    # Get time from closed position to down position.
    # If timing is not extended undef is returned.
    sub Closed2Down(;$) {
        my ($hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Enter 'Closed2Down'"
        );

        my $retval = undef;
        
        if ($hash->{TIMING} eq extended)
        {
            $retval = $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeClosedToDown};
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Exit 'Closed2Down'"
        );

        return $retval;
    }

    # Get time from down position to closed position.
    # If timing is not extended undef is returned.
    sub Down2Opened(;$) {
        my ($hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Enter 'Down2Opened'"
        );

        my $retval = undef;
        
        if ($hash->{MMSOMFY::Internal::TIMING} eq extended)
        {
            $retval = $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeClosedToOpened} - $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeClosedToDown};
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Exit 'Down2Opened'"
        );

        return $retval;
    }

1;

################################################################################

# Enumeration implementation for MMSOMFY::Reading
package MMSOMFY::Reading;

    use strict;
    use warnings;

    # enumeration items
    use constant {
        # all
        enc_key => "enc_key",
        rolling_code => "rolling_code",
        # shutter/awning
        exact => "exact",
        position => "position",
        movement => "movement",
        # remote
        received => "received",
        command => "command",
    };

    # Get string with all items of enumeration separated by given character.
    # If separation character is not set, space will be used.
    sub ToString {
        my ($sepChar) = @_;
        $sepChar = " " unless defined $sepChar;

        no strict 'refs';
        my $pkg = __PACKAGE__;
        my $stash = $pkg . "::";
        my @consts;

        for my $name (sort keys %$stash)
        {
            ### is it a subentry?
            my $sub = $pkg->can($name);
            next unless defined $sub;
            next unless defined prototype($sub) and not length prototype($sub);
            push @consts, $name;
        }

        return join($sepChar, @consts);
    }

    sub Clear(;$) {
        my ($hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Reading ($hash->{NAME}): Enter 'Clear'"
        );

        no strict 'refs';
        my $pkg = __PACKAGE__;
        my $stash = $pkg . "::";
        my @consts;

        for my $name (sort keys %$stash)
        {
            ### is it a subentry?
            my $sub = $pkg->can($name);
            next unless defined $sub;
            next unless defined prototype($sub) and not length prototype($sub);
            main::Log3(
                $hash->{NAME},
                5,
                "MMSOMFY::Reading ($hash->{NAME}): Remove '$name'"
            );
            main::readingsDelete($hash, $name)
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Reading ($hash->{NAME}): Exit 'Clear'"
        );
    }

    # Set common readings if values are set.
    sub SetCommon($$;$) {
        my ($enc_key, $roll_code, $hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Reading ($hash->{NAME}): Enter 'SetCommon'"
        );

        # reset reading time on def to 0 seconds (1970)
        my $tzero = main::FmtDateTime(0);

        if (defined($enc_key))
        {
            main::Log3(
                $hash->{NAME},
                5,
                "MMSOMFY::Reading ($hash->{NAME}): Set " . MMSOMFY::Reading::enc_key . " to $enc_key"
            );

            main::setReadingsVal($hash, MMSOMFY::Reading::enc_key, $enc_key, $tzero);
        }

        if (defined($roll_code))
        {
            main::Log3(
                $hash->{NAME},
                5,
                "MMSOMFY::Reading ($hash->{NAME}): Set " . MMSOMFY::Reading::rolling_code . " to $roll_code"
            );

            main::setReadingsVal($hash, MMSOMFY::Reading::rolling_code, $roll_code, $tzero);
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Reading ($hash->{NAME}): Exit 'SetCommon'"
        );
    }

    # Update Readings according given position value and moving.
    sub PositionUpdate($$;$) {
        my ($exact, $movement, $hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Reading ($hash->{NAME}): Enter 'Update'"
        );

        my $name = $hash->{NAME};
        my $position = MMSOMFY::Position::GetPosition($exact, $hash);

        main::Log3(
            $name,
            5,
            "MMSOMFY::Reading ($hash->{NAME}): Update readings for $name, exact:$exact, position:$position, movement:$movement."
        );

        main::readingsBeginUpdate($hash);

        main::readingsBulkUpdate($hash, MMSOMFY::Reading::exact, $exact, 1);
        main::readingsBulkUpdate($hash, MMSOMFY::Reading::position, $position, 1);
        main::readingsBulkUpdate($hash, MMSOMFY::Reading::movement, $movement, 1);

        my $addtlPosReading = main::AttrVal($name, MMSOMFY::Attribute::additionalPosReading, undef);
        if (defined($addtlPosReading))
        {
            # Normalize name of reading, replacing invalid characters with underscore.
            $addtlPosReading = main::makeReadingName($addtlPosReading);
            
            main::Log3(
                $name,
                5,
                "MMSOMFY::Reading ($hash->{NAME}): Update additionalPosReading for $name, $addtlPosReading:$position."
            );

            main::readingsBulkUpdate($hash, $addtlPosReading, $position, 1);
        }

        main::readingsEndUpdate($hash, 1);

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Reading ($hash->{NAME}): Exit 'Update'"
        );
    }

1;

################################################################################

# Encapsulation of MMSOMFY::Position including Enumeration implementation.
# Inversion is handled on position calculation, internally everything is set with inversion=0
package MMSOMFY::Position;

    use strict;
    use warnings;
    use Scalar::Util qw(looks_like_number);
    use List::Util qw[min max];

    # Frame settings for postition calculation without inversion.
    # STARTPOS is used for opened and ENDPOS for closed.
    # If STARTPOS > ENDPOS usage is exchanged.
    use constant {
        STARTPOS => 0,
        ENDPOS => 100,
        STEPS => 20,
    };

    # Range from frame settings
    use constant RANGE => abs(ENDPOS-STARTPOS);

    # Stepwidth from frame settings
    use constant STEPWIDTH => RANGE/STEPS;

    # Range from down to closed
    use constant DOWNRANGE => 1*STEPWIDTH;

    # Mapping from state to position without inversion.
    my %state2position = (
        MMSOMFY::State::opened => min(ENDPOS,STARTPOS),
        MMSOMFY::State::down => max(ENDPOS,STARTPOS)-DOWNRANGE,
        MMSOMFY::State::closed => max(ENDPOS,STARTPOS),
    );

    # Mapping from position to state without inversion.
    my %position2state = reverse %state2position;

    # Get string with all position items separated by given character.
    # If separation character is not set, space will be used.
    sub ToString {
        my ($sepChar) = @_;
        $sepChar = " " unless defined $sepChar;

        my @positions;
        for (my $i=0;$i<=STEPS;$i++)
        {
            # Positions are always the same steps independet of inversion.
            push @positions, STARTPOS + STEPWIDTH * $i;
        }

        return join($sepChar, @positions);
    }

    # Get current position value depending on positionInverse
    sub GetPosition($;$) {
        my ($exact, $hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Position ($hash->{NAME}): Enter 'GetPosition'"
        );

        my $name = $hash->{NAME};
        my $retval = undef;

        my $position = MMSOMFY::Position::RoundValue2Step($exact, $hash);

        # Get current state of inversion
        my $positionInverse = main::AttrVal($name, MMSOMFY::Attribute::positionInverse, 0);

        # Calculate value independent from positionInverse if $position is defined
        $retval = ($position - (ENDPOS+STARTPOS) * $positionInverse) * (1 - 2 * $positionInverse) if (defined($position));

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Position ($hash->{NAME}): Exit 'GetPosition'"
        );

        return $retval;
    }

    # Get position value for given state depending on positionInverse
    # This is needed only if switched from Timing off to basic or exteneded.
    sub FromState($;$) {
        my ($state, $hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Position ($hash->{NAME}): Enter 'FromState'"
        );

        my $retval = undef;

        if (exists($state2position{$state}))
        {
            $retval = GetPosition($state2position{$state}, $hash);
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Position ($hash->{NAME}): Exit 'FromState'"
        );

        return $retval;
    }

    # Get state from position and movement value depending on positionInverse.
    # This is needed only if switched from Timing basic or exteneded to off.
    sub ToState($$;$) {
        my ($exact, $movement, $hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Position ($hash->{NAME}): Enter 'ToState'"
        );

        my $name = $hash->{NAME};
        my $retval = undef;

        # If movement is ongoing to state opened ...
        if ($movement eq MMSOMFY::Movement::up)
        {
            # ... then the state is opening ...
            $retval = MMSOMFY::State::opened;
        }
        # ... otherwise check if movement is ongoing to state closed ...
        elsif ($movement eq MMSOMFY::Movement::down)
        {
            # ... then the state is closing. 
            $retval = MMSOMFY::State::closed;
        }
        else
        {
            # ... use the state which is nearest to current position.
            $retval = (abs($exact - STARTPOS) <= abs($exact - ENDPOS))
                ? MMSOMFY::State::opened
                : MMSOMFY::State::closed;
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Position ($hash->{NAME}): Exit 'ToState'"
        );

        return $retval;
    }

    # Get position change calculated from range, time needed to move the range and the past time.
    # sub dPosForTime($$$) {
    #     main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Enter 'dPosForTime'");

    #     my ($rfull, $tfull, $dt) = @_;
    #     my $retval = $rfull * $dt / $tfull;

    #     my $positionInverse = main::AttrVal($main::FHEM_Hash->{NAME}, MMSOMFY::Attribute::positionInverse, 0);
    #     $retval = $retval * (1 - 2 * $positionInverse);

    #     main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Exit 'dPosForTime'");
    #     return $retval;
    # }

    # Get absolute difference between two positions.
    # sub diffPosition($$) {
    #     main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Enter 'diffPosition'");

    #     my ($pos1, $pos2) = @_;
    #     my $retval = undef;

    #     # If every input is correct ...
    #     if (defined($pos1) && looks_like_number($pos1) && defined($pos2) && looks_like_number($pos2))
    #     {
    #         $retval = abs($pos2 - $pos1);
    #     }

    #     main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Exit 'diffPosition'");
    #     return $retval;
    # }

    # Returns minimal position value.
    sub MinPos {
        return min(ENDPOS,STARTPOS);
    }

    # Returns maximum position value.
    sub MaxPos {
        return max(ENDPOS,STARTPOS);
    }

    # Returns 1 if given position is between both given state positions or equal one of the states, 0 else
    # sub IsPosBetween($$$;$) {
    #     my ($position, $state1, $state2, $hash) = @_;
    #     $hash = $main::FHEM_Hash unless defined $hash;
    #     return if
    #     (
    #         !$hash || # no hash
    #         !$main::defs{$hash->{NAME}} || # deleted
    #         main::IsIgnored($hash->{NAME}) || # ignored
    #         main::IsDisabled($hash->{NAME}) # disabled
    #     );

    #     main::Log3(
    #         $hash->{NAME},
    #         4,
    #         "MMSOMFY::Position ($hash->{NAME}): Enter 'IsPosBetween'"
    #     );

    #     my $retval = 0;
    #     my $state1pos = FromState($state1);
    #     my $state2pos = FromState($state2);

    #     if (defined($position) && defined($state1pos) && defined($state2pos) && looks_like_number($position))
    #     {
    #         my $min_pos = min($state1pos, $state2pos);
    #         my $max_pos = max($state1pos, $state2pos);
    #         $retval = 1 if ($position >= $min_pos && $position <= $max_pos);
    #     }

    #     main::Log3(
    #         $hash->{NAME},
    #         4,
    #         "MMSOMFY::Position ($hash->{NAME}): Exit 'IsPosBetween'"
    #     );

    #     return $retval;
    # }

    # Returns value rounded to next step.
    sub RoundValue2Step($;$) {
        my ($exact, $hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;
        return if
        (
            !$hash || # no hash
            !$main::defs{$hash->{NAME}} || # deleted
            main::IsIgnored($hash->{NAME}) || # ignored
            main::IsDisabled($hash->{NAME}) # disabled
        );

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Position ($hash->{NAME}): Enter 'RoundValue2Step'"
        );

        # Calculate the index of the exact position in the steps
        my $index = ($exact - STARTPOS) / STEPWIDTH;

        # Round the index to the nearest integer step
        my $nearest_index = int($index + 0.5);

        # Calculate the corresponding interval step
        my $retval = STARTPOS + $nearest_index * STEPWIDTH;

        $retval = MaxPos if $retval > MaxPos;
        $retval = MinPos if $retval < MinPos;
        
        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Position ($hash->{NAME}): Exit 'RoundValue2Step'"
        );

        return $retval;
    }

    # Returns MMSOMFY::Movement which is necessary to reach given target position.
    # sub GetMovementToTargetPosition($$;$) {
    #     my ($exact, $targetPosition, $hash) = @_;
    #     $hash = $main::FHEM_Hash unless defined $hash;
    #     return if
    #     (
    #         !$hash || # no hash
    #         !$main::defs{$hash->{NAME}} || # deleted
    #         main::IsIgnored($hash->{NAME}) || # ignored
    #         main::IsDisabled($hash->{NAME}) # disabled
    #     );

    #     main::Log3(
    #         $hash->{NAME},
    #         4,
    #         "MMSOMFY::Position ($hash->{NAME}): Enter 'GetMovementToTargetPosition'"
    #     );

    #     # ... preset result to no move ....
    #     my $retval = MMSOMFY::Movement::none;

    #     # ... if target position is not the current one ...
    #     unless ($targetPosition eq GetPosition($exact))
    #     {
    #         # ... if target position is between state opened and the current position ...
    #         if (MMSOMFY::Position::IsPosBetween($targetPosition, MMSOMFY::State::opened, MMSOMFY::State::position))
    #         {
    #             # ... movement must be direction up ...
    #             $retval = MMSOMFY::Movement::up;
    #         }
    #         # ... else the triggered position is between state closed and the current position ...
    #         else
    #         {
    #             # ... movement must be direction down ...
    #             $retval = MMSOMFY::Movement::down;
    #         }
    #     }

    #     # ... log result in debug level ...
    #     main::Log3($hash->{NAME}, 5, "MMSOMFY::Position::GetMovementToTargetPosition ($hash->{NAME}): Direction to position $targetPosition is " . $retval . ".");

    #     main::Log3($hash->{NAME}, 4, "MMSOMFY::Position ($hash->{NAME}): Exit 'GetMovementToTargetPosition'");

    #     return $retval;
    # }

1;

################################################################################

# Enumeration implementation for MMSOMFY::Command
package MMSOMFY::Command;

    use strict;
    use warnings;

    # enumeration items
    use constant {
        open => "open",
        off => "off",
        close => "close",
        on => "on",
        stop => "stop",
        prog => "prog",
        close_for_timer => "close_for_timer",
        open_for_timer => "open_for_timer",
        z_custom => "z_custom",
        go_my => "go_my",
        position => "position",
        manual => "manual",
        wind_sun_9 => "wind_sun_9",
        wind_only_a => "wind_only_a",
    };

    my %code2command = (
        # Remotes doesn't support any commands but must decode them.
        MMSOMFY::Model::remote => {
            "10" => "go_my",       # stop or go my
            "20" => "up",          # go up
            "40" => "down",        # go down
            "80" => "prog",        # pairing or unpairing
            "90" => "wind_sun_9",  # wind and sun (sun + flag)
            "A0" => "wind_only_a", # wind only (flag)
        },
        MMSOMFY::Model::awning => {
            "10" => "go_my",       # stop or go my
            "20" => "open",        # go up
            "40" => "close",       # go down
            "80" => "prog",        # pairing or unpairing
            "90" => "wind_sun_9",  # wind and sun (sun + flag)
            "A0" => "wind_only_a", # wind only (flag)
        },
        MMSOMFY::Model::shutter => {
            "10" => "go_my",       # stop or go my
            "20" => "open",        # go up
            "40" => "close",       # go down
            "80" => "prog",        # pairing or unpairing
            "90" => "wind_sun_9",  # wind and sun (sun + flag)
            "A0" => "wind_only_a", # wind only (flag)
        },
        MMSOMFY::Model::switch => {
            "20" => "off",         # go up
            "40" => "on",          # go down
            "80" => "prog",        # pairing or unpairing
        },
    );

    my %command2code =  (
        "open" => "20",            # up
        "off" => "20",             # up
        "close" => "40",           # down
        "on" => "40",              # down
        "stop" => "10",            # go_my
        "prog" => "80",            # prog
        "close_for_timer" => "40", # down
        "open_for_timer" => "20",  # up
        "z_custom" => "XX",        # user defined
        "go_my" => "10",           # go_my
        "wind_sun_9" => "90",      # wind_sun_9
        "wind_only_a" => "A0",     # wind_only_a
    );

    # Default Somfy frame symbol width
    my $somfy_defsymbolwidth = 1240;

    # Default Somfy frame repeat counter
    my $somfy_defrepetition = 6;

    # Extends the command string with additional commands for devices supporting an on/off command.
    my $ExtendOnOff = sub {
        my ($normalizedString, $sepChar, $skipArguments) = @_;

        # If seperation character is not space ...
        if ($sepChar ne " ")
        {
            # ... we need to set the seperation characters back to space for the extension function ...
            eval "\$normalizedString =~ tr/$sepChar/ /";
            # ... but we stop, if there is an error on translate
            return $@ if $@;
        }
        
        # Get the extended commandlist if there are on/off commands available
        $normalizedString = main::SetExtensions($main::FHEM_Hash, $normalizedString, $main::FHEM_Hash->{NAME}, '?');

        # Remove error message part of standard return value ...
        $normalizedString =~ s/.*choose one of //;

        # ... trim string ...
        $normalizedString =~ s/^\s+|\s+$//g;

        if (!$skipArguments)
        {
            # ... add noArg for toggle ...
            $normalizedString =~ s/toggle/toggle:noArg/;
            
            # ... prepare string for replacement ...
            $normalizedString .= " ";

            # ... remove space at the end ...
            chop($normalizedString);
        }

        # ...if separation charater was not space ...
        if ($sepChar ne " ")
        {
            # ... translate string back ...
            eval "\$normalizedString =~ tr/ /$sepChar/";
            # ... but we stop, if there is an error on translate
            return $@ if $@;
        }

        return $normalizedString;
    };

    # Get string with all items and values of enumeratione separated by given character.
    # If separation charcter is not set space will be used.
    # item and value are separated by ":"
    sub ToString {
        # values for enumeration items.
        # if set they must be separated by colon from the item name.
        # Separator is part of value for convenience
        my %values = (
            open => ":noArg",
            close => ":noArg",
            on => ":noArg",
            off => ":noArg",
            stop => ":noArg",
            prog => ":noArg",
            close_for_timer => "",
            open_for_timer => "",
            z_custom => "",
            go_my => ":noArg",
            position => ":" . MMSOMFY::Position::ToString(','),
            manual => ":" .
                (
                    (
                        defined($main::FHEM_Hash->{MMSOMFY::Internal::TIMING}) &&
                        $main::FHEM_Hash->{MMSOMFY::Internal::TIMING} ne MMSOMFY::Timing::off
                    )
                        ? MMSOMFY::Position::ToString(',')
                        : "open,close"
                ),
            wind_sun_9 => ":noArg",
            wind_only_a => ":noArg",
        );

        my ($sepChar, $skipArguments) = @_;
        $sepChar = " " unless defined $sepChar;

        no strict 'refs';
        my $pkg = __PACKAGE__;
        my $stash = $pkg . "::";
        my @consts;

        for my $name (sort keys %$stash)
        {
            ### is it a subentry?
            my $sub = $pkg->can($name);
            next unless defined $sub;
            next unless defined prototype($sub) and not length prototype($sub);

            if
                (
                    # Commmand list depends on model
                    (
                        # ... for remotes there are no commands ...
                        ($main::FHEM_Hash->{MMSOMFY::Internal::MODEL} ne MMSOMFY::Model::remote) &&
                        (
                            (
                                # ... for switches following commands are available ...
                                ($main::FHEM_Hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::switch) &&
                                (
                                    ($name eq MMSOMFY::Command::on) ||
                                    ($name eq MMSOMFY::Command::off) ||
                                    ($name eq MMSOMFY::Command::prog) ||
                                    ($name eq MMSOMFY::Command::z_custom)
                                )
                            ) || (
                                # ... for awning and shutter following commands are available ...
                                (
                                    ($main::FHEM_Hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::awning) ||
                                    ($main::FHEM_Hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::shutter)
                                ) && (
                                    ($name eq MMSOMFY::Command::open) ||
                                    ($name eq MMSOMFY::Command::close) ||
                                    ($name eq MMSOMFY::Command::prog) ||
                                    ($name eq MMSOMFY::Command::z_custom) ||
                                    ($name eq MMSOMFY::Command::manual) ||
                                    ($name eq MMSOMFY::Command::wind_sun_9) ||
                                    ($name eq MMSOMFY::Command::wind_only_a) ||
                                    (
                                        (
                                            ($name eq MMSOMFY::Command::stop) ||
                                            ($name eq MMSOMFY::Command::position) ||
                                            ($name eq MMSOMFY::Command::close_for_timer) ||
                                            ($name eq MMSOMFY::Command::open_for_timer)
                                        ) && (
                                            exists($main::FHEM_Hash->{MMSOMFY::Internal::TIMING}) &&
                                            ($main::FHEM_Hash->{MMSOMFY::Internal::TIMING} ne MMSOMFY::Timing::off)
                                        )
                                    ) || (
                                        ($name eq MMSOMFY::Command::go_my) &&
                                        exists($main::attr{$main::FHEM_Hash->{NAME}}{MMSOMFY::Attribute::myPosition})
                                    )
                                )
                            )
                        )
                    )
                )
            {
                push @consts, $name;
            }
        }

        my $retString;

        # if there shall be no arguments ...
        if ($skipArguments)
        {
            # ... generate commandlist without arguments ...
            $retString = join($sepChar, @consts); 
        }
        else
        {
            # ... else add the arguments to the commands.
            $retString = join($sepChar, map {$_ . $values{$_}} @consts);
        }

        $retString = $ExtendOnOff->($retString, $sepChar, $skipArguments);

        return $retString;
    }

    # During intialize we get cmd undef and a list of possible settings must be returned.
    # If cmd is set, check if cmd is valid for model.
    sub Check($$$@) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Command ($main::FHEM_Hash->{NAME}): Enter 'Check'");

        my ($mode, $cmd, $cmdarg, @addargs) = @_;
        my $retval = undef;
        my $name = $main::FHEM_Hash->{NAME};

        my $logmessage = "$mode, $cmd";
        $logmessage .= ", $cmdarg" if defined $cmdarg;
        $logmessage .= ", @addargs" if defined \@addargs;

        main::Log3($name, 5, "MMSOMFY::Command::Check ($name): $logmessage");

        # ... create command list without arguments ...
        my $cmdListwoArg = MMSOMFY::Command::ToString("|", 1);
        main::Log3($name, 5, "MMSOMFY::Command::Check ($name): CMDListwoArgs: $cmdListwoArg") if defined($cmdListwoArg);

        # ... and command list with arguments ...
        my $cmdListwithArg = MMSOMFY::Command::ToString("|", 0);
        main::Log3($name, 5, "MMSOMFY::Command::Check ($name): CMDListwithArgs: $cmdListwithArg") if defined($cmdListwithArg);

        if
            (
                (
                    # ... commandlist is empty ...
                    $cmdListwoArg eq ""
                ) || (
                    # ... command is not in list of available commands without arguments
                    $cmd !~ qr/$cmdListwoArg/
                ) || (
                    # ... or argument is defined ...
                    defined ($cmdarg) && 
                    
                    # ... but not needed (marked with 'noArg') ...
                    $cmdListwithArg =~ qr/$cmd:noArg/
                ) || (
                    # or argument is not defined
                    !defined ($cmdarg) && 
                    
                    # ... but needed (not marked with 'noArg') ...
                    $cmdListwithArg !~ qr/$cmd:noArg/
                )
            )
        {
            # ... preset error message ...
            my $errormessage = "MMSOMFY::Command::Check ($name): ";

            # ... if cmd is "?" FHEM tries to get list of commands. This is not an error ...
            if ($cmd eq "?")
            {
                $errormessage = $errormessage .  "Getting command list.";
            }
            else
            # ... otherwise it is an error ...
            {
                $errormessage = $errormessage .  "Invalid command: $cmd ";
                $errormessage = $errormessage .  $cmdarg if defined($cmdarg);
            }

            main::Log3($name, 1, $errormessage);

            # ... cmd is cleared because it is invalid ...
            $_[1] = undef;

            # ... and retval gets list of available commands.
            $retval = ToString();
        }
        # ... otherwise check and adjust arguments ...
        else
        {
            no strict 'refs';
            my $pkg = __PACKAGE__;

            # if cmd is one of *_for_timer ...
            if
                (
                    $cmd eq MMSOMFY::Command::close_for_timer || 
                    $cmd eq MMSOMFY::Command::open_for_timer
                )
            {
                # ... if argument is NOT a time value, ...
                if ($cmdarg !~ m/^\d*\.?\d+$/)
                {
                    # ... set an error and clear the cmd.
                    $_[1] = undef;
                    $_[2] = undef;
                    main::Log3($name, 1, "MMSOMFY::Command::Check ($name): Error - Bad time spec");
                    $retval = "MMSOMFY::Command::Check ($name): Bad time spec";
                }
            }
            # if cmd is go_my ...
            elsif ($cmd eq MMSOMFY::Command::go_my)
            {
                # ... then if state is moving ...
                my $movement = main::ReadingsVal($main::FHEM_Hash, MMSOMFY::Reading::movement, undef);

                if
                    (
                        $movement &&
                        (
                            $movement eq MMSOMFY::Movement::up ||
                            $movement eq MMSOMFY::Movement::down
                        )
                    )
                {
                    # ... replace command with stop ...
                    $_[1] = MMSOMFY::Command::stop;
                    $_[2] = undef;
                    main::Log3($name, 3, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::go_my . "' replaced with '" . MMSOMFY::Command::stop . "' due to moving '$movement'");
                }
            }
            # if cmd is stop ...
            elsif ($cmd eq MMSOMFY::Command::stop)
            {
                # ... then if state is moving ...
                my $movement = main::ReadingsVal($main::FHEM_Hash, MMSOMFY::Reading::movement, undef);

                if
                    (
                        $movement ||
                        $movement ne MMSOMFY::Movement::up ||
                        $movement ne MMSOMFY::Movement::down
                    )
                {
                    # ... clear the cmd, as otherwise go_my will be started ...
                    $_[1] = undef;
                    $_[2] = undef;
                    main::Log3($name, 3, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::stop . "' ignored as state is not '" . MMSOMFY::State::movingup . " or " . MMSOMFY::State::movingdown ."'");
                }
            }
            # for cmd manual ...
            elsif ($cmd eq MMSOMFY::Command::manual)
            {
                # ... mode is set to virtual, as manual commands shall adjust only settings in this module and not be sent to the device
                $_[0] = MMSOMFY::Mode::virtual;
                main::Log3($name, 3, "MMSOMFY::Command::Check ($name): Command is '" . MMSOMFY::Command::manual . "'. Setting mode to " . MMSOMFY::Mode::virtual);

                # ... check if argument is close or open ...
                if ($cmdarg =~ m/^(close|open)$/)
                {
                    # ... then set cmd directly to close or open and clear the argument.
                    $_[1] = $cmd = $cmdarg;
                    $_[2] = $cmdarg = undef;
                    main::Log3($name, 3, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::manual . "' replaced by '" . $cmd . "', argument'". $cmdarg . "'' cleared.");
                }
                # ... otherwise manual is a position ...
                else
                {
                    # ... then set cmd directly to position with given argument.
                    $_[1] = $cmd = MMSOMFY::Command::position;
                    main::Log3($name, 3, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::manual . "' replaced by '" . $cmd . "' with argument'". $cmdarg . "'.");
                }
            }
            # for cmd position ...
            elsif ($cmd eq MMSOMFY::Command::position)
            {
                # ... if cmdarg exceeds range, it is set to the according limit ...
                $cmdarg = MMSOMFY::Position::MaxPos if ($cmdarg > MMSOMFY::Position::MaxPos);
                $cmdarg = MMSOMFY::Position::MinPos if ($cmdarg < MMSOMFY::Position::MinPos);

                # ... check if argument is postion value for closed ...
                if ($cmdarg eq MMSOMFY::Position::FromState(MMSOMFY::State::closed))
                {
                    # ... then set cmd directly to close and clear the argument.
                    $_[1] = $cmd = MMSOMFY::Command::close;
                    $_[2] = $cmdarg = undef;
                    main::Log3($name, 4, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::position . "' replaced by '" . $cmd . "', argument cleared.");
                }
                # ... or is postion value for state opened ...
                elsif ($cmdarg eq MMSOMFY::Position::FromState(MMSOMFY::State::opened))
                {
                    # ... then set cmd directly to open and clear the argument.
                    $_[1] = $cmd = MMSOMFY::Command::open;
                    $_[2] = $cmdarg = undef;
                    main::Log3($name, 4, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::position . "' replaced by '" . $cmd . "', argument cleared.");
                }
                # ... otherwise a intermediate position is the target ...
                else
                {
                    # Todo : Evalutaion of direction is not enough.
                    # Todo : Time is needed here already, too, as later we don't know anymore that a time based command has been triggered!

                    # ... get direction to the target position depending on current position ...
                    my $direction = MMSOMFY::Movement::none; #MMSOMFY::Position::GetMovementToTargetPosition($cmdarg);

                    # ... if direction is none ...
                    if ($direction eq MMSOMFY::Movement::none)
                    {
                        # ... we are already at target position and no command is needed.
                        # Therfore the command and the argument are cleared without error.
                        $_[1] = $cmd = undef;
                        $_[2] = $cmdarg = undef;
                        main::Log3($name, 1, "MMSOMFY::Command::Check ($name): Position is already reached, nothing todo.");
                    }
                    # ... if direction is up ...
                    elsif ($direction eq MMSOMFY::Movement::up)
                    {
                        # ... open command is needed ...
                        $_[1] = $cmd = MMSOMFY::Command::open;
                        main::Log3($name, 4, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::position . "' replaced by '" . $cmd . "' with argument'". $cmdarg . "'.");
                    }
                    # ... if direction is down ...
                    elsif ($direction eq MMSOMFY::Movement::down)
                    {
                        # ... close command is needed ...
                        $_[1] = $cmd = MMSOMFY::Command::close;
                        main::Log3($name, 4, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::position . "' replaced by '" . $cmd . "' with argument'". $cmdarg . "'.");
                    }
                }
            }
            elsif ($cmd eq MMSOMFY::Command::z_custom)
            {
                # custom control needs 2 digit hex code
                if ($cmdarg !~ m/^[a-fA-F0-9]{2}$/)
                {
                    $_[1] = undef;
                    $_[2] = undef;
                    main::Log3($name, 1, "MMSOMFY::Command::Check ($name): Error - Bad custom control code, use 2 digit hex codes only.");
                    $retval = "MMSOMFY::Command::Check ($name): Error - Bad custom control code, use 2 digit hex codes only.";
                }
            }
            elsif (!$pkg->can($cmd))
            {
                $_[1] = undef;
                $_[2] = undef;
                main::Log3($name, 4, "MMSOMFY::Command::Check ($name): Command is handled by Extensions.");
                $retval = main::SetExtensions($main::FHEM_Hash, ToString(), $main::FHEM_Hash->{NAME}, $cmd, $cmdarg, @addargs);
            }
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Command ($main::FHEM_Hash->{NAME}): Exit 'Check'");
        return $retval;
    }

    sub Decode($$) {
        (my $Caller, my $msg) = @_;
        my $name = $Caller->{NAME};
        my $ioType = $Caller->{TYPE};
        main::Log3($name, 4, "MMSOMFY::Command ($name): Enter 'Decode'");

        my %retval;

        # preprocessing if IODev is SIGNALduino
        if ($ioType eq "SIGNALduino")
        {
            main::Log3($name, 4, "MMSOMFY::Command::Decode ($name): Preprocessing for SIGNALduino");

            my $encData = substr($msg, 2);
            if (length($encData) >= 14)
            {
                if ($encData =~ m/[0-9A-F]+/)
                {
                    my $decData = RTS_Crypt("d", $name, $encData);
                    my $check = RTS_Check($name, $decData);

                    if ($check eq substr($decData, 3, 1))
                    {
                        $msg = substr($msg, 0, 2) . $decData;
                    }
                    else
                    {
                        main::Log3($name, 1, "MMSOMFY::Command::Decode ($name): Error - Somfy RTS checksum error :$encData:");
                        $msg = undef;
                    }
                }
                else
                {
                    main::Log3($name, 1, "MMSOMFY::Command::Decode ($name): Error - Somfy RTS message is too short :$encData:");
                    $msg = undef;
                }
            }
            else
            {
                main::Log3($name, 1, "MMSOMFY::Command::Decode ($name): Error - Somfy RTS message has wrong format :$encData:");
                $msg = undef;
            }
        }

        if (defined($msg))
        {
            # Msg-Format
            # YsAA2F18F00085E8
            if (substr($msg, 0, 2) ne "Yr" || substr($msg, 0, 2) ne "Yt")
            {
                # Check for correct length
                if (length($msg) == 16)
                {
                    # Ys     AA         2          F          18F0        0085E8
                    #    | enc_key | command & checksum | rolling_code | address
                    $retval{'enc_key'} = substr($msg, 2, 2);
                    # command is higher nibble of byte 3
                    $retval{'command'} = sprintf("%X", hex(substr($msg, 4, 2)) & 0xF0);
                    $retval{'command_desc'} = $code2command{MMSOMFY::Model::remote}{$retval{'command'}};
                    # checksum is lower nibble of byte 3
                    $retval{'checksum'} = sprintf("%X", hex(substr($msg, 4, 2)) & 0x0F);
                    # rolling code
                    $retval{'rolling_code'} = substr($msg, 6, 4);
                    # address needs bytes 14 and 16 swapped
                    $retval{'address'} = uc(substr($msg, 14, 2).substr($msg, 12, 2).substr($msg, 10, 2));
                    main::Log3($name, 3, "MMSOMFY::Command::Decode ($name): address: $retval{'address'}");
                    main::Log3($name, 3, "MMSOMFY::Command::Decode ($name): command: $retval{'command_desc'}($retval{'command'})");
                    main::Log3($name, 3, "MMSOMFY::Command::Decode ($name): enc_key: $retval{'enc_key'}");
                    main::Log3($name, 3, "MMSOMFY::Command::Decode ($name): rolling_code: $retval{'rolling_code'}");
                }
                else
                {
                    main::Log3($Caller->{NAME}, 1, "MMSOMFY_Parse ($Caller->{NAME}): SOMFY incorrect length for command (".$msg."). Length should be 16");
                }
            }
            else
            {
                main::Log3($Caller->{NAME}, 1, "MMSOMFY_Parse ($Caller->{NAME}): Changed time or repetition. Ignore message.");
            }
        }

        main::Log3($Caller->{NAME}, 4, "MMSOMFY::Command ($Caller->{NAME}): Exit 'Decode'");

        return %retval;
    }

    sub DispatchRemote($$) {
        (my $Remote_FHEM_Hash, my $command) = @_;
        main::Log3($Remote_FHEM_Hash->{NAME}, 4, "MMSOMFY::Command ($Remote_FHEM_Hash->{NAME}): Enter 'DispatchRemote'");

        my $rawdAttr = $main::attr{$Remote_FHEM_Hash->{NAME}}{MMSOMFY::Attribute::rawDevice} if (exists($main::attr{$Remote_FHEM_Hash->{NAME}}{MMSOMFY::Attribute::rawDevice}));

        # check if rdev is defined and exists
        if (defined($rawdAttr))
        {
            main::Log3($Remote_FHEM_Hash->{NAME}, 4, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): rawDevice is '$rawdAttr'");
            
            # normalize address in rawdev
            $rawdAttr = uc($rawdAttr);
            my @rawdevs = split(/\s+/, $rawdAttr);

            foreach my $rawdev (@rawdevs)
            {
                my $slist =  $main::modules{MMSOMFY}{defptr}{$rawdev};

                if (defined($slist))
                {
                    foreach my $n (keys %{$slist})
                    {
                        my $rawhash = $main::modules{MMSOMFY}{defptr}{$rawdev}{$n};
                        main::Log3($Remote_FHEM_Hash->{NAME}, 4, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): Found remote MMSOMFY device '$rawhash->{NAME}'");

                        my $rawModel = $rawhash->{MMSOMFY::Internal::MODEL};
                        my $cmd = $code2command{$rawModel}{$command->{'command'}};

                        if ($cmd)
                        {                          
                            main::Log3($Remote_FHEM_Hash->{NAME}, 4, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): Send command '$cmd'.");

                            main::readingsSingleUpdate($rawhash, MMSOMFY::Reading::enc_key, $command->{'enc_key'}, 1);
                            main::readingsSingleUpdate($rawhash, MMSOMFY::Reading::rolling_code, $command->{'rolling_code'}, 1);

                            # add virtual as modifier to set command without calling send
                            my $ret = main::MMSOMFY_Set($rawhash, $rawhash->{NAME}, MMSOMFY::Mode::virtual, $cmd);
                            if ($ret)
                            {
                                main::Log3($Remote_FHEM_Hash->{NAME}, 1, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): '$rawhash->{NAME}' returned '$ret' for command '$cmd'.");
                            }
                            else
                            {
                                main::Log3($Remote_FHEM_Hash->{NAME}, 4, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): command '$cmd' succeeded for '$rawhash->{NAME}'.");
                                # trigger update of readings, as there may be updates during RemoteCommand.
                                main::DoTrigger($rawhash->{NAME}, undef);
                            }
                        }
                        else
                        {
                            main::Log3($Remote_FHEM_Hash->{NAME}, 1, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): Command code '$cmd' is not valid for remote device '$rawhash->{NAME}'");
                        }
                    }
                } else {
                    main::Log3($Remote_FHEM_Hash->{NAME}, 1, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): rawDevice '$rawdev' not found.");
                }
            }
        } else {
            main::Log3($Remote_FHEM_Hash->{NAME}, 1, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): No rawDevice defined in '$Remote_FHEM_Hash->{NAME}'");
        }
        main::Log3($Remote_FHEM_Hash->{NAME}, 4, "MMSOMFY::Command ($Remote_FHEM_Hash->{NAME}): Exit 'DispatchRemoteCommand'");
    }

    # use first byte and then XORs byte wise with the previous byte until byte 7.
    sub RTS_Crypt($$$) {
        my ($operation, $name, $data) = @_;
        main::Log3($name, 4, "MMSOMFY::Command ($name): Enter 'RTS_Crypt'");

        my $res = substr($data, 0, 2);
        my $ref = ($operation eq "e" ? \$res : \$data);

        for (my $idx=1; $idx < 7; $idx++)
        {
            my $high = hex(substr($data, $idx * 2, 2));
            my $low = hex(substr(${$ref}, ($idx - 1) * 2, 2));

            my $val = $high ^ $low;
            $res .= sprintf("%02X", $val);
        }

        if ($operation eq "e")
        {
            main::Log3($name, 4, "MMSOMFY::Command::RTS_Crypt ($name): dec: $data => enc: $res");
        }
        else
        {
            main::Log3($name, 4, "MMSOMFY::Command::RTS_Crypt ($name): enc: $data => dec: $res");
        }

        main::Log3($name, 4, "MMSOMFY::Command ($name): Exit 'RTS_Crypt'");
        return $res;
    }

    sub RTS_Check($$) {
        my ($name, $data) = @_;
        main::Log3($name, 4, "MMSOMFY::Command ($name): Enter 'RTS_Check'");

        my $checkSum = 0;
        for (my $idx=0; $idx < 7; $idx++)
        {
            my $val = hex(substr($data, $idx * 2, 2));
            $val &= 0xF0 if ($idx == 1);
            $checkSum = $checkSum ^ $val ^ ($val >> 4);
        }

        $checkSum &= hex("0x0F");
        main::Log3($name, 4, "MMSOMFY::Command::RTS_Check ($name): checksum: ". sprintf("%X", $checkSum));

        main::Log3($name, 4, "MMSOMFY::Command ($name): Exit 'RTS_Check'");
        return sprintf("%X", $checkSum);
    }

    sub ChangeCULAttribute($$) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Command ($main::FHEM_Hash->{NAME}): Enter 'ChangeCULAttribute'");

        my ($attribute, $value) = @_;

        # ... create message ...
        my $message = "t" . $value;

        # ... send message to device ...
        # DEBUG deactivated: main::IOWrite($main::FHEM_Hash, "Y", $message);

        # ... and log change.
        main:Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Command::ChangeCULAttribute ($main::FHEM_Hash->{NAME}): Set $attribute to $value for $main::FHEM_Hash->{IODev}->{NAME}");

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Command ($main::FHEM_Hash->{NAME}): Exit 'ChangeCULAttribute'");
    }

    sub Send2Device($$) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Command ($main::FHEM_Hash->{NAME}): Enter 'Send2Device'");

        my $retval = undef;
        my $name = $main::FHEM_Hash->{NAME};
        my $model = $main::FHEM_Hash->{MMSOMFY::Internal::MODEL};
        my $io = $main::FHEM_Hash->{IODev};
        my $ioType = $io->{TYPE};
        my $message = undef;

        my ($cmd, $cmdarg) = @_;

        my $code = $command2code{$cmd};

        # if $code is not defined ...
        unless(defined($code))
        {
            # ... log error ...
            main::Log3($name, 1, "MMSOMFY::Command::Send2Device ($name): Error - Unknown command '$cmd'. Following commands can be sent to device:\n" . join(", ", keys %command2code));

            # ... and set return value for error message.
            $retval = "MMSOMFY::Command::Send2Device ($name): Error - Unknown command '$cmd'. Following commands can be sent to device:\n" . join(", ", keys %command2code);
        }
        # ... otherwise code is known ...
        else
        {
            # ... if code is for z_custom ...
            if($code eq "XX") {
                # use user-supplied custom code
                $code = $cmdarg;
                $cmdarg = undef;
            }

            # ... get current values for enc_key and rolling_code ...
            my $enckey = uc(main::ReadingsVal($name, MMSOMFY::Reading::enc_key, "A0"));
            my $rollingcode = uc(main::ReadingsVal($name, MMSOMFY::Reading::rolling_code, "0000"));

            if
                (
                    # ... enckey is not fixed ...
                    (!main::AttrVal($name, MMSOMFY::Attribute::fixedEnckey, 0)) &&
                    #... and model is not switch ...
                    ($main::FHEM_Hash->{MMSOMFY::Internal::MODEL} ne MMSOMFY::Model::switch)
                )
            {
                # ... convert enckey from string to hex ..
                my $enckey_increment = hex($enckey);

                # ... increment, limit to 0xAF and convert back to string ...
                $enckey = uc(sprintf("%02X", (++$enckey_increment & hex("0xAF"))));
            }

            # ... convert rollincode from string to hex ...
            my $rollingcode_increment = hex($rollingcode);

            # ... increment and convert back to string ...
            $rollingcode = uc(sprintf("%04X", (++$rollingcode_increment)));

            main::Log3($name, 3, "MMSOMFY::Command::Send2Device ($name): command: $cmd($code)");
            main::Log3($name, 3, "MMSOMFY::Command::Send2Device ($name): enc_key: $enckey");
            main::Log3($name, 3, "MMSOMFY::Command::Send2Device ($name): rolling_code: $rollingcode");

            # message looks like this
            # Ys_key_code_chk_rollcode_address
            # Ys ad 2 0 0ae3 a29842
            $message = "s" . $enckey . $code . $rollingcode . uc($main::FHEM_Hash->{ADDRESS}); 

            my $signalRepeats = main::AttrVal($name, 'repetition', $somfy_defrepetition);
            my $symbolLength = main::AttrVal($name, 'symbol-length', $somfy_defsymbolwidth);

            ## In case of a SIGNALduino Io dev ...
            if ($ioType eq "SIGNALduino")
            {
                # ... swap address, remove leading s ...
                my $decData = substr($message, 1, 8) . substr($message, 13, 2) . substr($message, 11, 2) . substr($message, 9, 2);

                # ... calculate checksum for command ....
                my $check = RTS_Check($name, $decData);

                # ... encode command ...
                my $encData = RTS_Crypt("e", $name, substr($decData, 0, 3) . $check . substr($decData, 4));

                # ... create message ...
                $message = 'P43#' . $encData . '#R' . $signalRepeats;

                ## ... log message to be sent to device.
                main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Command::Send2Device ($main::FHEM_Hash->{NAME}): Message: $message");

                # ... and send command to device.
                # DEBUG deactivated: main::IOWrite($main::FHEM_Hash, 'sendMsg', $message);
            }
            # ... otherwise we expect a CUL stick ...
            else
            {
                ## ... if smybol-length shall be different to default ...
                if ($symbolLength ne $somfy_defsymbolwidth)
                {
                    # ... change attribute symbol-length ...
                    ChangeCULAttribute('symbol-length', $symbolLength);
                }

                ## ... if repetition shall be different to default ...
                if ($signalRepeats ne $somfy_defrepetition)
                {
                    # ... change attribute repetition ...
                    ChangeCULAttribute('repetition', $signalRepeats);
                }

                ## ... log message to be sent to device.
                main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Command::Send2Device ($main::FHEM_Hash->{NAME}): Message: $message");

                # ... and send command to device.
                # DEBUG deactivated: main::IOWrite( $FHEM_Hash, "Y", $message );

                ## ... if smybol-length was changed before  ...
                if ($symbolLength ne $somfy_defsymbolwidth)
                {
                    # ... change attribute symbol-length back ...
                    ChangeCULAttribute('symbol-length', $somfy_defsymbolwidth);
                }

                ## ... if repetition was changed before ...
                if ($signalRepeats ne $somfy_defrepetition)
                {
                    # ... change attribute repetition back ...
                    ChangeCULAttribute('repetition', $somfy_defrepetition);
                }
            }

            # ... get address of current module instance ...
            my $address = $main::FHEM_Hash->{ADDRESS};

            # ... get timestamp for current time ...
            my $timestamp = main::TimeNow();

            # ... look for all devices with the instance address, and set state, enc-key, rolling-code and timestamp ...
            foreach my $n (keys %{$main::modules{MMSOMFY}{defptr}{$address}})
            {
                my $lh = $main::modules{MMSOMFY}{defptr}{$address}{$n};
                $lh->{READINGS}{enc_key}{TIME} = $timestamp;
                $lh->{READINGS}{enc_key}{VAL} = $enckey;
                $lh->{READINGS}{rolling_code}{TIME} = $timestamp;
                $lh->{READINGS}{rolling_code}{VAL} = $rollingcode;
                $lh->{DEF} = $address . " " . $model . " " . $enckey . " " . $rollingcode;
            }
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Command ($main::FHEM_Hash->{NAME}): Exit 'Send2Device'");
        return $retval;
    }

1;

################################################################################

# Implementation for MMSOMFY::DeviceModel
package MMSOMFY::DeviceModel;

    use Data::Dumper;

    use constant SimulationKey => "MovementSimulation";
    use constant UpdateFrequency => 1;

    sub UpdateInterval($) {
        my $remainingTime = @_;
        return $remainingTime > UpdateFrequency ? UpdateFrequency : $remainingTime;
    }

    sub Initialize($$$$) {
        # Set verbose to 5 for debugging. Todo Remove
        $main::attr{$main::FHEM_Hash->{NAME}}{"verbose"} = 5;

        main::Log3(
            $main::FHEM_Hash->{NAME},
            4,
            "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Enter 'Intialize'"
        );

        my ($address, $model, $encryptionkey, $rollingcode) = @_;

        MMSOMFY::Internal::Clear();
        MMSOMFY::Reading::Clear();
        MMSOMFY::Attribute::Clear();

        main::Log3(
            $main::FHEM_Hash->{NAME},
            5,
            "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Set address to '$address'"
        );
        
        $main::FHEM_Hash->{ADDRESS} = uc($address);

        main::Log3(
            $main::FHEM_Hash->{NAME},
            5,
            "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Set model to '$model'"
        );
        
        $main::FHEM_Hash->{MMSOMFY::Internal::MODEL} = lc($model);

        # Add the device specific attributes to the instance depending on model.
        MMSOMFY::Attribute::AddSpecificAttributes();

        # Set common readings for device if set.
        MMSOMFY::Reading::SetCommon($encryptionkey, $rollingcode);

        if ($model eq MMSOMFY::Model::switch)
        {
            $main::FHEM_Hash->{STATE} = MMSOMFY::State::off;
            $main::attr{$main::FHEM_Hash->{NAME}}{webCmd} = "toggle";
            $main::attr{$main::FHEM_Hash->{NAME}}{devStateIcon} = "off:15px-grey on:15px-green";
            $main::attr{$main::FHEM_Hash->{NAME}}{cmdIcon} = "toggle:control_standby";
        }
        elsif ($model eq MMSOMFY::Model::remote)
        {
            $main::FHEM_Hash->{STATE} = MMSOMFY::State::receiving;
            $main::attr{$main::FHEM_Hash->{NAME}}{devStateIcon} = "receiving:it_wifi";
        }
        elsif
            (
                $model eq MMSOMFY::Model::awning ||
                $model eq MMSOMFY::Model::shutter
            )
        {
            $main::FHEM_Hash->{STATE} = MMSOMFY::State::opened;
            $main::FHEM_Hash->{MMSOMFY::Internal::TIMING} = MMSOMFY::Timing::off;
            $main::attr{$main::FHEM_Hash->{NAME}}{webCmd} = "open:close";
            $main::attr{$main::FHEM_Hash->{NAME}}{cmdIcon} = "open:control_centr_arrow_up close:control_centr_arrow_down";

            $main::attr{$main::FHEM_Hash->{NAME}}{devStateIcon} = ($model eq MMSOMFY::Model::shutter)
                ? "opened:fts_window_2w closed:fts_shutter_100"
                : "opened:fts_window_2w closed:fts_sunblind_100";
        }
        else
        {
            $main::FHEM_Hash->{STATE} = MMSOMFY::State::unknown;
        }

        main::Log3(
            $main::FHEM_Hash->{NAME},
            4,
            "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Exit 'Intialize'"
        );
    }

    # Update device model according to set attributes.
    sub Update($$) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Enter 'Update'");
        
        my ($attrName, $attrValue) = @_;
        my $name = $main::FHEM_Hash->{NAME};

        # If attribute is a timing value ...
        if ($attrName =~/driveTime.*/)
        {
            # ... get current timing values ...
            my %tempTimings;        
            $tempTimings{MMSOMFY::Attribute::driveTimeOpenedToDown} = $main::attr{$name}{MMSOMFY::Attribute::driveTimeOpenedToDown};
            $tempTimings{MMSOMFY::Attribute::driveTimeOpenedToClosed} = $main::attr{$name}{MMSOMFY::Attribute::driveTimeOpenedToClosed};
            $tempTimings{MMSOMFY::Attribute::driveTimeClosedToDown} = $main::attr{$name}{MMSOMFY::Attribute::driveTimeClosedToDown};
            $tempTimings{MMSOMFY::Attribute::driveTimeClosedToOpened} = $main::attr{$name}{MMSOMFY::Attribute::driveTimeClosedToOpened};
            $tempTimings{$attrName} = $attrValue;

            my $symbol = ($main::FHEM_Hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::shutter)
                ? "shutter"
                : "sunblind";

            # if basic timing values are defined ...
            if (defined($tempTimings{MMSOMFY::Attribute::driveTimeClosedToOpened}) && defined($tempTimings{MMSOMFY::Attribute::driveTimeOpenedToClosed}))
            {
                # ... check if extended timing values are defined ...
                if (defined($tempTimings{MMSOMFY::Attribute::driveTimeClosedToDown}) && defined($tempTimings{MMSOMFY::Attribute::driveTimeOpenedToDown}))
                {
                    # ... then set TIMING to extended.
                    main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Set " . MMSOMFY::Internal::TIMING . " to " . MMSOMFY::Timing::extended);
                    $main::FHEM_Hash->{MMSOMFY::Internal::TIMING} = MMSOMFY::Timing::extended;
                }
                else
                {
                    # ... otherwise TIMING is basic.
                    main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Set " . MMSOMFY::Internal::TIMING . " to " . MMSOMFY::Timing::basic);
                    $main::FHEM_Hash->{MMSOMFY::Internal::TIMING} = MMSOMFY::Timing::basic;
                }

                # set attributes
                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Adjust attributes for Timing " . $main::FHEM_Hash->{MMSOMFY::Internal::TIMING});
                $main::attr{$main::FHEM_Hash->{NAME}}{webCmd} = "open:stop:close";
                $main::attr{$main::FHEM_Hash->{NAME}}{cmdIcon} = "open:control_centr_arrow_up close:control_centr_arrow_down stop:rc_STOP";
                $main::attr{$main::FHEM_Hash->{NAME}}{stateFormat} = "{ ReadingsVal(\"$name\", \"" . MMSOMFY::Reading::movement . "\", \"" . MMSOMFY::Movement::none ."\") . \"\\n\" . ReadingsVal(\"$name\", \"" . MMSOMFY::Reading::position . "\", \"0\") }";

                $main::attr{$main::FHEM_Hash->{NAME}}{devStateIcon} = ""
                    . "\\d:fts_window_2w "
                    . "1\\d:fts_${symbol}_10 "
                    . "2\\d:fts_${symbol}_20 "
                    . "3\\d:fts_${symbol}_30 "
                    . "4\\d:fts_${symbol}_40 "
                    . "5\\d:fts_${symbol}_50 "
                    . "6\\d:fts_${symbol}_60 "
                    . "7\\d:fts_${symbol}_70 "
                    . "8\\d:fts_${symbol}_80 "
                    . "9\\d:fts_${symbol}_90 "
                    . "10\\d:fts_${symbol}_100 "
                    . "none:audio_rec "
                    . "up:control_centr_arrow_up "
                    . "down:control_centr_arrow_down";

                # reset reading time on def to 0 seconds (1970)
                my $tNow = main::TimeNow();

                my $position = MMSOMFY::Position::FromState($main::FHEM_Hash->{STATE});

                main::readingsBeginUpdate($main::FHEM_Hash);

                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Add " . MMSOMFY::Reading::exact . " with $position");
                main::readingsBulkUpdate($main::FHEM_Hash, MMSOMFY::Reading::exact, $position, 1);

                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Add " . MMSOMFY::Reading::position . " with $position");
                main::readingsBulkUpdate($main::FHEM_Hash, MMSOMFY::Reading::position, $position, 1);

                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Add " . MMSOMFY::Reading::movement . " with " . MMSOMFY::Movement::none);
                main::readingsBulkUpdate($main::FHEM_Hash, MMSOMFY::Reading::movement, MMSOMFY::Movement::none, 1);

                main::readingsEndUpdate($main::FHEM_Hash,1);
            }
            # ... otherwise ...
            else
            {
                # ... TIMING is off as the values cannot be used.
                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Adjust readings for Timing " . MMSOMFY::Timing::off);
                $main::FHEM_Hash->{MMSOMFY::Internal::TIMING} = MMSOMFY::Timing::off;

                my $exact = main::ReadingsVal($main::FHEM_Hash->{NAME}, MMSOMFY::Reading::exact, 0);
                my $movement = main::ReadingsVal($main::FHEM_Hash->{NAME}, MMSOMFY::Reading::movement, MMSOMFY::Movement::none);
                $main::FHEM_Hash->{STATE} = MMSOMFY::Position::ToState($exact, $movement);
                main::readingsDelete($main::FHEM_Hash, MMSOMFY::Reading::exact);
                main::readingsDelete($main::FHEM_Hash, MMSOMFY::Reading::position);
                main::readingsDelete($main::FHEM_Hash, MMSOMFY::Reading::movement);

                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Adjust attributes for Timing " . MMSOMFY::Timing::off);
                $main::attr{$main::FHEM_Hash->{NAME}}{webCmd} = "open:close";
                $main::attr{$main::FHEM_Hash->{NAME}}{cmdIcon} = "open:control_centr_arrow_up close:control_centr_arrow_down";
                $main::attr{$main::FHEM_Hash->{NAME}}{devStateIcon} = "opened:fts_window_2w closed:fts_${symbol}_100";
                delete($main::attr{$main::FHEM_Hash->{NAME}}{stateFormat});
            }
        }
        
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Exit 'Update'");
    }

    sub TimerCallback($)
    {
        my ($hash) = @_;
        main::Log3($hash->{NAME}, 4, "MMSOMFY::DeviceModel ($hash->{NAME}): Enter 'TimerCallback'");

        if (defined($hash->{SimulationKey}))
        {
            my $Simulation = $hash->{SimulationKey};
            main::Log3($hash->{NAME}, 4, "MMSOMFY::DeviceModel ($hash->{NAME}): Simulation => " . Dumper($Simulation));
            my $exact = main::ReadingsVal($hash->{NAME}, MMSOMFY::Reading::exact, undef);
            my $movement = main::ReadingsVal($hash->{NAME}, MMSOMFY::Reading::movement, undef);
            my $dt = main::gettimeofday() - $Simulation->{StartTime};
            main::Log3($hash->{NAME}, 4, "MMSOMFY::DeviceModel ($hash->{NAME}): exact => $exact, dt => $dt");

            if ($Simulation->{Command} eq MMSOMFY::Command::open)
            {
                if ($hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::basic)
                {
                    my $driveTime = MMSOMFY::Timing::Closed2Opened($hash);
                    $exact = $Simulation->{StartExact} - MMSOMFY::Position::RANGE * $dt / $driveTime;
                    $exact = MMSOMFY::Position::MinPos if ($exact < MMSOMFY::Position::MinPos || ($exact - MMSOMFY::Position::MinPos) < 0.1);

                    if ($exact eq MMSOMFY::Position::MinPos)
                    {
                        delete $hash->{SimulationKey};
                        $movement = MMSOMFY::Movement::none;
                    }
                    else
                    {
                        main::InternalTimer(main::gettimeofday() + UpdateFrequency, "MMSOMFY::DeviceModel::TimerCallback", $hash);
                    }
                }
                elsif ($hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::extended)
                {
                    # Implement extended timing
                }
            }
            elsif ($Simulation->{Command} eq MMSOMFY::Command::close)
            {
                if ($hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::basic)
                {
                    my $driveTime = MMSOMFY::Timing::Opened2Closed($hash);
                    main::Log3($hash->{NAME}, 4, "MMSOMFY::DeviceModel ($hash->{NAME}): $Simulation->{StartExact} | ". MMSOMFY::Position::RANGE . " | $dt / $driveTime");
                    $exact = $Simulation->{StartExact} + MMSOMFY::Position::RANGE * $dt / $driveTime;
                    $exact = MMSOMFY::Position::MaxPos if ($exact > MMSOMFY::Position::MaxPos || (MMSOMFY::Position::MaxPos - $exact) < 0.1);

                    if ($exact eq MMSOMFY::Position::MaxPos)
                    {
                        delete $hash->{SimulationKey};                        
                        $movement = MMSOMFY::Movement::none;
                    }
                    else
                    {
                        main::InternalTimer(main::gettimeofday() + UpdateFrequency, "MMSOMFY::DeviceModel::TimerCallback", $hash);
                    }
                }
                elsif ($hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::extended)
                {
                    # Implement extended timing
                }
            }

            MMSOMFY::Reading::PositionUpdate($exact, $movement, $hash);
        }

        main::Log3($hash->{NAME}, 4, "MMSOMFY::DeviceModel ($hash->{NAME}): Exit 'TimerCallback'");
    }

    sub CalculateSwitch($$)
    {
        main::Log3(
            $main::FHEM_Hash->{NAME},
            4,
            "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Enter 'CalculateSwitch'"
        );

        my ($cmd, $cmdarg) = @_;

        # Cancel any extension function if running
        main::SetExtensionsCancel($main::FHEM_Hash);

        if ($cmd eq MMSOMFY::Command::on)
        {
            $main::FHEM_Hash->{STATE} = MMSOMFY::State::on;
        }
        elsif ($cmd eq MMSOMFY::Command::off)
        {
            $main::FHEM_Hash->{STATE} = MMSOMFY::State::off;
        }

        main::Log3(
            $main::FHEM_Hash->{NAME},
            4, 
            "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Exit 'CalculateSwitch'"
        );
    }

    sub CalculateAwningShutter($$)
    {
        main::Log3(
            $main::FHEM_Hash->{NAME},
            4,
            "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Enter 'CalculateAwningShutter'"
        );

        my ($cmd, $cmdarg) = @_;

        # Check if timer is running.
        # If so calculate current position and remove timer.
        # Afterwards you can start new command

        if ($cmd eq MMSOMFY::Command::open)
        {
            if ($main::FHEM_Hash->{TIMING} eq MMSOMFY::Timing::off)
            {
                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Set state to ". MMSOMFY::State::opened);
                $main::FHEM_Hash->{STATE} = MMSOMFY::State::opened;
            }
            elsif ($main::FHEM_Hash->{TIMING} eq MMSOMFY::Timing::basic)
            {
                my $movement = main::ReadingsVal($main::FHEM_Hash->{NAME}, MMSOMFY::Reading::movement, undef);
                my $exact = main::ReadingsVal($main::FHEM_Hash->{NAME}, MMSOMFY::Reading::exact, undef);

                if ($movement eq MMSOMFY::Movement::up || $exact eq MMSOMFY::Position::MinPos)
                {
                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Ignore command '$cmd' as device is already going up or is already opened");
                }
                elsif ($movement eq MMSOMFY::Movement::none)
                {
                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Start moving up");
                    main::readingsSingleUpdate($main::FHEM_Hash, MMSOMFY::Reading::movement, MMSOMFY::Movement::up, 1);

                    my $startTime = main::gettimeofday();

                    $main::FHEM_Hash->{SimulationKey} = {
                        StartTime => $startTime,
                        StartExact => $exact,
                        Command => $cmd
                    };

                    $main::FHEM_Hash->{SimulationKey}{Arguments} = $cmdarg if (defined($cmdarg));

                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Start timer for moving up");
                    main::InternalTimer(main::gettimeofday() + UpdateFrequency, "MMSOMFY::DeviceModel::TimerCallback", $main::FHEM_Hash);
                }
                elsif ($movement eq MMSOMFY::Movement::down)
                {
                    # Opposite direction
                }
            }
        }
        elsif ($cmd eq MMSOMFY::Command::close)
        {
            if ($main::FHEM_Hash->{TIMING} eq MMSOMFY::Timing::off)
            {
                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Set state to ". MMSOMFY::State::closed);
                $main::FHEM_Hash->{STATE} = MMSOMFY::State::closed;
            }
            elsif ($main::FHEM_Hash->{TIMING} eq MMSOMFY::Timing::basic)
            {
                my $movement = main::ReadingsVal($main::FHEM_Hash->{NAME}, MMSOMFY::Reading::movement, undef);
                my $exact = main::ReadingsVal($main::FHEM_Hash->{NAME}, MMSOMFY::Reading::exact, undef);
                main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): movement: $movement, exact: $exact");

                if ($movement eq MMSOMFY::Movement::down || $exact eq MMSOMFY::Position::MaxPos)
                {
                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Ignore command '$cmd' as device is already going up or is already opened");
                }
                elsif ($movement eq MMSOMFY::Movement::none)
                {
                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Start moving down");
                    main::readingsSingleUpdate($main::FHEM_Hash, MMSOMFY::Reading::movement, MMSOMFY::Movement::down, 1);

                    my $startTime = main::gettimeofday();

                    $main::FHEM_Hash->{SimulationKey} = {
                        StartTime => $startTime,
                        StartExact => $exact,
                        Command => $cmd
                    };

                    $main::FHEM_Hash->{SimulationKey}{Arguments} = $cmdarg if (defined($cmdarg));

                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Start timer for moving down");
                    main::InternalTimer(main::gettimeofday() + UpdateFrequency, "MMSOMFY::DeviceModel::TimerCallback", $main::FHEM_Hash);
                }
                elsif ($movement eq MMSOMFY::Movement::up)
                {
                    # Opposite direction
                }
            }
        }
        elsif ($cmd eq MMSOMFY::Command::go_my)
        {
            if ($main::FHEM_Hash->{TIMING} eq MMSOMFY::Timing::off)
            {
                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Nothing to be done with command '$cmd' with timing '" . MMSOMFY::Timing::off . "'");
            }
            elsif ($main::FHEM_Hash->{TIMING} eq MMSOMFY::Timing::basic)
            {
                main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): timing is basic");
                #$main::FHEM_Hash->{STATE} = MMSOMFY::State::opened;
            }
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Exit 'CalculateAwningShutter'");
    }

    sub Calculate($$$)
    {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Enter 'Update'");
        my ($mode, $cmd, $cmdarg) = @_;

        my $model = $main::FHEM_Hash->{MMSOMFY::Internal::MODEL};
        if ($model eq MMSOMFY::Model::switch)
        {
            CalculateSwitch($cmd, $cmdarg);
        }
        elsif
            (
                $model eq MMSOMFY::Model::awning ||
                $model eq MMSOMFY::Model::shutter
            )
        {
            CalculateAwningShutter($cmd, $cmdarg);
        }
        else
        {
            main::Log3($main::FHEM_Hash->{NAME}, 3, "Unhandled model.");
        }

        if ($mode eq MMSOMFY::Mode::virtual)
        {
            $cmd = undef;
            $cmdarg = undef;
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Exit 'Update'");
        return ($cmd, $cmdarg)
    }

1;

################################################################################

package main;

use strict;
use warnings;
use SetExtensions;
use Scalar::Util qw(looks_like_number);
use Data::Dumper;

our $FHEM_Hash;

my %somfy_codes2cmd = (
    "10" => "go_my",            # goto "my" position
    "11" => "stop",             # stop the current movement
    "20" => "open",             # go "up"
    "40" => "close",            # go "down"
    "80" => "prog",             # finish pairing
    "90" => "wind_sun_9",       # wind and sun (sun + flag)
    "A0" => "wind_only_a",      # wind only (flag)
    "100" => "close_for_timer",
    "101" => "open_for_timer",
    "XX" => "z_custom",         # custom control code
);

my %somfy_sendCommands = (
    "open" => "open",
    "close" => "close",
);

my %somfy_cmd2codes = reverse %somfy_codes2cmd;

my $somfy_updateFreq = 3;   # Interval for State update


################################################################################
# new globals for new set
################################################################################
my $somfy_posAccuracy = 2;
my $somfy_maxRuntime = 50;

my %positions = (
    "moving" => "50",
    "go_my" => "95",
    "opened" => "0",
    "down" => "95",
    "closed" => "100"
);

my %translations = (
    "0" => "opened",
    "95" => "down",
    "100" => "closed"
);

my %translations100To0 = (
    "100" => "opened",
    "5" => "down",
    "0" => "closed"
);

################################################################################
# Forward declarations
################################################################################
sub _MMSOMFY_CalcCurrentPos($$$);
sub _MMSOMFY_isSwitch($);

################################################################################
################################################################################
##
## Module operation - type + instance
##
################################################################################
################################################################################

################################################################################
# FHEM module interface
################################################################################
sub MMSOMFY_Initialize($) {
    ($FHEM_Hash) = @_;

    ##########################################
    # Map functions for fhem module interface
    ##########################################
    $FHEM_Hash->{DefFn}         = "MMSOMFY_Define";
    $FHEM_Hash->{UndefFn}       = "MMSOMFY_Undef";
    # $FHEM_Hash->{DeleteFn}    = "X_Delete";
    $FHEM_Hash->{SetFn}         = "MMSOMFY_Set";
    # $FHEM_Hash->{GetFn}       = "X_Get";
    $FHEM_Hash->{AttrFn}        = "MMSOMFY_Attr";
    # $FHEM_Hash->{ReadFn}      = "X_Read";
    # $FHEM_Hash->{ReadyFn}     = "X_Ready";
    # $FHEM_Hash->{NotifyFn}    = "X_Notify";
    # $FHEM_Hash->{RenameFn}    = "X_Rename";
    # $FHEM_Hash->{ShutdownFn}  = "X_Shutdown";

    #####################################################
    # Publish attributes supported by the module to fhem
    #####################################################
    $FHEM_Hash->{AttrList} = $readingFnAttributes; # . " " . MMSOMFY::Attribute::ToString;

    ######################################################
    # Map functions for logical module in two-stage model
    ######################################################
    $FHEM_Hash->{ParseFn} = "MMSOMFY_Parse";
    $FHEM_Hash->{Match}   = "^Ys..............\$";
}


################################################################################
# The define function of a module is called by FHEM when the define command is 
# executed for a device and the module is already loaded and initialized with the 
# initialize function.
################################################################################
sub MMSOMFY_Define($$) {
    ($FHEM_Hash, my $def) = @_;

    Log3($FHEM_Hash->{NAME}, 4, "MMSOMFY_Define ($FHEM_Hash->{NAME}): Enter");

    my @a = split("[ \t][ \t]*", $def);
    my $errormessage;
    $errormessage .= "Command: define $def\n\n";
    $errormessage .= "Syntax: define <name> MMSOMFY <address> <model> [<encryption-key>] [<rolling-code>]\n\n";

    # fail early and display syntax help
    if (int(@a) < 4)
    {
        $errormessage .= "Error: Wrong syntax.";
        return $errormessage;
    }

    # check address format (6 hex digits)
    if (( $a[2] !~ m/^[a-fA-F0-9]{6}$/i))
    {
        $errormessage .= "Error: Wrong format of <address> '$a[2]': specify a 6 digit hex value.";
        return $errormessage;
    }

    # check model to be valid
    unless (MMSOMFY::Model->can($a[3]))
    {
        $errormessage .= "Error: Unknown <model> '$a[3]': use one of " . MMSOMFY::Model::ToString(", ") . ".";
        return $errormessage;
    }

    # group devices by their address
    my $name  = $a[0];
    my $address = $a[2];
    my $model = $a[3];
    my $encryptionkey = undef;
    my $rollingcode = undef;

    # check optional arguments for device definition
    if (int(@a) > 4) 
    {
        # check encryption key (2 hex digits)
        if (($a[4] !~ m/^[a-fA-F0-9]{2}$/i))
        {
            $errormessage .= "Error: Wrong format of <encryption-key> '$a[4]': specify a 2 digit hex value.";
            return $errormessage;
        }

        # set enc key uppercase
        $encryptionkey = uc($a[4]);
    }

    if (int(@a) > 5)
    {
        # check rolling code (4 hex digits)
        if (($a[5] !~ m/^[a-fA-F0-9]{4}$/i))
        {
            $errormessage .= "Error: Wrong format of <rolling-code> '$a[5]': specify a 4 digit hex value.";
            return $errormessage;
        }

        # set rolling code uppercase
        $rollingcode = uc($a[5]);
    }

    my $code  = uc($address);
    my $ncode = 1;
    $FHEM_Hash->{CODE}{$ncode++} = $code;
    $modules{MMSOMFY}{defptr}{$code}{$name} = $FHEM_Hash;

    # Initialize definitions for instance depending on model.
    MMSOMFY::DeviceModel::Initialize($address, $model, $encryptionkey, $rollingcode);

    AssignIoPort($FHEM_Hash);

    Log3($FHEM_Hash->{NAME}, 4, "MMSOMFY_Define ($FHEM_Hash->{NAME}): Exit");
}

################################################################################
# The undef function is called when a device is deleted with delete or when
# processing the rereadcfg command, which also deletes all devices and then
# reads the configuration file again.
################################################################################
sub MMSOMFY_Undef($$) {
    ($FHEM_Hash, my $name) = @_;

    Log3($FHEM_Hash->{NAME}, 4, "MMSOMFY_Undef ($FHEM_Hash->{NAME}): Enter");

    foreach my $c (keys %{$FHEM_Hash->{CODE}})
    {
        $c = $FHEM_Hash->{CODE}{$c};

        # As after a rename the $name my be different from the $defptr{$c}{$n}
        # we look for the hash.
        foreach my $dname (keys %{$modules{MMSOMFY}{defptr}{$c}})
        {
            if ($modules{MMSOMFY}{defptr}{$c}{$dname} == $FHEM_Hash)
            {
                delete($modules{MMSOMFY}{defptr}{$c}{$dname});
            }
        }
    }

    Log3($FHEM_Hash->{NAME}, 4, "MMSOMFY_Undef ($FHEM_Hash->{NAME}): Exit");
    return undef;
}

################################################################################
# The Attr function is used to check attributes that can be set using the attr
# command. As soon as an attempt is made to set an attribute for a device, the
# Attr function of the corresponding module is called beforehand to check
# whether the attribute is correct from the module's point of view. If there is
# a problem with the attribute or the value, the function must return a
# meaningful error message that is displayed to the user. If the given attribute
# and its content are correct, the Attr function returns the value undef.
# Only then is the attribute saved in the global data structure %attr and is
# therefore only active.
################################################################################
sub MMSOMFY_Attr(@) {
    my ($cmd,$name,$aName,$aVal) = @_;
    $FHEM_Hash = $defs{$name};

    return "\"MMSOMFY Attr: \" $name does not exist" if (!defined($FHEM_Hash));
    Log3($FHEM_Hash->{NAME}, 4, "MMSOMFY_Attr ($FHEM_Hash->{NAME} / $aName): Enter");
    Log3($FHEM_Hash->{NAME}, 5, "MMSOMFY_Attr ($FHEM_Hash->{NAME}): $cmd $aName ($aVal)") if (defined($aVal));
    Log3($FHEM_Hash->{NAME}, 5, "MMSOMFY_Attr ($FHEM_Hash->{NAME}): $cmd $aName") if (!defined($aVal));
    
    my $retval = undef;

    # $cmd can be "del" or "set"
    # $name is device name
    # aName and aVal are Attribute name and value

    # Convert in case of change to positionInverse --> but only after init is done on restart this should not be recalculated
    if (($aName eq MMSOMFY::Attribute::positionInverse) && ($init_done))
    {
        # JM: To be refined
        my $rounded;
        my $stateTrans;
        my $pos = ReadingsVal($name,'exact',undef);

        if (!defined($pos))
        {
            $pos = ReadingsVal($name,'position',undef);
        }

        if ($cmd eq "set")
        {
            if (($aVal) && (! AttrVal($name, MMSOMFY::Attribute::positionInverse, 0)))
            {
                # set to 1 and was 0 before - convert To100To10
                # first exact then round to pos
                $pos = _MMSOMFY_ConvertTo100To0($pos);
                $rounded = _MMSOMFY_Runden($pos);
                $stateTrans = _MMSOMFY_Translate100To0($rounded);
            }
            elsif ((!$aVal) && (AttrVal($name, MMSOMFY::Attribute::positionInverse, 0)))
            {
                # set to 0 and was 1 before - convert From100To10
                # first exact then round to pos
                $pos = _MMSOMFY_ConvertFrom100To0($pos);
                $rounded = _MMSOMFY_Runden($pos);
                $stateTrans = _MMSOMFY_Translate($rounded);
            }
        }
        elsif ($cmd eq "del")
        {
            if (AttrVal($name, MMSOMFY::Attribute::positionInverse, 0))
            {
                # delete and was 1 before - convert From100To10
                # first exact then round to pos
                $pos = _MMSOMFY_ConvertFrom100To0($pos);
                $rounded = _MMSOMFY_Runden($pos);
                $stateTrans = _MMSOMFY_Translate($rounded);
            }
        }
        
        if (defined($rounded))
        {
            readingsBeginUpdate($FHEM_Hash);
            readingsBulkUpdate($FHEM_Hash,"position",$rounded);
            readingsBulkUpdate($FHEM_Hash,"exact",$pos);
            #readingsBulkUpdate($FHEM_Hash,"state",$stateTrans);
            readingsEndUpdate($FHEM_Hash,1);
        }
    }

    # ... check if attribute is a valid timing setting ...
    # Third argument is attribute value as a reference, as it will be modified inside method.
    $retval = MMSOMFY::Attribute::CheckAttribute($cmd, $aName, $_[3], $init_done);

    Log3($FHEM_Hash->{NAME}, 4, "MMSOMFY_Attr ($FHEM_Hash->{NAME} / $aName): Exit");
    return $retval;
}

##############################################################################
##############################################################################
##
## Parse a received command
##
##############################################################################
##############################################################################
sub MMSOMFY_Parse($$) {
    (my $Caller, my $msg) = @_;
    Log3($Caller->{NAME}, 4, "MMSOMFY_Parse ($Caller->{NAME}): Enter");

    my $retval = undef;

    my %command = MMSOMFY::Command::Decode($Caller, $msg);

    if (keys %command)
    {
        my $def = $modules{MMSOMFY}{defptr}{$command{'address'}};

        if ($def && (keys %{$def}))
        {
            my @list;

            foreach my $name (keys %{$def})
            {
                my $lh = $def->{$name};
                $name = $lh->{NAME};        # It may be renamed

                unless(IsIgnored($name))
                {
                    if ($lh->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::remote)
                    {
                        # update the state and log it
                        # Debug "MMSOMFY Parse: $name msg: $msg  --> $cmd-$newstate";
                        Log3($Caller->{NAME}, 3, "MMSOMFY_Parse ($Caller->{NAME}): Command $command{'command_desc'}($command{'command'}) from remote $name($command{'address'})");
                        readingsSingleUpdate($lh, MMSOMFY::Reading::enc_key, $command{'enc_key'}, 1);
                        readingsSingleUpdate($lh, MMSOMFY::Reading::rolling_code, $command{'rolling_code'}, 1);
                        readingsSingleUpdate($lh, MMSOMFY::Reading::received, $command{'command'}, 1);
                        readingsSingleUpdate($lh, MMSOMFY::Reading::command, $command{'command_desc'}, 1);

                        MMSOMFY::Command::DispatchRemote($lh, \%command);

                        push(@list, $name);
                    }
                }
            }

            # return list of affected devices
            $retval = join(",", @list);
        } else {
            Log3($Caller->{NAME}, 1, "MMSOMFY_Parse ($Caller->{NAME}): Unknown device $command{'address'} ($command{'enc_key'} $command{'rolling_code'}), please define it.");
            $retval = "UNDEFINED MMSOMFY_$command{'address'} MMSOMFY $command{'address'} remote";
        }
    }

    Log3($Caller->{NAME}, 4, "MMSOMFY_Parse ($Caller->{NAME}): Exit");
    return $retval;
}

##############################################################################
##############################################################################
##
## Central SET routine (internal and external)
##
##############################################################################
##############################################################################

##################################################
### New set (state) method (using internalset)
###
### Reimplemented calculations for position readings and state
### Allowed sets to be done without sending actually commands to the awning
###     syntax set <name> [ <virtual|send> ] <normal set parameter>
### position and state are also updated on stop or other commands based on remaining time
### position is handled between 0 and 100 awning down but not completely closed and 200 completely closed
###     if timings for 100 and close are equal no position above 100 is used (then 100 == closed)
### position is rounded to a value of 5 and state is rounded to a value of 10
#
### General assumption times are rather on the upper limit to reach desired state


# Readings
## state contains rounded (to 10) position and/or textField
## position contains rounded position (limited detail)

# STATE
## might contain position or textual form of the state (same as STATE reading)

###################################
# call with hash, name, [virtual/send], set-args   (send is default if ommitted)
# hash name [mode] [cmd|val] [val]
sub MMSOMFY_Set($@) {
    ($FHEM_Hash, my @args) = @_;

    Log3($FHEM_Hash->{NAME}, 4, "MMSOMFY_Set ($FHEM_Hash->{NAME}): Enter");

    my $retval = undef;
    my $name;
    my $mode;
    my $cmd;
    my $cmdarg;
    my @addargs;

    # Parse arguments
    while (int(@args) > 0)
    {
        # if name is not yet defined ...
        if (!defined($name))
        {
            # ... use 1st argument as name ...
            $name = shift @args;

            # ... if module instance with this name is ignored, argument parsing is stopped.
            last if (IsIgnored($name));
        }
        # ... then if mode is not yet defined ...
        elsif (!defined($mode))
        {
            # ... if 2nd argument is a mode value ...
            my $modelist = MMSOMFY::Mode::ToString('|');
            if (lc($args[0]) =~ m/$modelist/)
            {
                # ... take given mode value ...
                $mode = lc(shift @args);
                Log3($name, 3, "MMSOMFY_Set ($name): Mode set to " . $mode);
            }
            else
            {
                # ... otherwise use default 'send' and let argument list unmodified for next loop cycle.
                $mode = MMSOMFY::Mode::send;
                Log3($name, 3, "MMSOMFY_Set ($name): Mode not set during parse arguments, use default 'send'");
            }
        }
        # ... then if cmd is not yet defined ...
        elsif (!defined($cmd))
        {
            # ... if next argument (2nd or 3rd, depends on mode) to be a number ...
            if (looks_like_number($args[0]))
            {
                # ... assume "position" command ...
                Log3($name, 3, "MMSOMFY_Set ($name): Numerical value found instead of command during parse arguments, use default '" . MMSOMFY::Command::position . "' for command");
                $cmd = MMSOMFY::Command::position;
            }
            # ... otherwise use given command ...
            else
            {
                $cmd = lc(shift @args);
                Log3($name, 3, "MMSOMFY_Set ($name): Command set to '" . $cmd . "'.");
            }
        }
        # ... then if command argument is not yet defined ...
        elsif (!defined($cmdarg))
        {
            # ... use next argument as command argument ...
            $cmdarg = shift @args;
            Log3($name, 3, "MMSOMFY_set ($name): Command arguments set to '" . $cmdarg . "'.") if (defined($cmdarg));
        }
        else
        {
            # Store remaining arguments as additional arguments ...
            @addargs = @args;
            @args = ();
            Log3($name, 2, "MMSOMFY_Set ($name): More arguments found.\nRemaining arguments (" . join(", ", @addargs) . ") are for command extensions only.");
        }
    }

    # Check if command is valid for this module instance.
    # valid  : $retval undefined / $mode, $cmd and $cmdarg adjusted to fit.
    # invalid: $retval list of possible commands / $cmd undef
    $retval = MMSOMFY::Command::Check($mode, $cmd, $cmdarg, @addargs);

    # if cmd is defined parsing was successful and a valid command shall be executed.
    if (defined($cmd))
    {
        # Command shall be executed.
        # Write log message for command to be executed.
        my $logmessage = "MMSOMFY_set ($name): Handling with mode: $mode / cmd: $cmd";
        $logmessage .= " / cmdarg: $cmdarg" if defined($cmdarg);
        Log3($name, 3, $logmessage);

        ($cmd, $cmdarg) = MMSOMFY::DeviceModel::Calculate($mode, $cmd, $cmdarg);

        MMSOMFY::Command::Send2Device($cmd, $cmdarg) if defined($cmd);
    }

    Log3($FHEM_Hash->{NAME}, 4, "MMSOMFY_Set ($FHEM_Hash->{NAME}): Exit");

    return $retval;
} # end sub MMSOMFY_setFN
###############################

##############################################################################
##############################################################################
##
## Internal helper - not position related
##
##############################################################################
##############################################################################

######################################################
######################################################
###
### Helper for set routine
###
######################################################
######################################################

###################################
sub _MMSOMFY_Runden($) {
    # Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_Runden ($FHEM_Hash->{NAME}): Enter");

    # my ($v) = @_;
    # if ( ( $v > 105 ) && ( $v < 195 ) ) {
    #     $v = 150;
    # } else {
    #     $v = int(($v + 5) /10) * 10;
    # }

    # Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_Runden ($FHEM_Hash->{NAME}): Exit");
    # return sprintf("%d", $v );
} # end sub Runden


###################################
sub _MMSOMFY_Translate($) {
    # Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_Translate ($FHEM_Hash->{NAME}): Enter");

    # my ($v) = @_;

    # if(exists($translations{$v})) {
    #     $v = $translations{$v}
    # }

    # Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_Translate ($FHEM_Hash->{NAME}): Exit");
    # return $v
}

###################################
sub _MMSOMFY_Translate100To0($) {
    # Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_Translate100To0 ($FHEM_Hash->{NAME}): Enter");

    # my ($v) = @_;

    # if(exists($translations100To0{$v})) {
    #     $v = $translations100To0{$v}
    # }

    # Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_Translate100To0 ($FHEM_Hash->{NAME}): Exit");
    # return $v
}


#############################
sub _MMSOMFY_ConvertFrom100To0($) {
#     Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_ConvertFrom100To0 ($FHEM_Hash->{NAME}): Enter");

#     my ($v) = @_;

#   return $v if ( ! defined($v) );
#   return $v if ( length($v) == 0 );
#   return $v if ( $v =~ /^(close|open)$/);

#   $v = minNum( 100, maxNum( 0, $v ) );

#     Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_ConvertFrom100To0 ($FHEM_Hash->{NAME}): Exit");
#   return (( $v < 10 ) ? ( 200-($v*10.0) ) : ( (100-$v)*10.0/9 ));
}

#############################
sub _MMSOMFY_ConvertTo100To0($) {
#     Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_ConvertTo100To0 ($FHEM_Hash->{NAME}): Enter");

#     my ($v) = @_;

#   return $v if ( ! defined($v) );
#   return $v if ( length($v) == 0 );

#   $v = minNum( 200, maxNum( 0, $v ) );

#     Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_ConvertTo100To0 ($FHEM_Hash->{NAME}): Exit");
#   return ( $v > 100 ) ? ( (200-$v)/10.0 ) : ( 100-(9*$v/10.0) );
}

###################################
# calulates the position depending on moving direction ($move), last position ($pos) and time since starting move ($dt)
# For calculation the timings are used if defined.
sub _MMSOMFY_CalcCurrentPos($$$) {
    # Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_CalcCurrentPos ($FHEM_Hash->{NAME}): Enter");

    # my ($move, $pos, $dt) = @_;

    # my $name = $FHEM_Hash->{NAME};
    # my $newPos = $pos;

    # # If there are no timings position can not be calculated and remain set statically.
    # if ($FHEM_Hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::off)
    # {
    #     Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Position set statically as no timings are defined.");
    # }
    # # ... else if basic timing settings are available ...
    # elsif ($FHEM_Hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::basic)
    # {
    #     Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Basic Timing is defiend. No down position.");

    #     # if movement is close ...
    #     if ($move eq MMSOMFY::Movement::down)
    #     {
    #         # ... movement will be added to last position.
    #         $newPos = $pos + MMSOMFY::Position::dPosForTime(MMSOMFY::Position::RANGE, MMSOMFY::Timing::Opened2Closed, $dt);
    #     }
    #     # ... else if movement is up ...
    #     elsif ($move eq MMSOMFY::Movement::up)
    #     {
    #         # ... movement wil be substracted from last position.
    #         $newPos = $pos - MMSOMFY::Position::dPosForTime(MMSOMFY::Position::RANGE, MMSOMFY::Timing::Closed2Opened, $dt);
    #     }
    #     # ... else use last position and report error.
    #     else
    #     {
    #         Log3($name,1,"_MMSOMFY_CalcCurrentPos ($name): $name wrong move: $move");
    #         $newPos = $pos;
    #     }
    # }
    # # ... else if extended timings are set, split ranges on down barrier.
    # elsif ($FHEM_Hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::extended)
    # {
    #     Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Separate down position. Splitting ranges if necessray.");

    #     # ... get all relevant positions and ranges.
    #     my $posOpened = MMSOMFY::Position::FromState(MMSOMFY::State::opened);
    #     my $posDown = MMSOMFY::Position::FromState(MMSOMFY::State::down);
    #     my $posClosed = MMSOMFY::Position::FromState(MMSOMFY::State::closed);
    #     my $rOpenedDown = MMSOMFY::Position::diffPosition($posOpened, $posDown);
    #     my $rDownClosed = MMSOMFY::Position::diffPosition($posDown, $posClosed);

    #     # if movement is close ...
    #     if ($move eq MMSOMFY::Movement::down)
    #     {
    #         Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Movement is closing.");

    #         # ... if current position is between down and closed ...
    #         if (MMSOMFY::Position::IsPosBetween($pos, MMSOMFY::State::down, MMSOMFY::State::closed))
    #         {
    #             Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Between down and closed. Add movement to position.");

    #             # ... add movement to last position with timing 'Down2Closed' related to range.
    #             $newPos = $pos + MMSOMFY::Position::dPosForTime($rDownClosed, MMSOMFY::Timing::Down2Closed, $dt);
    #         }
    #         # ... else current position is between opened and down ...
    #         else
    #         {
    #             # ... get movement with timing Opened2Down related to range.
    #             my $dPos = MMSOMFY::Position::dPosForTime($rOpenedDown, MMSOMFY::Timing::Opened2Down, $dt);

    #             Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Between opened and down, moving $dPos.");

    #             # If newPos would breach down barrier calculation must be corrected ...
    #             if (MMSOMFY::Position::IsPosBetween($pos + $dPos, MMSOMFY::State::down, MMSOMFY::State::closed))
    #             {
    #                 Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Movement crosses down barrier. Correction needed.");

    #                 # Get traveltime beyond down barrier, ...
    #                 my $moveBeyondDown = $pos + $dPos - $posDown;
    #                 my $tBeyondDown = $dt * $moveBeyondDown / $dPos;

    #                 # ... calculate movement beyond down with timing Down2Closed related to range.
    #                 $dPos = MMSOMFY::Position::dPosForTime($rDownClosed, MMSOMFY::Timing::Down2Closed, $tBeyondDown);

    #                 # ... add movement beyond down to down position for new position.
    #                 $newPos = $posDown + $dPos;
    #             }
    #             # ... not breaking the down barrier calculation is already correct ...
    #             else
    #             {
    #                 Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Movement before down barrier.");

    #                 # ... and new position can be set accordingly.
    #                 $newPos = $pos + $dPos;
    #             }
    #         }
    #     }
    #     elsif ($move eq MMSOMFY::Movement::up)
    #     {
    #         Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Movement is up.");

    #         # ... if current position is between down and opened ...
    #         if (MMSOMFY::Position::IsPosBetween($pos, MMSOMFY::State::down, MMSOMFY::State::opened))
    #         {
    #             Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Between down and opened. Remvove movement from position.");

    #             # ... remove movement to last position with timing 'Down2Opened' related to range.
    #             $newPos = $pos - MMSOMFY::Position::dPosForTime($rOpenedDown, MMSOMFY::Timing::Down2Opened, $dt);
    #         }
    #         # ... else current position is between closed and down ...
    #         else
    #         {
    #             # ... get movement with timing Closed2Down related to range.
    #             my $dPos = MMSOMFY::Position::dPosForTime($rDownClosed, MMSOMFY::Timing::Closed2Down, $dt);

    #             Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Between closed and down, moving $dPos.");

    #             # If newPos would breach down barrier, calculation must be corrected ...
    #             if (MMSOMFY::Position::IsPosBetween($pos - $dPos, MMSOMFY::State::down, MMSOMFY::State::opened))
    #             {
    #                 Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Movement crosses down barrier. Correction needed.");

    #                 # Get traveltime beyond down barrier, ....
    #                 my $moveBeyondDown = $posDown - ($pos - $dPos);
    #                 my $tBeyondDown = $dt * $moveBeyondDown / $dPos;

    #                 # ... calculate movement beyond down with timing 'Down2Opened' related to range.
    #                 $dPos = MMSOMFY::Position::dPosForTime($rOpenedDown, MMSOMFY::Timing::Down2Opened, $tBeyondDown);

    #                 # ... remove movement beyond down from down position for new position.
    #                 $newPos = $posDown - $dPos;
    #             }
    #             # ... not breaking the down barrier calculation is already correct ...
    #             else
    #             {
    #                 Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Movement before down barrier.");

    #                 # ... and new position can be set accordingly.
    #                 $newPos = $pos - $dPos;
    #             }
    #         }
    #     } else {
    #         Log3($name,1,"_MMSOMFY_CalcCurrentPos: $name wrong move $move");
    #     }
    # }

    # # Bring back in range if exeeded.
    # $newPos = MMSOMFY::Position::MaxPos if $newPos > MMSOMFY::Position::MaxPos;
    # $newPos = MMSOMFY::Position::MinPos if $newPos < MMSOMFY::Position::MinPos;

    # Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Updated position: $newPos");

    # Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_CalcCurrentPos ($FHEM_Hash->{NAME}): Exit");
    # return $newPos;
}


######################################################
######################################################
###
### Helper for TIMING
###
######################################################
######################################################



#############################
sub _MMSOMFY_UpdateStartTime() {
    # Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_UpdateStartTime ($FHEM_Hash->{NAME}): Enter");

    # my ($s, $ms) = gettimeofday();

    # my $t = $s + ($ms / 1000000); # 10 msec
    # my $t1 = 0;
    # $t1 = $FHEM_Hash->{starttime} if(exists($FHEM_Hash->{starttime} ));
    # $FHEM_Hash->{starttime}  = $t;
    # my $dt = sprintf("%.2f", $t - $t1);

    # Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_UpdateStartTime ($FHEM_Hash->{NAME}): Exit");
    # return $dt;
} # end sub UpdateStartTime


###################################
sub _MMSOMFY_TimedUpdate($) {
#     Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_TimedUpdate ($FHEM_Hash->{NAME}): Enter");

#     my ($FHEM_Hash) = @_;

#     Log3($FHEM_Hash->{NAME},4,"_MMSOMFY_TimedUpdate");

#     # get current infos
#     my $pos = ReadingsVal($FHEM_Hash->{NAME},'exact',undef);

#   if ( AttrVal( $FHEM_Hash->{NAME}, "positionInverse", 0 ) ) {
#     Log3($FHEM_Hash->{NAME},5,"_MMSOMFY_TimedUpdate : pos before convert so far : $pos");
#     $pos = _MMSOMFY_ConvertFrom100To0( $pos );
#   }
#     Log3($FHEM_Hash->{NAME},5,"_MMSOMFY_TimedUpdate : pos so far : $pos");

#     my $dt = _MMSOMFY_UpdateStartTime();
#   my $nowt = gettimeofday();

#     $pos = _MMSOMFY_CalcCurrentPos($FHEM_Hash->{MOVE}, $pos, $dt);
# #   my $posRounded = RoundInternal( $pos );

#     Log3($FHEM_Hash->{NAME},5,"_MMSOMFY_TimedUpdate : delta time : $dt   new rounde pos (rounded): $pos ");

#     $FHEM_Hash->{runningtime} = $FHEM_Hash->{runningtime} - $dt;
#     if ( $FHEM_Hash->{runningtime} <= 0.1) {
#         if ( defined( $FHEM_Hash->{runningcmd} ) ) {
#             _MMSOMFY_SendCommand($FHEM_Hash, $FHEM_Hash->{runningcmd});
#         }
#         # trigger update from timer
#         MMSOMFY::Reading::Update($FHEM_Hash->{updateState}, 'stop');
#         delete $FHEM_Hash->{updatestate};
#         delete $FHEM_Hash->{starttime};
#         delete $FHEM_Hash->{runningtime};
#         delete $FHEM_Hash->{runningcmd};
#     } else {
#         my $utime = $FHEM_Hash->{runningtime} ;
#         if($utime > $somfy_updateFreq) {
#             $utime = $somfy_updateFreq;
#         }
#         MMSOMFY::Reading::Update($pos, $FHEM_Hash->{MOVE});
#         if ( defined( $FHEM_Hash->{runningcmd} )) {
#             Log3($FHEM_Hash->{NAME},4,"_MMSOMFY_TimedUpdate: $FHEM_Hash->{NAME} -> stopping in $FHEM_Hash->{runningtime} sec");
#         } else {
#             Log3($FHEM_Hash->{NAME},4,"_MMSOMFY_TimedUpdate: $FHEM_Hash->{NAME} -> update state in $FHEM_Hash->{runningtime} sec");
#         }
#         my $nstt = maxNum($nowt+$utime-0.01, gettimeofday()+.1 );
#         Log3($FHEM_Hash->{NAME},5,"_MMSOMFY_TimedUpdate: $FHEM_Hash->{NAME} -> next time to stop: $nstt");
#         InternalTimer($nstt,"_MMSOMFY_TimedUpdate",$FHEM_Hash,0);
#     }

#     Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_TimedUpdate ($FHEM_Hash->{NAME}): Exit");
} # end sub TimedUpdate

######################################################
######################################################
######################################################

1;


=pod
=item summary    supporting devices using the SOMFY RTS protocol - window shades
=item summary_DE für Geräte, die das SOMFY RTS protocol unterstützen - Rolläden
=begin html

<a name="MMSOMFY"></a>
<h3>MMSOMFY - Somfy RTS / Simu Hz protocol</h3>
<ul>
  The Somfy RTS (identical to Simu Hz) protocol is used by a wide range of devices,
  which are either senders or receivers/actuators.
  Right now only SENDING of Somfy commands is implemented in the CULFW, so this module currently only
  supports devices like awning, dimmers, etc. through a <a href="#CUL">CUL</a> device (which must be defined first).
  Reception of Somfy remotes is only supported indirectly through the usage of an FHEMduino
  <a href="http://www.fhemwiki.de/wiki/FHEMduino">http://www.fhemwiki.de/wiki/FHEMduino</a>
  which can then be used to connect to the MMSOMFY device.

  <br><br>

  <a name="MMSOMFYdefine"></a>
  <b>Define</b>
  <ul>
    <code>define &lt;name&gt; MMSOMFY &lt;address&gt; [&lt;encryption-key&gt;] [&lt;rolling-code&gt;] </code>
    <br><br>

   The address is a 6-digit hex code, that uniquely identifies a single remote control channel.
   It is used to pair the remote to the awning or dimmer it should control.
   <br>
   Pairing is done by setting the awning in programming mode, either by disconnecting/reconnecting the power,
   or by pressing the program button on an already associated remote.
   <br>
   Once the awning is in programming mode, send the "prog" command from within FHEM to complete the pairing.
   The awning will move up and down shortly to indicate completion.
   <br>
   You are now able to control this awning from FHEM, the receiver thinks it is just another remote control.

   <ul>
   <li><code>&lt;address&gt;</code> is a 6 digit hex number that uniquely identifies FHEM as a new remote control channel.
   <br>You should use a different one for each device definition, and group them using a structure.
   </li>
   <li>The optional <code>&lt;encryption-key&gt;</code> is a 2 digit hex number (first letter should always be A)
   that can be set to clone an existing remote control channel.</li>
   <li>The optional <code>&lt;rolling-code&gt;</code> is a 4 digit hex number that can be set
   to clone an existing remote control channel.<br>
   If you set one of them, you need to pick the same address as an existing remote.
   Be aware that the receiver might not accept commands from the remote any longer,<br>
   if you used FHEM to clone an existing remote.
   <br>
   This is because the code is original remote's codes are out of sync.</li>
   <br>
   Rolling code and encryption key in the device definition will be always updated on commands sent and can be also changed manually by modifying the original definition (e.g in FHEMWeb - modify).
   </ul>
   <br>

    Examples:
    <ul>
      <code>define rollo_1 MMSOMFY 000001</code><br>
      <code>define rollo_2 MMSOMFY 000002</code><br>
      <code>define rollo_3_original MMSOMFY 42ABCD A5 0A1C</code><br>
    </ul>
  </ul>
  <br>

  <a name="MMSOMFYset"></a>
  <b>Set </b>
  <ul>
    <code>set &lt;name&gt; &lt;value&gt; [&lt;time&gt]</code>
    <br><br>
    where <code>value</code> is one of:<br>
    <pre>
    close
    open
    go-my
    stop
    position value (0..100) # see note
    prog  # Special, see note
    wind_sun_9
    wind_only_a
    close_for_timer
    open_for_timer
    manual 0,...,100,200,close,open
    </pre>
    Examples:
    <ul>
      <code>set rollo_1 close</code><br>
      <code>set rollo_1,rollo_2,rollo_3 on</code><br>
      <code>set rollo_1-rollo_3 on</code><br>
      <code>set rollo_1 open</code><br>
      <code>set rollo_1 position 50</code><br>
    </ul>
    <br>
    Notes:
    <ul>
      <li>prog is a special command used to pair the receiver to FHEM:
      Set the receiver in programming mode (eg. by pressing the program-button on the original remote)
      and send the "prog" command from FHEM to finish pairing.<br>
      The awning will move up and down shortly to indicate success.
      </li>
      <li>close_for_timer and open_for_timer send a stop command after the specified time,
      instead of reversing the awning.<br>
      This can be used to go to a specific position by measuring the time it takes to close the awning completely.
      </li>
      <li>position value<br>

            The position is variying between 0 completely open and 100 for covering the full window.
            The position must be between 0 and 100 and the appropriate
            attributes driveTimeOpenedToDown, driveTimOpenedToClose,
            driveTimeClosedToDown and driveTimeClosedToOpened must be set. See also positionInverse attribute.<br>
            </li>
      <li>wind_sun_9 and wind_only_a send special commands to the Somfy device that to represent the codes sent from wind and sun detector (with the respective code contained in the set command name)
      </li>
      <li>manual will only set the position without sending any commands to the somfy device - can be used to correct the position manually
      </li>
    </ul>

        The position reading distinuishes between multiple cases
    <ul>
      <li>Without timing values (see attributes) set only generic values are used for status and position: <pre>open, closed, moving</pre> are used
      </li>
            <li>With timing values set but driveTimeOpenedToClose equal to driveTimeOpenedToDown and driveTimeClosedToDown equal 0
            the device is considered to only vary between 0 and 100 (100 being completely closed)
      </li>
            <li>With full timing values set the device is considerd a window shutter (Rolladen) with a difference between
            covering the full window (position 100) and being completely closed (position 200)
      </li>
        </ul>

  </ul>
  <br>

  <b>Get</b> <ul>N/A</ul><br>

  <a name="MMSOMFYattr"></a>
  <b>Attributes</b>
  <ul>
    <li>IODev<br>
        Set the IO or physical device which should be used for sending signals
        for this "logical" device. An example for the physical device is a CUL.<br>
        Note: The IODev has to be set, otherwise no commands will be sent!<br>
        If you have both a CUL868 and CUL433, use the CUL433 as IODev for increased range.
        </li><br>

    <li>positionInverse<br>
        Inverse operation for positions instead of 0 to 100-200 the positions are ranging from 100 to 10 (down) and then to 0 (closed).
        The position set command will point in this case to the reversed position values.
        This does NOT reverse the operation of the on/open command, meaning that on always will move the shade down and open will move it up towards the initial position.
        </li><br>

    <li>additionalPosReading<br>
        Position of the shutter will be stored in the reading <code>pos</code> as numeric value.
        Additionally this attribute might specify a name for an additional reading to be updated with the same value than the pos.
        </li><br>

    <li>fixedEnckey 1|0<br>
        If set to 1 the enc-key is not changed after a command sent to the device. Default is value 0 meaning enc-key is changed normally for the RTS protocol.
        </li><br>

    <li>eventMap<br>
        Replace event names and set arguments. The value of this attribute
        consists of a list of space separated values, each value is a colon
        separated pair. The first part specifies the "old" value, the second
        the new/desired value. If the first character is slash(/) or comma(,)
        then split not by space but by this character, enabling to embed spaces.
        Examples:<ul><code>
        attr store eventMap on:open off:closed<br>
        attr store eventMap /on_for_timer 10:open/off:closed/<br>
        set store open
        </code></ul>
        </li><br>

    <li><a href="#loglevel">loglevel</a></li><br>

    <li><a href="#showtime">showtime</a></li><br>

    <li>model<br>
        The model attribute denotes the model type of the device.
        The attributes will (currently) not be used by the fhem.pl directly.
        It can be used by e.g. external programs or web interfaces to
        distinguish classes of devices and send the appropriate commands
        (e.g. "on" or "off" to a switch, "dim..%" to dimmers etc.).<br>
        The spelling of the model names are as quoted on the printed
        documentation which comes which each device. This name is used
        without blanks in all lower-case letters. Valid characters should be
        <code>a-z 0-9</code> and <code>-</code> (dash),
        other characters should be ommited.<br>
        Here is a list of "official" devices:<br>
          <b>Receiver/Actor</b>: somfyawning<br>
    </li><br>


    <li>ignore<br>
        Ignore this device, e.g. if it belongs to your neighbour. The device
        won't trigger any FileLogs/notifys, issued commands will silently
        ignored (no RF signal will be sent out, just like for the <a
        href="#attrdummy">dummy</a> attribute). The device won't appear in the
        list command (only if it is explicitely asked for it), nor will it
        appear in commands which use some wildcard/attribute as name specifiers
        (see <a href="#devspec">devspec</a>). You still get them with the
        "ignored=1" special devspec.
        </li><br>

    <li>driveTimOpenedToDown<br>
        The time the awning needs to drive down from "open" (pos 0) to pos 100.<br>
        In this position, the lower edge touches the window frame, but it is not completely shut.<br>
        For a mid-size window this time is about 12 to 15 seconds.
        </li><br>

    <li>driveTimOpenedToClose<br>
        The time the awning needs to drive down from "open" (pos 0) to "close", the end position of the awning.<br>
        Note: If set, this value always needs to be higher than driveTimeOpenedToDown
        This is about 3 to 5 seonds more than the "driveTimeOPenedToDown" value.
        </li><br>

    <li>driveTimeClosedToDown<br>
        The time the awning needs to drive up from "closed" (endposition) to "down".<br>
        This usually takes about 3 to 5 seconds.
        </li><br>

    <li>driveTimeClosedToOpened<br>
        The time the awning needs drive up from "closed" (endposition) to "opened" (upper endposition).<br>
        Note: If set, this value always needs to be higher than driveTimeOpenedToDown
        This value is usually a bit higher than "driveTimeOPenedToClose", due to the awning's weight.
        </li><br>

  </ul>
</ul>



=end html
=cut
