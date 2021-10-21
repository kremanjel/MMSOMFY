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

# Enumeration implementation for MMSOMFY::Definition
package MMSOMFY::Definition;

    use strict;
    use warnings;

    # enumeration items
    use constant {
        MODEL => "MODEL",
        TIMIMNG => "TIMING",
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

1;

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
        moving => "moving",
        mypos => "mypos",
        opened => "opened",
        off => "off",
        down => "down",
        closed => "closed",
        on => "on",
        position => "position",
        receiving => "receiving",
        inactive => "inactive",
        ignored => "ignored",
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

# Enumeration implementation for MMSOMFY::Attribute providing
# all attributes of the module to FHEM.
package MMSOMFY::Attribute;

    use strict;
    use warnings;
    use Switch;
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
    };

    # Get string with all items and values of enumeratione separated by given character.
    # If separation charcter is not set space will be used.
    # item and value are separated by ":"
    sub AddSpecificAttributes {

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
                    ($name eq MMSOMFY::Attribute::ignore) ||

                    # ... or attribute belongs to set model ...
                    (
                        # ... remotes ...
                        ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::remote) &&
                        (
                            ($name eq MMSOMFY::Attribute::rawDevice)
                        )
                    ) || (
                        # ... switches ...
                        ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::switch) &&
                        (
                            ($name eq MMSOMFY::Attribute::symbolLength) ||
                            ($name eq MMSOMFY::Attribute::repetition) ||
                            ($name eq MMSOMFY::Attribute::fixedEnckey)
                        )
                    ) || (
                        # ... awnings and shutters ...
                        (
                            ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::awning) ||
                            ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::shutter)
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
                main::addToDevAttrList($main::FHEM_Hash->{NAME}, $name . $values{$name});
            }
        }
    }

    # Checks that changing attribute values results in valid states.
    sub CheckAttribute($$$$) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Attribute ($main::FHEM_Hash->{NAME}): Enter 'CheckAttribute'");
        
        my ($cmd, $attrName, $attrValue, $init_done) = @_;
        my $name = $main::FHEM_Hash->{NAME};
        my $retval = undef;

        # if attribute is part of attribut package ...
        if (MMSOMFY::Attribute->can($attrName))
        {
            # ... then continue depending on attribute name ...
            switch ($attrName)
            {
                case MMSOMFY::Attribute::userattr
                {
                    if ($init_done)
                    {
                        # ... user attributes shall not be modified by user therefore error is returned.
                        $retval = "MMSOMFY::Attribute::CheckAttribute ($main::FHEM_Hash->{NAME}): Error - Attribute $attrName cannot be modfied.";
                    }
                }
                case MMSOMFY::Attribute::driveTimeOpenedToDown
                {
                    # ... if attribute shall be set ...
                    if ($cmd eq "set")
                    {
                        # ... if model is a shutter, attribute is supported ...
                        if ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::shutter)
                        {
                            # ... check validity of value to be set ...
                            $retval = MMSOMFY::Timing::CheckTiming($attrName, $_[2], MMSOMFY::Attribute::driveTimeOpenedToClosed, $main::attr{$name}{MMSOMFY::Attribute::driveTimeOpenedToClosed}, "smaller");
                        }
                        # ... otherwise attribute is not supported ...
                        else
                        {
                            # ... error is returned.
                            $retval = "MMSOMFY::Attribute::CheckAttribute ($main::FHEM_Hash->{NAME}): Error - Attribute $attrName is supported for " . MMSOMFY::Definition::MODEL . " " . MMSOMFY::Model::shutter . " only.";
                        }
                    }

                    # ... update Timing Setting if there is no error.
                    MMSOMFY::Timing::Update($attrName, $attrValue) unless (defined($retval));
                }
                case MMSOMFY::Attribute::driveTimeOpenedToClosed
                {
                    # ... if attribute shall be set ...
                    if ($cmd eq "set")
                    {
                        # ... if model is a shutter or awning, attribute is supported ...
                        if
                            (
                                ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::shutter) ||
                                ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::awning)
                            )
                        {
                            # ... check validity of value to be set ...
                            $retval = MMSOMFY::Timing::CheckTiming($attrName, $_[2], MMSOMFY::Attribute::driveTimeOpenedToDown, $main::attr{$name}{MMSOMFY::Attribute::driveTimeOpenedToDown}, "greater");
                        }
                        # ... otherwise attribute is not supported ...
                        else
                        {
                            # ... error is returned.
                            $retval = "MMSOMFY::Attribute::CheckAttribute ($main::FHEM_Hash->{NAME}): Error - Attribute $attrName is supported for " . MMSOMFY::Definition::MODEL . " " . MMSOMFY::Model::shutter . " and " . MMSOMFY::Model::awning . " only.";
                        }
                    }

                    # ... update Timing Setting if there is no error.
                    MMSOMFY::Timing::Update($attrName, $attrValue) unless (defined($retval));
                }
                case MMSOMFY::Attribute::driveTimeClosedToDown
                {
                    # ... if attribute shall be set ...
                    if ($cmd eq "set")
                    {
                        # ... if model is a shutter, attribute is supported ...
                        if ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::shutter)
                        {
                            # ... check validity of value to be set ...
                            $retval = MMSOMFY::Timing::CheckTiming($attrName, $_[2], MMSOMFY::Attribute::driveTimeClosedToOpened, $main::attr{$name}{MMSOMFY::Attribute::driveTimeClosedToOpened}, "smaller");
                        }
                        # ... otherwise attribute is not supported ...
                        else
                        {
                            # ... error is returned.
                            $retval = "MMSOMFY::Attribute::CheckAttribute ($main::FHEM_Hash->{NAME}): Error - Attribute $attrName is supported for " . MMSOMFY::Definition::MODEL . " " . MMSOMFY::Model::shutter . " only.";
                        }
                    }

                    # ... update Timing Setting if there is no error.
                    MMSOMFY::Timing::Update($attrName, $attrValue) unless (defined($retval));
                }
                case MMSOMFY::Attribute::driveTimeClosedToOpened
                {
                    # ... if attribute shall be set ...
                    if ($cmd eq "set")
                    {
                        # ... if model is a shutter or awning, attribute is supported ...
                        if
                            (
                                ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::shutter) ||
                                ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::awning)
                            )
                        {
                            # ... check validity of value to be set ...
                            $retval = MMSOMFY::Timing::CheckTiming($attrName, $_[2], MMSOMFY::Attribute::driveTimeClosedToDown, $main::attr{$name}{MMSOMFY::Attribute::driveTimeClosedToDown}, "greater");
                        }
                        # ... otherwise attribute is not supported ...
                        else
                        {
                            # ... error is returned.
                            $retval = "MMSOMFY::Attribute::CheckAttribute ($main::FHEM_Hash->{NAME}): Error - Attribute $attrName is supported for " . MMSOMFY::Definition::MODEL . " " . MMSOMFY::Model::shutter . " and " . MMSOMFY::Model::awning . " only.";
                        }
                    }

                    # ... update Timing Setting if there is no error.
                    MMSOMFY::Timing::Update($attrName, $attrValue) unless (defined($retval));
                }
                case MMSOMFY::Attribute::myPosition
                {
                    # ... if attribute shall be set ...
                    if ($cmd eq "set")
                    {
                        # ... if model is a shutter or awning, attribute is supported ...
                        if
                            (
                                ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::shutter) ||
                                ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::awning)
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
                            $retval = "MMSOMFY::Attribute::CheckAttribute ($main::FHEM_Hash->{NAME}): Error - Attribute $attrName is supported for " . MMSOMFY::Definition::MODEL . " " . MMSOMFY::Model::shutter . " and " . MMSOMFY::Model::awning . " only.";
                        }
                    }
                }
                case MMSOMFY::Attribute::additionalPosReading
                {
                    # ... if attribute shall be set ...
                    if ($cmd eq "set")
                    {
                        # ... if model is a shutter or awning, attribute is supported ...
                        if
                            (
                                ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::shutter) ||
                                ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::awning)
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
                            $retval = "MMSOMFY::Attribute::CheckAttribute ($main::FHEM_Hash->{NAME}): Error - Attribute $attrName is supported for " . MMSOMFY::Definition::MODEL . " " . MMSOMFY::Model::shutter . " and " . MMSOMFY::Model::awning . " only.";
                        }
                    }
                }
            }
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Attribute ($main::FHEM_Hash->{NAME}): Exit 'CheckAttribute'");
        
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
    sub CheckTiming($$$$$) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Enter 'CheckTiming'");
        my ($attrName, $attrValue, $refernceName, $referenceValue, $operator) = @_;
        my $retval = undef;
        
        # Check if valid operator is used ...
        if ($operator !~ /^(smaller|greater)$/)
        {
            # ... if not return error ...
            $retval = "MMSOMFY::Timing::CheckTiming ($main::FHEM_Hash->{NAME}): Operator '$operator' is unknown.";
        }
        # ... if operator is ok ...
        else
        {
            # ... check if value is numeric ...
            if (looks_like_number($attrValue))
            {
                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::Timing::CheckTiming ($main::FHEM_Hash->{NAME}): Set timing value ($attrValue) to format %.1f");

                # ... format value to float with one decimal place and change the reference of attribute value ...
                $attrValue = sprintf "%.1f", $attrValue;
                $_[1] = $attrValue;
        
                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::Timing::CheckTiming ($main::FHEM_Hash->{NAME}): Corrected timing value ($attrValue)");

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
                            $retval = "MMSOMFY::Timing::CheckTiming ($main::FHEM_Hash->{NAME}): Value $attrName ($attrValue) must be smaller than $refernceName ($referenceValue)";
                        }
                    }
                    # ... perform check with operator greater ...
                    elsif ($operator eq "greater")
                    {
                        # ... if reference value is defined it must be smaller ...
                        if (defined($referenceValue) && $referenceValue >= $attrValue)
                        {
                            # ... otherwise it is an error.
                            $retval = "MMSOMFY::Timing::CheckTiming ($main::FHEM_Hash->{NAME}): Value $attrName ($attrValue) must be greater than $refernceName ($referenceValue)";
                        }
                    }
                }
                # ... otherwise value is <= 0 ...
                else
                {
                    # ... then return error as all timings shall always be greater 0.
                    $retval = "MMSOMFY::Timing::CheckTiming ($main::FHEM_Hash->{NAME}): Value for $attrName must be greater 0.";
                }
            }
            # ... if value is not numeric ...
            else
            {
                # ... then return error as timing values must be numeric.
                $retval = "MMSOMFY::Timing::CheckTiming ($main::FHEM_Hash->{NAME}): Value for $attrName ($attrValue) is not numeric.";
            }
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Exit 'CheckTiming'");
        return $retval;
    }

    # Update timing according to set attributes.
    sub Update($$) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Enter 'Update'");
        
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
        
            # if basic timing values are defined ...
            if (defined($tempTimings{MMSOMFY::Attribute::driveTimeClosedToOpened}) && defined($tempTimings{MMSOMFY::Attribute::driveTimeOpenedToClosed}))
            {
                # ... check if extended timing values are defined ...
                if (defined($tempTimings{MMSOMFY::Attribute::driveTimeClosedToDown}) && defined($tempTimings{MMSOMFY::Attribute::driveTimeOpenedToDown}))
                {
                    # ... then set TIMING to extended.
                    $main::FHEM_Hash->{TIMING} = MMSOMFY::Timing::extended
                }
                else
                {
                    # ... otherwise TIMING is basic.
                    $main::FHEM_Hash->{TIMING} = MMSOMFY::Timing::basic
                }
            }
            # ... otherwise ...
            else
            {
                # ... TIMING is off as the values can not be used.
                $main::FHEM_Hash->{TIMING} = MMSOMFY::Timing::off
            }
            
        }
        
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Exit 'Update'");
    }

    # Get time from opened position to closed position.
    # If timing is not at least basic undef is returned.
    sub Opened2Closed {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Enter 'Opened2Closed'");

        my $retval = undef;
        
        if ($main::FHEM_Hash->{TIMING} ne MMSOMFY::Timing::off)
        {
            $retval = $main::attr{$main::FHEM_Hash->{NAME}}{MMSOMFY::Attribute::driveTimeOpenedToClosed};
        }
        
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Exit 'Opened2Closed'");
        return $retval;
    }

    # Get time from opened position to down position.
    # If timing is not extended undef is returned.
    sub Opened2Down {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Enter 'Opened2Down'");

        my $retval = undef;
        
        if ($main::FHEM_Hash->{TIMING} eq MMSOMFY::Timing::extended)
        {
            $retval = $main::attr{$main::FHEM_Hash->{NAME}}{MMSOMFY::Attribute::driveTimeOpenedToDown};
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Exit 'Opened2Down'");

        return $retval;
    }

    # Get time from down position to closed position.
    # If timing is not extended undef is returned.
    sub Down2Closed {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Enter 'Down2Closed'");
    
        my $retval = undef;
        
        if ($main::FHEM_Hash->{TIMING} eq MMSOMFY::Timing::extended)
        {
            $retval = $main::attr{$main::FHEM_Hash->{NAME}}{MMSOMFY::Attribute::driveTimeOpenedToClosed} - $main::attr{$main::FHEM_Hash->{NAME}}{MMSOMFY::Attribute::driveTimeOpenedToDown};
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Exit 'Down2Closed'");

        return $retval;
    }

    # Get time from closed position to opened position.
    # If timing is not at least basic undef is returned.
    sub Closed2Opened {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Enter 'Closed2Opened'");

        my $retval = undef;
        
        if ($main::FHEM_Hash->{TIMING} ne MMSOMFY::Timing::off)
        {
            $retval = $main::attr{$main::FHEM_Hash->{NAME}}{MMSOMFY::Attribute::driveTimeClosedToOpened};
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Exit 'Closed2Opened'");

        return $retval;
    }

    # Get time from closed position to down position.
    # If timing is not extended undef is returned.
    sub Closed2Down {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Enter 'Closed2Down'");

        my $retval = undef;
        
        if ($main::FHEM_Hash->{TIMING} eq MMSOMFY::Timing::extended)
        {
            $retval = $main::attr{$main::FHEM_Hash->{NAME}}{MMSOMFY::Attribute::driveTimeClosedToDown};
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Exit 'Closed2Down'");

        return $retval;
    }

    # Get time from down position to closed position.
    # If timing is not extended undef is returned.
    sub Down2Opened {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Enter 'Down2OPened'");

        my $retval = undef;
        
        if ($main::FHEM_Hash->{TIMING} eq MMSOMFY::Timing::extended)
        {
            $retval = $main::attr{$main::FHEM_Hash->{NAME}}{MMSOMFY::Attribute::driveTimeClosedToOpened} - $main::attr{$main::FHEM_Hash->{NAME}}{MMSOMFY::Attribute::driveTimeClosedToDown};
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Timing ($main::FHEM_Hash->{NAME}): Exit 'Down2Opened'");

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
        exact => "exact",
        position => "position",
        state => "state",
        movement => "movement",
        enc_key => "enc_key",
        rolling_code => "rolling_code",
        received => "received",
        parsestate => "parsestate",
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

    # Update Readings according given position value and moving.
    sub Update($$) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Reading ($main::FHEM_Hash->{NAME}): Enter 'Update'");

        (my $newExact, my $move) = @_;
        my $name = $main::FHEM_Hash->{NAME};

        my $newPosition = MMSOMFY::Position::RoundValue2Step($newExact);
        my $newState = MMSOMFY::Position::ToState($newExact, $move);

        main::Log3($name, 5, "MMSOMFY::Reading ($main::FHEM_Hash->{NAME}): Update readings for $name, exact:$newExact, position:$newPosition,  state:$newState.");

        main::readingsBeginUpdate($main::FHEM_Hash);

        main::readingsBulkUpdate($main::FHEM_Hash, MMSOMFY::Reading::exact, $newExact);
        main::readingsBulkUpdate($main::FHEM_Hash, MMSOMFY::Reading::position, $newPosition);
        main::readingsBulkUpdate($main::FHEM_Hash, MMSOMFY::Reading::state, $newState);

        my $addtlPosReading = main::AttrVal($name, MMSOMFY::Attribute::additionalPosReading, undef);
        if (defined($addtlPosReading))
        {
            main::Log3($name, 5, "MMSOMFY::Reading ($main::FHEM_Hash->{NAME}): Update additionalPosReading for $name, $addtlPosReading:$newPosition.");
            main::readingsBulkUpdate($main::FHEM_Hash, $addtlPosReading, $newPosition);
        }

        main::readingsEndUpdate($main::FHEM_Hash, 1);

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Reading ($main::FHEM_Hash->{NAME}): Exit 'Update'");
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

    # Mapping from state to position without inversion.
    my %state2position = (
        MMSOMFY::State::opened => min(ENDPOS,STARTPOS),
        MMSOMFY::State::down => max(ENDPOS,STARTPOS)-STEPWIDTH,
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
    sub Current {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Enter 'Current'");

        my $name = $main::FHEM_Hash->{NAME};
        my $retval = undef;

        # First try exact value
        $retval = main::ReadingsVal($name, MMSOMFY::Reading::exact, undef);
        main::Log3($name, 5, "MMSOMFY::Position::Current: " .  $name . " got " . MMSOMFY::Reading::exact . " value: " . $retval) if (defined($retval));

        # if not available try position value
        unless(defined($retval))
        {
            $retval = main::ReadingsVal($name, MMSOMFY::Reading::position, undef);
            main::Log3($name, 5, "MMSOMFY::Position::Current: " .  $name . " got " . MMSOMFY::Reading::position . " value: " . $retval) if (defined($retval));
        }

        # get state to determine the position
        my $state = main::ReadingsVal($name, MMSOMFY::Reading::state, undef);

        # if also not available get position from current state
        unless (defined($retval))
        {
            if (defined($state))
            {
                $retval = FromState($state);
                main::Log3($name, 5, "MMSOMFY::Position::Current: " .  $name . " got position value: " . $retval . " from state " . $state) if (defined($retval));
            }
        }

        # if state gives no position it may be already a position
        unless (defined($retval))
        {
            $retval = $state if looks_like_number($state);
            $retval = sprintf( "%d", $retval ) if (defined($retval));
            main::Log3($name, 5, "MMSOMFY::Position::Current: " .  $name . " got position value: " . $retval . " from state " . $state) if (defined($retval));
        }

        # if position is still not clear it is not known and will be set to minimum depending on positionInverse
        unless (defined($retval))
        {
            my $positionInverse = main::AttrVal($name, MMSOMFY::Attribute::positionInverse, 0);
            $retval = (STARTPOS - (ENDPOS+STARTPOS) * $positionInverse) * (1 - 2 * $positionInverse);
            main::Log3($name, 5, "MMSOMFY::Position::Current: " .  $name . " got default position value: " . $retval);
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Exit 'Current'");
        return $retval;
    }

    # Get position value for given state depending on positionInverse
    sub FromState($) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Enter 'FromState'");

        my ($state) = @_;
        my $retval = undef;

        my $positionInverse = main::AttrVal($main::FHEM_Hash->{NAME}, MMSOMFY::Attribute::positionInverse, 0);
        if (exists($state2position{$state}))
        {
            $retval = ($state2position{$state}-(ENDPOS+STARTPOS)*$positionInverse)*(1-2*$positionInverse);
        }
        elsif ($state eq MMSOMFY::State::position)
        {
            $retval = Current();
        }
        elsif ($state eq MMSOMFY::State::mypos)
        {
            # JM: Todo
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Exit 'FromState'");
        return $retval;
    }

    # Get state from position and movement value depending on positionInverse.
    sub ToState($$) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Enter 'ToState'");

        my ($pos, $move) = @_;
        my $retval = undef;

        # First round the value according to stepwidth, for getting better match with states.
        $pos = RoundValue2Step($pos);

        # Invert position back if invertion is on, as assumption is that given pos value is already inverted.
        my $positionInverse = main::AttrVal($main::FHEM_Hash->{NAME}, MMSOMFY::Attribute::positionInverse, 0);
        $pos = ($pos-(ENDPOS+STARTPOS)*$positionInverse)*(1-2*$positionInverse);

        # If position value matches a state ...
        if (exists($position2state{$pos}))
        {
            # ... we have already found our state.
            $retval = $position2state{$pos};
        }
        # ... otherwise check if movement is ongoing to state opened ...
        elsif ($move eq MMSOMFY::Movement::up)
        {
            # ... then the state is opening.
            $retval = MMSOMFY::State::moving;
        }
        # ... otherwise check if movement is ongoing to state closed ...
        elsif ($move eq MMSOMFY::Movement::down)
        {
            # ... then the state is closing. 
            $retval = MMSOMFY::State::moving;
        }
        else
        {
            # ... otherwise it is no special state, just the current one.
            $retval = MMSOMFY::State::position;
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Exit 'ToState'");
        return $retval;
    }

    # Get position change calculated from range, time needed to move the range and the past time.
    # According to positionInverse the result is positive or negative.
    sub dPosForTime($$$) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Enter 'dPosForTime'");

        my ($rfull, $tfull, $dt) = @_;
        my $retval = $rfull * $dt / $tfull;

        my $positionInverse = main::AttrVal($main::FHEM_Hash->{NAME}, MMSOMFY::Attribute::positionInverse, 0);
        $retval = $retval * (1 - 2 * $positionInverse);

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Exit 'dPosForTime'");
        return $retval;
    }

    # Get absolute difference between two positions.
    sub diffPosition($$) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Enter 'diffPosition'");

        my ($pos1, $pos2) = @_;
        my $retval = undef;

        # If every input is correct ...
        if (defined($pos1) && looks_like_number($pos1) && defined($pos2) && looks_like_number($pos2))
        {
            $retval = abs($pos2 - $pos1);
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Exit 'diffPosition'");
        return $retval;
    }

    # Returns minimal position value.
    sub MinPos {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Enter 'MinPos'");

        my $retval = min(ENDPOS,STARTPOS);

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Exit 'MinPos'");
        return $retval;
    }

    # Returns maximum position value.
    sub MaxPos {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Enter 'MaxPos'");

        my $retval = max(ENDPOS,STARTPOS);

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Exit 'MaxPos'");
        return $retval;
    }

    # Returns 1 if given position is between both given state positions or equal one of the states, 0 else
    sub IsPosBetween($$$) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Enter 'IsPosBetween'");

        my ($pos, $state1, $state2) = @_;
        my $retval = 0;

        my $state1pos = FromState($state1);
        my $state2pos = FromState($state2);

        if (defined($pos) && defined($state1pos) && defined($state2pos) && looks_like_number($pos))
        {
            if ($state1pos <= $state2pos)
            {
                $retval = 1 if ($pos >= $state1pos && $pos <= $state2pos);
            }
            else
            {
                $retval = 1 if ($pos >= $state2pos && $pos <= $state1pos);
            }
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Exit 'IsPosBetween'");
        return $retval;
    }

    # Returns value rounded to next step.
    sub RoundValue2Step($) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Enter 'RoundValue2Step'");

        my ($v) = @_;
        my $retval = sprintf("%d", ($v + (STEPWIDTH/2)) / STEPWIDTH) * STEPWIDTH;
        $retval = MaxPos if $retval > MaxPos;
        $retval = MinPos if $retval < MinPos;
        
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Exit 'RoundValue2Step'");
        return $retval;
    }

    # Returns MMSOMFY::Movement which is necessary to reach given target position.
    sub GetDirectionToTargetPosition($) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Enter 'GetDirectionToTargetPosition'");

        # Get target position ...
        my ($targetPosition) = @_;

        # ... preset result to no move ....
        my $retval = MMSOMFY::Movement::none;

        # ... if target position is not the current one ...
        unless ($targetPosition eq RoundValue2Step(MMSOMFY::State::position))
        {
            # ... if target position is between state opened and the current position ...
            if (MMSOMFY::Position::IsPosBetween($targetPosition, MMSOMFY::State::opened, MMSOMFY::State::position))
            {
                # ... movement must be direction up ...
                $retval = MMSOMFY::Movement::up;
            }
            # ... else the triggered position is between state closed and the current position ...
            else
            {
                # ... movement must be direction down ...
                $retval = MMSOMFY::Movement::down;
            }
        }

        # ... log result in debug level ...
        main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::Position::GetDirectionToTargetPosition ($main::FHEM_Hash->{NAME}): Direction to position $targetPosition is " . $retval . ".");

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Position ($main::FHEM_Hash->{NAME}): Exit 'GetDirectionToTargetPosition'");

        return $retval;
    }

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
        on_for_timer => "on_for_timer",
        off_for_timer => "off_for_timer",
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
            "10" => "my",          # stop or go my
            "20" => "up",          # go up
            "40" => "down",        # go down
            "80" => "prog",        # pairing or unpairing
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
            "20" => "on",          # go up
            "40" => "off",         # go down
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
        "on_for_timer" => "40",    # down
        "off_for_timer" => "20",   # up
        "z_custom" => "XX",        # user defined
        "go_my" => "10",           # go_my
        "wind_sun_9" => "90",      # wind_sun_9
        "wind_only_a" => "A0",     # wind_only_a
    );

    # Default Somfy frame symbol width
    my $somfy_defsymbolwidth = 1240;

    # Default Somfy frame repeat counter
    my $somfy_defrepetition = 6;    

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
            close_for_timer => ":textField",
            open_for_timer => ":textField",
            on_for_timer => ":textField",
            off_for_timer => ":textField",
            z_custom => ":textField",
            go_my => ":noArg",
            position => ":" . MMSOMFY::Position::ToString(','),
            manual => ":" . ((defined($main::FHEM_Hash->{TIMING}) and $main::FHEM_Hash->{TIMING} ne MMSOMFY::Timing::off) ? MMSOMFY::Position::ToString(',') ."," : "") . "open,close",
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
                        # ... for remotes there are also no commands ...
                        ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} ne MMSOMFY::Model::remote) &&
                        (
                            (
                                # ... for switches following commands are available ...
                                ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::switch) &&
                                (
                                    ($name eq MMSOMFY::Command::on) ||
                                    ($name eq MMSOMFY::Command::off) ||
                                    ($name eq MMSOMFY::Command::prog) ||
                                    ($name eq MMSOMFY::Command::on_for_timer) ||
                                    ($name eq MMSOMFY::Command::off_for_timer) ||
                                    ($name eq MMSOMFY::Command::z_custom)
                                )
                            ) || (
                                # ... for awning and shutter following commands are available ...
                                (
                                    ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::awning) ||
                                    ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} eq MMSOMFY::Model::shutter)
                                ) && (
                                    ($name eq MMSOMFY::Command::open) ||
                                    ($name eq MMSOMFY::Command::close) ||
                                    ($name eq MMSOMFY::Command::stop) ||
                                    ($name eq MMSOMFY::Command::prog) ||
                                    ($name eq MMSOMFY::Command::z_custom) ||
                                    ($name eq MMSOMFY::Command::manual) ||
                                    ($name eq MMSOMFY::Command::wind_sun_9) ||
                                    ($name eq MMSOMFY::Command::wind_only_a) ||
                                    (
                                        (
                                            ($name eq MMSOMFY::Command::position) ||
                                            ($name eq MMSOMFY::Command::close_for_timer) ||
                                            ($name eq MMSOMFY::Command::open_for_timer)
                                        ) && (
                                            exists($main::FHEM_Hash->{TIMING}) &&
                                            ($main::FHEM_Hash->{TIMING} ne MMSOMFY::Timing::off)
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

        if ($skipArguments)
        {
            $retString = join($sepChar, @consts);
        }
        else
        {
            $retString = join($sepChar, map {$_ . $values{$_}} @consts);
        }

        return $retString;
    }

    # During intialize we get cmd undef and a list of possible settings must be returned.
    # If cmd is set, check if cmd is valid for model.
    sub Check($$$) {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Command ($main::FHEM_Hash->{NAME}): Enter 'Check'");

        my ($mode, $cmd, $cmdarg) = @_;
        my $retval = undef;
        my $name = $main::FHEM_Hash->{NAME};

        # ... create command list without arguments ...
        my $cmdListwoArg = MMSOMFY::Command::ToString("|", 1);

        # ... and command list with arguments ...
        my $cmdListwithArg = MMSOMFY::Command::ToString("|", 0);

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
                    ($cmd.":noArg") =~ qr/$cmdListwithArg/
                ) || (
                    # or argument is not defined
                    !defined ($cmdarg) && 
                    
                    # ... but needed (not marked with 'noArg') ...
                    ($cmd.":noArg") !~ qr/$cmdListwithArg/
                )
            )
        {
            my $errormessage = "MMSOMFY::Command::Check ($name): Invalid command: $cmd ";
            $errormessage = $errormessage +  $cmdarg if defined($cmdarg);
            main::Log3($name, 1, $errormessage);

            # ... cmd is cleared because it is invalid ...
            $_[1] = undef;

            # ... and retval gets list of available commands.
            $retval = ToString();
        }
        # ... otherwise check and adjust arguments ...
        else
        {
            # if cmd is one of *_for_timer ...
            if
                (
                    $cmd eq MMSOMFY::Command::close_for_timer || 
                    $cmd eq MMSOMFY::Command::open_for_timer ||
                    $cmd eq MMSOMFY::Command::on_for_timer ||
                    $cmd eq MMSOMFY::Command::off_for_timer
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
            # if cmd is stop ...
            if ($cmd eq MMSOMFY::Command::stop)
            {
                # ... then if state is not moving ...
                if ($main::FHEM_Hash->{STATE} ne MMSOMFY::State::moving)
                {
                    # ... clear the cmd, as otherwise go_my will be started ...
                    $_[1] = undef;
                    $_[2] = undef;
                    main::Log3($name, 3, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::stop . "' ignored as state is not '" . MMSOMFY::State::moving . "'");
                }
            }
            # for cmd manual ...
            if ($cmd eq MMSOMFY::Command::manual)
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
                    # ... get direction to the target position depending on current position ...
                    my $direction = MMSOMFY::Position::GetDirectionToTargetPosition($cmdarg);

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
                    main::Log3($name, 1, "MMSOMFY::Command::Check ($name): Error - Bad custom control code, use 2 digit hex codes only");
                    $retval = "MMSOMFY::Command::Check ($name): Error - Bad custom control code, use 2 digit hex codes only";
                }
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
        (my $Remote_FHEM_Hash, my $code) = @_;
        main::Log3($Remote_FHEM_Hash->{NAME}, 4, "MMSOMFY::Command ($Remote_FHEM_Hash->{NAME}): Enter 'DispatchRemote'");

        my $rawdAttr = $main::attr{$Remote_FHEM_Hash->{NAME}}{MMSOMFY::Attribute::rawDevice} if (exists($main::attr{$Remote_FHEM_Hash->{NAME}}{MMSOMFY::Attribute::rawDevice}));

        # check if rdev is defined and exists
        if (defined($rawdAttr))
        {
            main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): rawDevice is '$rawdAttr'");
            
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
                        main::Log3($Remote_FHEM_Hash, 4, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): Found remote MMSOMFY device '$rawhash->{NAME}'");

                        my $rawModel = $rawhash->{MODEL};
                        my $cmd = $code2command{$rawModel}{$code};

                        if ($cmd)
                        {
                            main::Log3($Remote_FHEM_Hash, 4, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): Send command '$cmd'.");
                            # add virtual as modifier to set command and directly call send
                            my $ret = main::MMSOMFY_Set($rawhash, $rawhash->{NAME}, MMSOMFY::Mode::virtual, $cmd );
                            if ($ret)
                            {
                                main::Log3($Remote_FHEM_Hash, 1, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): '$rawhash->{NAME}' returned '$ret' for command '$cmd'.");
                            }
                            else
                            {
                                main::Log3($Remote_FHEM_Hash, 4, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): command '$cmd' succeeded for '$rawhash->{NAME}'.");
                            }
                        }
                        else
                        {
                            main::Log3($Remote_FHEM_Hash, 1, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): Command '$cmd' is not valid for remote device '$rawhash->{NAME}'");
                        }
                    }
                } else {
                    main::Log3($Remote_FHEM_Hash, 1, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): rawDevice '$rawdev' not found.");
                }
            }
        } else {
            main::Log3($Remote_FHEM_Hash, 1, "MMSOMFY::Command::DispatchRemoteCommand ($Remote_FHEM_Hash->{NAME}): No rawDevice defined in '$Remote_FHEM_Hash->{NAME}'");
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
        my $model = $main::FHEM_Hash->{MODEL};
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
                    ($main::FHEM_Hash->{MMSOMFY::Definition::MODEL} ne MMSOMFY::Model::switch)
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

sub Update ($$$)
{
    main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Enter 'Update'");
    (my $mode, my $cmd, my $cmdargs) = @_;
    my $deviceCommand;

    my $model = $main::FHEM_Hash->{MMSOMFY::Definition::MODEL};
    if ($model eq MMSOMFY::Model::switch)
    {
        main::Log3($main::FHEM_Hash->{NAME}, 3, "Handle Switch.");
        if
            (
                $cmd eq MMSOMFY::Command::on_for_timer ||
                $cmd eq MMSOMFY::Command::off_for_timer
            )
        {
            # Start timer for reversed command
        }
    }
    elsif
        (
            $model eq MMSOMFY::Model::awning ||
            $model eq MMSOMFY::Model::shutter
        )
    {
        main::Log3($main::FHEM_Hash->{NAME}, 3, "Handle Awning or Shutter.");
    }
    else
    {
        main::Log3($main::FHEM_Hash->{NAME}, 3, "Unhandled model.");
    }

    main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Exit 'Update'");
    return $deviceCommand
}

1;
################################################################################
package main;

use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

our $FHEM_Hash;

my %somfy_codes2cmd = (
    "10" => "go_my",    # goto "my" position
    "11" => "stop",     # stop the current movement
    "20" => "open",      # go "up"
    "40" => "close",       # go "down"
    "80" => "prog",     # finish pairing
    "90" => "wind_sun_9",     # wind and sun (sun + flag)
    "A0" => "wind_only_a",     # wind only (flag)
    "100" => "close_for_timer",
    "101" => "open_for_timer",
    "XX" => "z_custom", # custom control code
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
    # $FHEM_Hash->{GetFn}       = "X_Get"; # Not used as you can't get data from SOMFY RTS
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

    # reset reading time on def to 0 seconds (1970)
    my $tzero = FmtDateTime(0);

    $FHEM_Hash->{ADDRESS} = uc($address);
    $FHEM_Hash->{MMSOMFY::Definition::MODEL} = lc($model);
    $FHEM_Hash->{STATE} = MMSOMFY::State::inactive;

    # check optional arguments for device definition
    if (int(@a) > 4) 
    {
        # check encryption key (2 hex digits)
        if (($a[4] !~ m/^[a-fA-F0-9]{2}$/i))
        {
            $errormessage .= "Error: Wrong format of <encryption-key> '$a[4]': specify a 2 digit hex value.";
            return $errormessage;
        }

        # store it as reading, so it is saved in the statefile
        setReadingsVal($FHEM_Hash, MMSOMFY::Reading::enc_key, uc($a[4]), $tzero);
    }

    if (int(@a) > 5)
    {
        # check rolling code (4 hex digits)
        if (($a[5] !~ m/^[a-fA-F0-9]{4}$/i))
        {
            $errormessage .= "Error: Wrong format of <rolling-code> '$a[5]': specify a 4 digit hex value.";
            return $errormessage;
        }

        # store it
        setReadingsVal($FHEM_Hash,  MMSOMFY::Reading::rolling_code, uc($a[5]), $tzero);
    }

    my $code  = uc($address);
    my $ncode = 1;
    $FHEM_Hash->{CODE}{$ncode++} = $code;
    $modules{MMSOMFY}{defptr}{$code}{$name} = $FHEM_Hash;

    # Clear existing attributes in case of modify def, so we start without attributes.
    %{$attr{$name}} = ();

    # Set verbose to 5 for debugging. Todo Remove
    $attr{$name}{"verbose"} = 5;

    # Add the device specific attributes to the instance depending on model.
    MMSOMFY::Attribute::AddSpecificAttributes;

#    ! Set default attributes !
#    setReadingsVal($FHEM_Hash, MMSOMFY::Reading::position, MMSOMFY::Position::Current, $tzero);
#    setReadingsVal($FHEM_Hash, MMSOMFY::Reading::exact, MMSOMFY::Position::Current, $tzero);
#    setReadingsVal($FHEM_Hash, MMSOMFY::Reading::movement, MMSOMFY::Movement::none, $tzero);
#    setReadingsVal($FHEM_Hash, MMSOMFY::Reading::state, MMSOMFY::State::opened, $tzero);
#    $FHEM_Hash->{TIMING} = MMSOMFY::Timing::off;
#    $FHEM_Hash->{STATE} = MMSOMFY::State::opened;
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
    Log3($FHEM_Hash->{NAME}, 5, "MMSOMFY_Attr ($FHEM_Hash->{NAME}): $cmd $aName ($aVal)");
    
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
                $pos = _MMSOMFY_ConvertTo100To0( $pos );
                $rounded = _MMSOMFY_Runden( $pos );
                $stateTrans = _MMSOMFY_Translate100To0( $rounded );
            }
            elsif ((!$aVal) && (AttrVal($name, MMSOMFY::Attribute::positionInverse, 0)))
            {
                # set to 0 and was 1 before - convert From100To10
                # first exact then round to pos
                $pos = _MMSOMFY_ConvertFrom100To0( $pos );
                $rounded = _MMSOMFY_Runden( $pos );
                $stateTrans = _MMSOMFY_Translate( $rounded );
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
            readingsBulkUpdate($FHEM_Hash,"state",$stateTrans);
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

    my $retval;

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
                    if ($lh->{MODEL} eq MMSOMFY::Model::remote)
                    {
                        # update the state and log it
                        # Debug "MMSOMFY Parse: $name msg: $msg  --> $cmd-$newstate";
                        Log3($Caller->{NAME}, 3, "MMSOMFY_Parse ($Caller->{NAME}): Command $command{'command_desc'}($command{'command'}) from remote $name($command{'address'})");
                        readingsSingleUpdate($lh, "received", $command{'command'}, 1);
                        readingsSingleUpdate($lh, "command", $command{'command_desc'}, 1);

                        MMSOMFY::Command::DispatchRemote($lh, $command{'command'});

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

        Log3($Caller->{NAME}, 4, "MMSOMFY_Parse ($Caller->{NAME}): Exit");
        return $retval;
    }
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
    my @args = @_;
    # HASH is 0th argument
    $FHEM_Hash = shift @args;

    Log3($FHEM_Hash->{NAME}, 4, "MMSOMFY_Set ($FHEM_Hash->{NAME}): Enter");

    my $retval = undef;
    my $name;
    my $mode;
    my $cmd;
    my $cmdarg;

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
            # There are more arguments as expected ...
            Log3($name, 2, "MMSOMFY_Set ($name): More arguments found as expected during parse arguments.\nRemaining arguments (" . join(", ", @args) . ") are ignored.");

            # ... remaining arguments are ignored.
            last;
        }
    }

    # Check if command is valid for this module instance.
    # valid  : $retval undefined / $mode, $cmd and $cmdarg adjusted to fit.
    # invalid: $retval list of possible commands / $cmd undef
    $retval = MMSOMFY::Command::Check($mode, $cmd, $cmdarg);

    # if cmd is defined parsing was successful and a valid command shall be executed.
    if (defined($cmd))
    {
        # Command shall be executed.
        # Write log message for command to be executed.
        my $logmessage = "MMSOMFY_set ($name): Handling with mode: $mode / cmd: $cmd";
        if (defined($cmdarg))
        {
            $logmessage = $logmessage . " / cmdarg: $cmdarg";
        }
        Log3($name, 3, $logmessage);

        my $deviceCommand = MMSOMFY::DeviceModel::Update($mode, $cmd, $cmdarg);

        if(defined($deviceCommand))
        {
            MMSOMFY::Command::Send2Device($cmd, $cmdarg);
        }
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
    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_Runden ($FHEM_Hash->{NAME}): Enter");

    my ($v) = @_;
    if ( ( $v > 105 ) && ( $v < 195 ) ) {
        $v = 150;
    } else {
        $v = int(($v + 5) /10) * 10;
    }

    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_Runden ($FHEM_Hash->{NAME}): Exit");
    return sprintf("%d", $v );
} # end sub Runden


###################################
sub _MMSOMFY_Translate($) {
    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_Translate ($FHEM_Hash->{NAME}): Enter");

    my ($v) = @_;

    if(exists($translations{$v})) {
        $v = $translations{$v}
    }

    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_Translate ($FHEM_Hash->{NAME}): Exit");
    return $v
}

###################################
sub _MMSOMFY_Translate100To0($) {
    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_Translate100To0 ($FHEM_Hash->{NAME}): Enter");

    my ($v) = @_;

    if(exists($translations100To0{$v})) {
        $v = $translations100To0{$v}
    }

    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_Translate100To0 ($FHEM_Hash->{NAME}): Exit");
    return $v
}


#############################
sub _MMSOMFY_ConvertFrom100To0($) {
    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_ConvertFrom100To0 ($FHEM_Hash->{NAME}): Enter");

    my ($v) = @_;

  return $v if ( ! defined($v) );
  return $v if ( length($v) == 0 );
  return $v if ( $v =~ /^(close|open)$/);

  $v = minNum( 100, maxNum( 0, $v ) );

    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_ConvertFrom100To0 ($FHEM_Hash->{NAME}): Exit");
  return (( $v < 10 ) ? ( 200-($v*10.0) ) : ( (100-$v)*10.0/9 ));
}

#############################
sub _MMSOMFY_ConvertTo100To0($) {
    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_ConvertTo100To0 ($FHEM_Hash->{NAME}): Enter");

    my ($v) = @_;

  return $v if ( ! defined($v) );
  return $v if ( length($v) == 0 );

  $v = minNum( 200, maxNum( 0, $v ) );

    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_ConvertTo100To0 ($FHEM_Hash->{NAME}): Exit");
  return ( $v > 100 ) ? ( (200-$v)/10.0 ) : ( 100-(9*$v/10.0) );
}

###################################
# calulates the position depending on moving direction ($move), last position ($pos) and time since starting move ($dt)
# For calculation the timings are used if defined.
sub _MMSOMFY_CalcCurrentPos($$$) {
    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_CalcCurrentPos ($FHEM_Hash->{NAME}): Enter");

    my ($move, $pos, $dt) = @_;

    my $name = $FHEM_Hash->{NAME};
    my $newPos = $pos;

    # If there are no timings position can not be calculated and remain set statically.
    if ($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::off)
    {
        Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Position set statically as no timings are defined.");
    }
    # ... else if basic timing settings are available ...
    elsif ($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::basic)
    {
        Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Basic Timing is defiend. No down position.");

        # if movement is close ...
        if ($move eq MMSOMFY::Movement::down)
        {
            # ... movement will be added to last position.
            $newPos = $pos + MMSOMFY::Position::dPosForTime(MMSOMFY::Position::RANGE, MMSOMFY::Timing::Opened2Closed, $dt);
        }
        # ... else if movement is up ...
        elsif ($move eq MMSOMFY::Movement::up)
        {
            # ... movement wil be substracted from last position.
            $newPos = $pos - MMSOMFY::Position::dPosForTime(MMSOMFY::Position::RANGE, MMSOMFY::Timing::Closed2Opened, $dt);
        }
        # ... else use last position and report error.
        else
        {
            Log3($name,1,"_MMSOMFY_CalcCurrentPos ($name): $name wrong move: $move");
            $newPos = $pos;
        }
    }
    # ... else if extended timings are set, split ranges on down barrier.
    elsif ($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::extended)
    {
        Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Separate down position. Splitting ranges if necessray.");

        # ... get all relevant positions and ranges.
        my $posOpened = MMSOMFY::Position::FromState(MMSOMFY::State::opened);
        my $posDown = MMSOMFY::Position::FromState(MMSOMFY::State::down);
        my $posClosed = MMSOMFY::Position::FromState(MMSOMFY::State::closed);
        my $rOpenedDown = MMSOMFY::Position::diffPosition($posOpened, $posDown);
        my $rDownClosed = MMSOMFY::Position::diffPosition($posDown, $posClosed);

        # if movement is close ...
        if ($move eq MMSOMFY::Movement::down)
        {
            Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Movement is closing.");

            # ... if current position is between down and closed ...
            if (MMSOMFY::Position::IsPosBetween($pos, MMSOMFY::State::down, MMSOMFY::State::closed))
            {
                Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Between down and closed. Add movement to position.");

                # ... add movement to last position with timing 'Down2Closed' related to range.
                $newPos = $pos + MMSOMFY::Position::dPosForTime($rDownClosed, MMSOMFY::Timing::Down2Closed, $dt);
            }
            # ... else current position is between opened and down ...
            else
            {
                # ... get movement with timing Opened2Down related to range.
                my $dPos = MMSOMFY::Position::dPosForTime($rOpenedDown, MMSOMFY::Timing::Opened2Down, $dt);

                Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Between opened and down, moving $dPos.");

                # If newPos would breach down barrier calculation must be corrected ...
                if (MMSOMFY::Position::IsPosBetween($pos + $dPos, MMSOMFY::State::down, MMSOMFY::State::closed))
                {
                    Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Movement crosses down barrier. Correction needed.");

                    # Get traveltime beyond down barrier, ...
                    my $moveBeyondDown = $pos + $dPos - $posDown;
                    my $tBeyondDown = $dt * $moveBeyondDown / $dPos;

                    # ... calculate movement beyond down with timing Down2Closed related to range.
                    $dPos = MMSOMFY::Position::dPosForTime($rDownClosed, MMSOMFY::Timing::Down2Closed, $tBeyondDown);

                    # ... add movement beyond down to down position for new position.
                    $newPos = $posDown + $dPos;
                }
                # ... not breaking the down barrier calculation is already correct ...
                else
                {
                    Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Movement before down barrier.");

                    # ... and new position can be set accordingly.
                    $newPos = $pos + $dPos;
                }
            }
        }
        elsif ($move eq MMSOMFY::Movement::up)
        {
            Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Movement is up.");

            # ... if current position is between down and opened ...
            if (MMSOMFY::Position::IsPosBetween($pos, MMSOMFY::State::down, MMSOMFY::State::opened))
            {
                Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Between down and opened. Remvove movement from position.");

                # ... remove movement to last position with timing 'Down2Opened' related to range.
                $newPos = $pos - MMSOMFY::Position::dPosForTime($rOpenedDown, MMSOMFY::Timing::Down2Opened, $dt);
            }
            # ... else current position is between closed and down ...
            else
            {
                # ... get movement with timing Closed2Down related to range.
                my $dPos = MMSOMFY::Position::dPosForTime($rDownClosed, MMSOMFY::Timing::Closed2Down, $dt);

                Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Between closed and down, moving $dPos.");

                # If newPos would breach down barrier, calculation must be corrected ...
                if (MMSOMFY::Position::IsPosBetween($pos - $dPos, MMSOMFY::State::down, MMSOMFY::State::opened))
                {
                    Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Movement crosses down barrier. Correction needed.");

                    # Get traveltime beyond down barrier, ....
                    my $moveBeyondDown = $posDown - ($pos - $dPos);
                    my $tBeyondDown = $dt * $moveBeyondDown / $dPos;

                    # ... calculate movement beyond down with timing 'Down2Opened' related to range.
                    $dPos = MMSOMFY::Position::dPosForTime($rOpenedDown, MMSOMFY::Timing::Down2Opened, $tBeyondDown);

                    # ... remove movement beyond down from down position for new position.
                    $newPos = $posDown - $dPos;
                }
                # ... not breaking the down barrier calculation is already correct ...
                else
                {
                    Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Movement before down barrier.");

                    # ... and new position can be set accordingly.
                    $newPos = $pos - $dPos;
                }
            }
        } else {
            Log3($name,1,"_MMSOMFY_CalcCurrentPos: $name wrong move $move");
        }
    }

    # Bring back in range if exeeded.
    $newPos = MMSOMFY::Position::MaxPos if $newPos > MMSOMFY::Position::MaxPos;
    $newPos = MMSOMFY::Position::MinPos if $newPos < MMSOMFY::Position::MinPos;

    Log3($name, 4, "_MMSOMFY_CalcCurrentPos ($name): Updated position: $newPos");

    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_CalcCurrentPos ($FHEM_Hash->{NAME}): Exit");
    return $newPos;
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
    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_UpdateStartTime ($FHEM_Hash->{NAME}): Enter");

    my ($s, $ms) = gettimeofday();

    my $t = $s + ($ms / 1000000); # 10 msec
    my $t1 = 0;
    $t1 = $FHEM_Hash->{starttime} if(exists($FHEM_Hash->{starttime} ));
    $FHEM_Hash->{starttime}  = $t;
    my $dt = sprintf("%.2f", $t - $t1);

    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_UpdateStartTime ($FHEM_Hash->{NAME}): Exit");
    return $dt;
} # end sub UpdateStartTime


###################################
sub _MMSOMFY_TimedUpdate($) {
    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_TimedUpdate ($FHEM_Hash->{NAME}): Enter");

    my ($FHEM_Hash) = @_;

    Log3($FHEM_Hash->{NAME},4,"_MMSOMFY_TimedUpdate");

    # get current infos
    my $pos = ReadingsVal($FHEM_Hash->{NAME},'exact',undef);

  if ( AttrVal( $FHEM_Hash->{NAME}, "positionInverse", 0 ) ) {
    Log3($FHEM_Hash->{NAME},5,"_MMSOMFY_TimedUpdate : pos before convert so far : $pos");
    $pos = _MMSOMFY_ConvertFrom100To0( $pos );
  }
    Log3($FHEM_Hash->{NAME},5,"_MMSOMFY_TimedUpdate : pos so far : $pos");

    my $dt = _MMSOMFY_UpdateStartTime();
  my $nowt = gettimeofday();

    $pos = _MMSOMFY_CalcCurrentPos($FHEM_Hash->{MOVE}, $pos, $dt);
#   my $posRounded = RoundInternal( $pos );

    Log3($FHEM_Hash->{NAME},5,"_MMSOMFY_TimedUpdate : delta time : $dt   new rounde pos (rounded): $pos ");

    $FHEM_Hash->{runningtime} = $FHEM_Hash->{runningtime} - $dt;
    if ( $FHEM_Hash->{runningtime} <= 0.1) {
        if ( defined( $FHEM_Hash->{runningcmd} ) ) {
            _MMSOMFY_SendCommand($FHEM_Hash, $FHEM_Hash->{runningcmd});
        }
        # trigger update from timer
        MMSOMFY::Reading::Update($FHEM_Hash->{updateState}, 'stop');
        delete $FHEM_Hash->{updatestate};
        delete $FHEM_Hash->{starttime};
        delete $FHEM_Hash->{runningtime};
        delete $FHEM_Hash->{runningcmd};
    } else {
        my $utime = $FHEM_Hash->{runningtime} ;
        if($utime > $somfy_updateFreq) {
            $utime = $somfy_updateFreq;
        }
        MMSOMFY::Reading::Update($pos, $FHEM_Hash->{MOVE});
        if ( defined( $FHEM_Hash->{runningcmd} )) {
            Log3($FHEM_Hash->{NAME},4,"_MMSOMFY_TimedUpdate: $FHEM_Hash->{NAME} -> stopping in $FHEM_Hash->{runningtime} sec");
        } else {
            Log3($FHEM_Hash->{NAME},4,"_MMSOMFY_TimedUpdate: $FHEM_Hash->{NAME} -> update state in $FHEM_Hash->{runningtime} sec");
        }
        my $nstt = maxNum($nowt+$utime-0.01, gettimeofday()+.1 );
        Log3($FHEM_Hash->{NAME},5,"_MMSOMFY_TimedUpdate: $FHEM_Hash->{NAME} -> next time to stop: $nstt");
        InternalTimer($nstt,"_MMSOMFY_TimedUpdate",$FHEM_Hash,0);
    }

    Log3($FHEM_Hash->{NAME}, 4, "_MMSOMFY_TimedUpdate ($FHEM_Hash->{NAME}): Exit");
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
