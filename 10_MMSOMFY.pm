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
        opened => "opened",
        off => "off",
        closed => "closed",
        on => "on",
        receiving => "receiving",
        ignored => "ignored",
        disabled => "disabled",
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
        TIMING => "TIMING",
        CALIBRATION_STATE => "CALIBRATION_STATE",
        CALIBRATION_STEP => "CALIBRATION_STEP",
        CALIBRATION_INSTRUCTION => "CALIBRATION_INSTRUCTION",
        CALIBRATION_CONFIRM_CMD => "CALIBRATION_CONFIRM_CMD",
        CALIBRATION_LAST_MEASUREMENT => "CALIBRATION_LAST_MEASUREMENT",
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

    sub SetCalibrationValues($$$$$;$) {
        my ($state, $step, $instruction, $confirmCmd, $lastMeasurement, $hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;

        return if
        (
            !$hash ||
            !$main::defs{$hash->{NAME}} ||
            main::IsIgnored($hash->{NAME}) ||
            main::IsDisabled($hash->{NAME})
        );

        $hash->{MMSOMFY::Internal::CALIBRATION_STATE} = $state;
        $hash->{MMSOMFY::Internal::CALIBRATION_STEP} = $step;
        $hash->{MMSOMFY::Internal::CALIBRATION_INSTRUCTION} = $instruction;
        $hash->{MMSOMFY::Internal::CALIBRATION_CONFIRM_CMD} = $confirmCmd;
        $hash->{MMSOMFY::Internal::CALIBRATION_LAST_MEASUREMENT} = $lastMeasurement;
    }

    sub ClearCalibrationValues(;$) {
        my ($hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;

        SetCalibrationValues(
            "idle",
            0,
            "No calibration active",
            "calibrate",
            "-",
            $hash
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
    use Scalar::Util qw(looks_like_number);

    #enumeration items
    use constant {
        driveTimeOpenedToDown => 'driveTimeOpenedToDown',
        driveTimeOpenedToClosed => 'driveTimeOpenedToClosed',
        driveTimeDownToOpened => 'driveTimeDownToOpened',
        driveTimeClosedToOpened => 'driveTimeClosedToOpened',
                myPosition => 'myPosition',
        symbolLength => 'symbolLength',
        repetition => 'repetition',
        fixedEnckey => 'fixedEnckey',
        ignore => 'ignore',
        disable => 'disable',
        rawDevice => 'rawDevice',
        userattr => 'userattr',
        webCmd => 'webCmd',
        devStateIcon => 'devStateIcon',
        cmdIcon => 'cmdIcon',
        stateFormat => 'stateFormat',
        calibrationMode => 'calibrationMode',
        calibrationQuality => 'calibrationQuality',
        lastCalibration => 'lastCalibration',
        calibrationHistory => 'calibrationHistory',
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
            driveTimeDownToOpened => "",
            driveTimeClosedToOpened => "",
                        myPosition => "",
            symbolLength => "",
            repetition => "",
            fixedEnckey => ":1,0",
            ignore => ":0,1",
            disable => ":0,1",
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
                            ($name eq MMSOMFY::Attribute::disable) ||
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
                            ($name eq MMSOMFY::Attribute::driveTimeDownToOpened) ||
                            ($name eq MMSOMFY::Attribute::driveTimeClosedToOpened) ||
                                                        ($name eq MMSOMFY::Attribute::myPosition)
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
            elsif ($attrName eq MMSOMFY::Attribute::driveTimeDownToOpened)
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
                        $retval = MMSOMFY::Timing::CheckTiming($attrName, $_[2], MMSOMFY::Attribute::driveTimeDownToOpened, $main::attr{$name}{MMSOMFY::Attribute::driveTimeDownToOpened}, "greater");
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
                if ($cmd eq "set")
                {
                    if
                        (
                            ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::shutter) ||
                            ($hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::awning)
                        )
                    {
                        if (!looks_like_number($attrValue) || $attrValue < MMSOMFY::Position::STARTPOS() || $attrValue > MMSOMFY::Position::ENDPOS())
                        {
                            $retval = "MMSOMFY::Attribute::CheckAttribute ($hash->{NAME}): Value for $attrName ($attrValue) must be between '" . MMSOMFY::Position::STARTPOS() . "' and '" . MMSOMFY::Position::ENDPOS() . "'";
                        }
                        else
                        {
                            $_[2] = sprintf("%.0f", $attrValue);
                        }
                    }
                    else
                    {
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
            # for remotes only
            elsif ($attrName eq MMSOMFY::Attribute::disable)
            {
                # ...  preset state to receving ...
                $hash->{STATE} = MMSOMFY::State::receiving;

                # ... if attribute shall be set ...
                if ($cmd eq "set" && $attrValue eq 1)
                {
                    # ... state is changed to ignored.
                    $hash->{STATE} = MMSOMFY::State::disabled;
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

    # Validate timing attributes for consistency
    sub ValidateTimingAttributes($) {
        my ($hash) = @_;
        $hash = $main::FHEM_Hash unless defined $hash;

        return 0 unless $hash && $main::defs{$hash->{NAME}};
        return 0 if main::IsIgnored($hash->{NAME}) || main::IsDisabled($hash->{NAME});

        # When timing is off, there is nothing to validate.
        return 1 if ($hash->{MMSOMFY::Internal::TIMING} || '') eq MMSOMFY::Timing::off;

        my @errors;

        my $closed2opened = MMSOMFY::Timing::Closed2Opened($hash);
        my $opened2closed = MMSOMFY::Timing::Opened2Closed($hash);

        push @errors, "driveTimeClosedToOpened must be > 0" unless defined($closed2opened) && $closed2opened > 0;
        push @errors, "driveTimeOpenedToClosed must be > 0" unless defined($opened2closed) && $opened2closed > 0;

        if (($hash->{MMSOMFY::Internal::TIMING} || '') eq MMSOMFY::Timing::extended) {
            my $down2opened = MMSOMFY::Timing::Down2Opened($hash);
            my $opened2down = MMSOMFY::Timing::Opened2Down($hash);

            push @errors, "driveTimeDownToOpened must be > 0" unless defined($down2opened) && $down2opened > 0;
            push @errors, "driveTimeOpenedToDown must be > 0" unless defined($opened2down) && $opened2down > 0;

            # Calculate the two derived segments using the 4 core timing attributes
            my $closed2down = defined($down2opened) && defined($closed2opened) ? $closed2opened - $down2opened : undef;
            my $down2closed = defined($opened2down) && defined($opened2closed) ? $opened2closed - $opened2down : undef;

            # Only validate derived partials for physical plausibility (non-negative)
            push @errors, "derived driveTimeClosedToDown must be >= 0" unless defined($closed2down) && $closed2down >= 0;
            push @errors, "derived driveTimeDownToClosed must be >= 0" unless defined($down2closed) && $down2closed >= 0;

            if (defined($closed2down) && defined($closed2opened) && defined($down2opened)) {
                my $sum = $closed2down + $down2opened;
                my $tolerance = 0.5;
                push @errors, sprintf("Closed2Opened mismatch configured=%.1fs calculated=%.1fs", $closed2opened, $sum)
                    if abs($closed2opened - $sum) > $tolerance;
            }

            if (defined($opened2down) && defined($opened2closed) && defined($down2closed)) {
                my $sum = $opened2down + $down2closed;
                my $tolerance = 0.5;
                push @errors, sprintf("Opened2Closed mismatch configured=%.1fs calculated=%.1fs", $opened2closed, $sum)
                    if abs($opened2closed - $sum) > $tolerance;
            }
        }

        if (@errors) {
            main::Log3($hash->{NAME}, 1, "TIMING VALIDATION ERRORS:");
            main::Log3($hash->{NAME}, 1, "  - $_") foreach @errors;
            main::Log3($hash->{NAME}, 1, "Please check and correct timing attributes.");
            return 0;
        }

        return 1;
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
        
        if ($hash->{MMSOMFY::Internal::TIMING} eq extended)
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
        
        if ($hash->{MMSOMFY::Internal::TIMING} eq extended)
        {
            $retval = $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeClosedToOpened} - $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeDownToOpened};
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
            $retval = $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeDownToOpened};
        }

        main::Log3(
            $hash->{NAME},
            4,
            "MMSOMFY::Timing ($hash->{NAME}): Exit 'Down2Opened'"
        );

        return $retval;
    }

    # Get movement timeout threshold in seconds.
    # Used for safety checks in timer callbacks to prevent runaway simulations.
    sub MovementTimeoutSeconds() {
        return 300;
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
        factor => "factor",
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

    # Update Readings according given factor and moving.
    sub PositionUpdate($$;$) {
        my ($factor, $movement, $hash) = @_;
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
        my $positionFactor = $factor;

        $positionFactor = 0 if $positionFactor < 0;
        $positionFactor = 1 if $positionFactor > 1;

        my $position = sprintf("%.0f", MMSOMFY::Position::STARTPOS() + ($positionFactor * MMSOMFY::Position::RANGE()));

        main::Log3(
            $name,
            5,
            "MMSOMFY::Reading ($hash->{NAME}): Update readings for $name, factor:$factor, position:$position, movement:$movement."
        );

        main::readingsBeginUpdate($hash);

        main::readingsBulkUpdate($hash, MMSOMFY::Reading::factor, $factor, 1);
        main::readingsBulkUpdate($hash, MMSOMFY::Reading::position, $position, 1);
        main::readingsBulkUpdate($hash, MMSOMFY::Reading::movement, $movement, 1);

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

    # Frame settings for postition calculation as percent values.
    # STARTPOS is used for opened and ENDPOS for closed.
    # If different positions are needed they can be created by userReadings.
    use constant {
        STARTPOS => 0,
        ENDPOS => 100,
    };

    # Range from frame settings
    use constant RANGE => ENDPOS-STARTPOS;

    1;

################################################################################

# Enumeration implementation for MMSOMFY::Command
package MMSOMFY::Command;

    use strict;
    use warnings;
    use Scalar::Util qw(looks_like_number);

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
        calibrate => "calibrate",
        calibrate_next => "calibrate_next",
        calibrate_abort => "calibrate_abort",
        calibrate_verify => "calibrate_verify",
        calibrate_reset => "calibrate_reset",
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
            position => "",
            manual =>
                (
                    (
                        defined($main::FHEM_Hash->{MMSOMFY::Internal::TIMING}) &&
                        $main::FHEM_Hash->{MMSOMFY::Internal::TIMING} ne MMSOMFY::Timing::off
                    )
                        ? ""
                        : ":open,close"
                ),
            wind_sun_9 => ":noArg",
            wind_only_a => ":noArg",
            calibrate => ":noArg",
            calibrate_next => ":noArg",
            calibrate_abort => ":noArg",
            calibrate_verify => ":noArg",
            calibrate_reset => ":noArg",
        );

        my ($sepChar, $skipArguments) = @_;
        $sepChar = " " unless defined $sepChar;
        my $calibrationActive =
            $main::FHEM_Hash->{CalibrationMode} &&
            (
                $main::FHEM_Hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::awning ||
                $main::FHEM_Hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::shutter
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
                                    (
                                        $calibrationActive &&
                                        (
                                            ($name eq MMSOMFY::Command::calibrate_next) ||
                                            ($name eq MMSOMFY::Command::calibrate_abort)
                                        )
                                    ) || (
                                        !$calibrationActive &&
                                        (
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
                                                    ($name eq MMSOMFY::Command::open_for_timer) ||
                                                    ($name eq MMSOMFY::Command::calibrate) ||
                                                    ($name eq MMSOMFY::Command::calibrate_next) ||
                                                    ($name eq MMSOMFY::Command::calibrate_abort) ||
                                                    ($name eq MMSOMFY::Command::calibrate_verify) ||
                                                    ($name eq MMSOMFY::Command::calibrate_reset)
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

        # Normalize remote My semantics early: when moving, go_my must act as stop.
        if ($cmd eq MMSOMFY::Command::go_my)
        {
            my $movement = main::ReadingsVal($name, MMSOMFY::Reading::movement, undef);
            if
                (
                    $movement &&
                    (
                        $movement eq MMSOMFY::Movement::up ||
                        $movement eq MMSOMFY::Movement::down
                    )
                )
            {
                $_[1] = $cmd = MMSOMFY::Command::stop;
                $_[2] = $cmdarg = undef;
                main::Log3($name, 3, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::go_my . "' replaced with '" . MMSOMFY::Command::stop . "' before validation due to moving '$movement'");
            }
        }

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
                my $movement = main::ReadingsVal($name, MMSOMFY::Reading::movement, undef);

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
                my $movement = main::ReadingsVal($name, MMSOMFY::Reading::movement, undef);

                main::Log3($name, 3, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::stop . "' movement '$movement'");

                if
                    (
                        !$movement ||
                        (
                            $movement ne MMSOMFY::Movement::up &&
                            $movement ne MMSOMFY::Movement::down
                        )
                    )
                {
                    # ... clear the cmd, as otherwise go_my will be started ...
                    $_[1] = undef;
                    $_[2] = undef;
                    main::Log3($name, 3, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::stop . "' ignored as device is not moving");
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
                elsif(looks_like_number($cmdarg))
                {
                    # ... then set cmd directly to position with given argument.
                    $_[1] = $cmd = MMSOMFY::Command::position;
                    main::Log3($name, 3, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::manual . "' replaced by '" . $cmd . "' with argument'". $cmdarg . "'.");
                }
                # ... argument is not numeric ...
                else
                {
                    # ... set an error and clear the cmd.
                    $_[1] = undef;
                    $_[2] = undef;
                    main::Log3($name, 1, "MMSOMFY::Command::Check ($name): Error - Bad position value");
                    $retval = "MMSOMFY::Command::Check ($name): Bad position value";
                }
            }
            # for cmd position ...
            elsif ($cmd eq MMSOMFY::Command::position)
            {
                # ... if argument is not numeric ...
                if (!looks_like_number($cmdarg))
                {
                    # ... set an error and clear the cmd.
                    $_[1] = undef;
                    $_[2] = undef;
                    main::Log3($name, 1, "MMSOMFY::Command::Check ($name): Error - Bad position value");
                    $retval = "MMSOMFY::Command::Check ($name): Bad position value";
                }
                # ... otherwise if argument is out of range ...
                elsif ($cmdarg < MMSOMFY::Position::STARTPOS() || $cmdarg > MMSOMFY::Position::ENDPOS())
                {
                    # ... set an error and clear the cmd.
                    $_[1] = undef;
                    $_[2] = undef;
                    main::Log3($name, 1, "MMSOMFY::Command::Check ($name): Error - Position value out of range");
                    $retval = "MMSOMFY::Command::Check ($name): Position value out of range";
                }
                # ... otherwise, if the argument deviates less than 1% from the value for closed ...
                elsif (abs(MMSOMFY::Position::ENDPOS() - $cmdarg) < 1)
                {
                    # ... then set cmd directly to close and clear the argument.
                    $_[1] = $cmd = MMSOMFY::Command::close;
                    $_[2] = $cmdarg = undef;
                    main::Log3($name, 3, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::position . "' replaced by '" . $cmd . "', argument cleared.");
                }
                # ... otherwise, if the argument deviates less than 1% from the value for opened ...
                elsif (abs(MMSOMFY::Position::STARTPOS() - $cmdarg) < 1)
                {
                    # ... then set cmd directly to open and clear the argument.
                    $_[1] = $cmd = MMSOMFY::Command::open;
                    $_[2] = $cmdarg = undef;
                    main::Log3($name, 3, "MMSOMFY::Command::Check ($name): Command '" . MMSOMFY::Command::position . "' replaced by '" . $cmd . "', argument cleared.");
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
        if ($ioType =~ m/SIGNALduino/)
        {
            main::Log3($name, 4, "MMSOMFY::Command::Decode ($name): Preprocessing for SIGNALduino");

            my $encData = substr($msg, 2);
            if (length($encData) == 14 || length($encData) == 20)
            {
                if ($encData =~ m/^[0-9A-F]+$/)
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
                    main::Log3($name, 1, "MMSOMFY::Command::Decode ($name): Error - Somfy RTS message has wrong format :$encData:");
                    $msg = undef;
                }
            }
            else
            {
                main::Log3($name, 1, "MMSOMFY::Command::Decode ($name): Error - Somfy RTS message has wrong format (length must be 14 or 20):$encData:");
                $msg = undef;
            }
        }

        if (defined($msg))
        {
            # Msg-Format
            # YsAA2F18F00085E8
            if (substr($msg, 0, 2) ne "Yr" && substr($msg, 0, 2) ne "Yt")
            {
                # Check for correct length 16 character
                if (length($msg) == 16)
                {
                    # Ys     AA         2          F          18F0        0085E8
                    #    | enc_key | command & checksum | rolling_code | address
                    #    | 1 byte  |       1 byte       |   2 bytes    | 3 bytes
                    # enc_key is byte 1
                    $retval{'enc_key'} = substr($msg, 2, 2);
                    # command is higher nibble of byte 2
                    $retval{'command'} = sprintf("%X", hex(substr($msg, 4, 2)) & 0xF0);
                    $retval{'command_desc'} = $code2command{MMSOMFY::Model::remote}{$retval{'command'}};
                    # checksum is lower nibble of byte 2
                    $retval{'checksum'} = sprintf("%X", hex(substr($msg, 4, 2)) & 0x0F);
                    # rolling code is byte 3 and 4
                    $retval{'rolling_code'} = substr($msg, 6, 4);
                    # address needs bytes 5 and 7 swapped
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
        main::IOWrite($main::FHEM_Hash, "Y", $message);

        # ... and log change.
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::Command::ChangeCULAttribute ($main::FHEM_Hash->{NAME}): Set $attribute to $value for $main::FHEM_Hash->{IODev}->{NAME}");

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
            if ($ioType =~ m/SIGNALduino/)
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
                main::IOWrite($main::FHEM_Hash, 'sendMsg', $message);
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
                main::IOWrite($main::FHEM_Hash, "Y", $message );

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

    use Data::Dumper; # Todo remove debug

    use constant SimulationKey => "MovementSimulation";
    use constant UpdateFrequency => 0.25;  # Keep simulation responsive without overloading the FHEM event loop

    sub GetAdaptiveUpdateFrequency($)
    {
        my ($remainingTime) = @_;

        return 0.10 if (!defined($remainingTime) || $remainingTime <= 0.5);
        return 0.20 if ($remainingTime <= 5);
        return UpdateFrequency;
    }

    # Helper function to schedule next timer callback with adaptive frequency
    sub ScheduleNextTimerCallback($) {
        my $hash = shift;

        return unless defined($hash->{SimulationKey});

        my $Simulation = $hash->{SimulationKey};
        my $dt = main::gettimeofday() - $Simulation->{StartTime};

        # Calculate remaining time for this movement
        my $remainingTime = 0;
        if ($Simulation->{Command} eq MMSOMFY::Command::open) {
            if ($hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::basic) {
                my $totalTime = MMSOMFY::Timing::Closed2Opened($hash);
                $remainingTime = $totalTime - $dt;
            } elsif ($hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::extended) {
                my $totalTime = MMSOMFY::Timing::Closed2Opened($hash);
                $remainingTime = $totalTime - $dt;
            }
        } elsif ($Simulation->{Command} eq MMSOMFY::Command::close) {
            if ($hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::basic) {
                my $totalTime = MMSOMFY::Timing::Opened2Closed($hash);
                $remainingTime = $totalTime - $dt;
            } elsif ($hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::extended) {
                my $totalTime = MMSOMFY::Timing::Opened2Closed($hash);
                $remainingTime = $totalTime - $dt;
            }
        }

        # Use adaptive frequency based on remaining time
        my $adaptiveFrequency = GetAdaptiveUpdateFrequency($remainingTime);
        my $nextUpdate = $remainingTime > $adaptiveFrequency ? $adaptiveFrequency : $remainingTime;

        # Keep a lower bound to avoid flooding the event loop with callbacks.
        $nextUpdate = 0.10 if $nextUpdate < 0.10;

        main::Log3($hash->{NAME}, 5, sprintf("Scheduling next timer in %.2fs (remaining: %.2fs, adaptive freq: %.2fs)",
            $nextUpdate, $remainingTime, $adaptiveFrequency));

        main::InternalTimer(main::gettimeofday() + $nextUpdate, "MMSOMFY::DeviceModel::TimerCallback", $hash);
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

            # Initialize calibration internals for awning/shutter devices.
            MMSOMFY::Internal::ClearCalibrationValues($main::FHEM_Hash);

            $main::attr{$main::FHEM_Hash->{NAME}}{devStateIcon} = ($model eq MMSOMFY::Model::shutter)
                ? "opened:fts_window_2w closed:fts_shutter_100"
                : "opened:fts_window_2w closed:fts_sunblind_100";
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
            $tempTimings{MMSOMFY::Attribute::driveTimeDownToOpened} = $main::attr{$name}{MMSOMFY::Attribute::driveTimeDownToOpened};
            $tempTimings{MMSOMFY::Attribute::driveTimeClosedToOpened} = $main::attr{$name}{MMSOMFY::Attribute::driveTimeClosedToOpened};
            $tempTimings{$attrName} = $attrValue;

            my $symbol = ($main::FHEM_Hash->{MMSOMFY::Internal::MODEL} eq MMSOMFY::Model::shutter)
                ? "shutter"
                : "sunblind";

            # if basic timing values are defined ...
            if (defined($tempTimings{MMSOMFY::Attribute::driveTimeClosedToOpened}) && defined($tempTimings{MMSOMFY::Attribute::driveTimeOpenedToClosed}))
            {
                # ... check if extended timing values are defined ...
                if (defined($tempTimings{MMSOMFY::Attribute::driveTimeDownToOpened}) && defined($tempTimings{MMSOMFY::Attribute::driveTimeOpenedToDown}))
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

                main::readingsBeginUpdate($main::FHEM_Hash);

                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Add " . MMSOMFY::Reading::factor . " with 0.0");
                main::readingsBulkUpdate($main::FHEM_Hash, MMSOMFY::Reading::factor, 0.0, 1);

                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Add " . MMSOMFY::Reading::position . " with 0");
                main::readingsBulkUpdate($main::FHEM_Hash, MMSOMFY::Reading::position, 0, 1);

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

                $main::FHEM_Hash->{STATE} = MMSOMFY::State::opened;
                main::readingsDelete($main::FHEM_Hash, MMSOMFY::Reading::factor);
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

    sub TimerCallback($;$)
    {
        my ($hash, $cancel) = @_;
        $cancel = 0 unless defined($cancel);
        main::Log3($hash->{NAME}, 4, "MMSOMFY::DeviceModel ($hash->{NAME}): Enter 'TimerCallback'");

        # Robust error handling for timer callback
        eval {
            if (defined($hash->{SimulationKey}))
            {
                my $Simulation = $hash->{SimulationKey};
                main::Log3($hash->{NAME}, 4, "MMSOMFY::DeviceModel ($hash->{NAME}): Simulation => " . Dumper($Simulation));
                my $factor = main::ReadingsVal($hash->{NAME}, MMSOMFY::Reading::factor, undef);
                my $movement = main::ReadingsVal($hash->{NAME}, MMSOMFY::Reading::movement, undef);
                my $dt = main::gettimeofday() - $Simulation->{StartTime};

                # Sanity checks for elapsed time
                if ($dt < 0) {
                    main::Log3($hash->{NAME}, 1, "ERROR: Negative elapsed time detected ($dt). Stopping simulation.");
                    delete $hash->{SimulationKey};
                    MMSOMFY::Reading::PositionUpdate($factor, MMSOMFY::Movement::none, $hash);
                    return;
                }

                if ($dt > MMSOMFY::Timing::MovementTimeoutSeconds()) {
                    main::Log3($hash->{NAME}, 1, "ERROR: Movement timeout (" . MMSOMFY::Timing::MovementTimeoutSeconds() . " seconds). Stopping simulation.");
                    delete $hash->{SimulationKey};
                    MMSOMFY::Reading::PositionUpdate($factor, MMSOMFY::Movement::none, $hash);
                    return;
                }

                if (defined($Simulation->{TimerStopTime}) && main::gettimeofday() >= $Simulation->{TimerStopTime})
                {
                    $cancel = 1;
                }

                main::Log3($hash->{NAME}, 4, "MMSOMFY::DeviceModel ($hash->{NAME}): factor => $factor, dt => $dt");

            if ($Simulation->{Command} eq MMSOMFY::Command::open)
            {
                if ($hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::basic)
                {
                    my $driveTime = MMSOMFY::Timing::Closed2Opened($hash);
                    $factor = $Simulation->{StartFactor} - $dt / $driveTime;
                    $factor = 0.0 if ($factor < 0.01);

                    if ($factor eq 0.0 || $cancel > 0)
                    {
                        delete $hash->{SimulationKey};
                        $movement = MMSOMFY::Movement::none;
                    }
                    elsif (defined($hash->{SimulationKey}))
                    {
                        ScheduleNextTimerCallback($hash);
                    }
                }
                elsif ($hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::extended)
                {
                    my $closed2Down = MMSOMFY::Timing::Closed2Down($hash);
                    my $down2Opened = MMSOMFY::Timing::Down2Opened($hash);
                    
                    # Extended timing positions: 0.0 (opened), 0.95 (down), 1.0 (closed)
                    my $downFactor = 0.95;
                    
                    main::Log3($hash->{NAME}, 4, "MMSOMFY::DeviceModel ($hash->{NAME}): Extended timing open: StartFactor=$Simulation->{StartFactor}, downFactor=$downFactor, closed2Down=$closed2Down, down2Opened=$down2Opened");

                    if ($Simulation->{StartFactor} > $downFactor)
                    {
                        # Phase 1: Move from StartFactor up to 0.95 (down position) using Closed2Down timing
                        # Phase 2: Move from 0.95 to 0.0 (opened) using Down2Opened timing
                        my $timeToDown = $closed2Down;
                        my $totalTime = $closed2Down + $down2Opened;
                        
                        if ($dt < $timeToDown)
                        {
                            # Still in Phase 1: moving toward down position
                            $factor = $Simulation->{StartFactor} - ($dt / $closed2Down) * ($Simulation->{StartFactor} - $downFactor);
                        }
                        else
                        {
                            # Phase 2: moving from down toward opened
                            $factor = $downFactor - (($dt - $timeToDown) / $down2Opened) * $downFactor;
                        }
                    }
                    else
                    {
                        # Start <= 0.95: Already at or below down position, move directly to opened (0.0) using Down2Opened timing
                        $factor = $Simulation->{StartFactor} - ($dt / $down2Opened) * $Simulation->{StartFactor};
                    }
                    
                    $factor = 0.0 if ($factor < 0.01);

                    if ($factor eq 0.0 || $cancel > 0)
                    {
                        delete $hash->{SimulationKey};
                        $movement = MMSOMFY::Movement::none;
                    }
                    elsif (defined($hash->{SimulationKey}))
                    {
                        ScheduleNextTimerCallback($hash);
                    }
                }
            }
            elsif ($Simulation->{Command} eq MMSOMFY::Command::close)
            {
                if ($hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::basic)
                {
                    my $driveTime = MMSOMFY::Timing::Opened2Closed($hash);
                    $factor = $Simulation->{StartFactor} + $dt / $driveTime;
                    $factor = 1.0 if ($factor > 0.99);

                    if ($factor eq 1.0 || $cancel > 0)
                    {
                        delete $hash->{SimulationKey};                        
                        $movement = MMSOMFY::Movement::none;
                    }
                    elsif (defined($hash->{SimulationKey}))
                    {
                        ScheduleNextTimerCallback($hash);
                    }
                }
                elsif ($hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::extended)
                {
                    my $opened2Down = MMSOMFY::Timing::Opened2Down($hash);
                    my $down2Closed = MMSOMFY::Timing::Down2Closed($hash);
                    
                    # Extended timing positions: 0.0 (opened), 0.95 (down), 1.0 (closed)
                    my $downFactor = 0.95;
                    
                    main::Log3($hash->{NAME}, 4, "MMSOMFY::DeviceModel ($hash->{NAME}): Extended timing close: StartFactor=$Simulation->{StartFactor}, downFactor=$downFactor, opened2Down=$opened2Down, down2Closed=$down2Closed");

                    if ($Simulation->{StartFactor} < $downFactor)
                    {
                        # Phase 1: Move from StartFactor up to 0.95 (down position) using Opened2Down timing
                        # Phase 2: Move from 0.95 to 1.0 (closed) using Down2Closed timing
                        my $timeToDown = $opened2Down;
                        my $totalTime = $opened2Down + $down2Closed;
                        
                        if ($dt < $timeToDown)
                        {
                            # Still in Phase 1: moving toward down position
                            $factor = $Simulation->{StartFactor} + ($dt / $opened2Down) * ($downFactor - $Simulation->{StartFactor});
                        }
                        else
                        {
                            # Phase 2: moving from down toward closed
                            $factor = $downFactor + (($dt - $timeToDown) / $down2Closed) * (1.0 - $downFactor);
                        }
                    }
                    else
                    {
                        # Start >= 0.95: Already at or above down position, move directly to closed (1.0) using Down2Closed timing
                        $factor = $Simulation->{StartFactor} + ($dt / $down2Closed) * (1.0 - $Simulation->{StartFactor});
                    }
                    
                    $factor = 1.0 if ($factor > 0.99);

                    if ($factor eq 1.0 || $cancel > 0)
                    {
                        delete $hash->{SimulationKey};
                        $movement = MMSOMFY::Movement::none;
                    }
                    elsif (defined($hash->{SimulationKey}))
                    {
                        ScheduleNextTimerCallback($hash);
                    }
                }
            }

            MMSOMFY::Reading::PositionUpdate($factor, $movement, $hash);
        }
        };

        # Error handling for timer callback
        if ($@) {
            main::Log3($hash->{NAME}, 1, "ERROR in TimerCallback: $@");
            # Clean up simulation state on error
            delete $hash->{SimulationKey};
            MMSOMFY::Reading::PositionUpdate(
                main::ReadingsVal($hash->{NAME}, MMSOMFY::Reading::factor, 0),
                MMSOMFY::Movement::none,
                $hash
            );
            return;
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
        my $timerStopAfter = undef;

        if
            (
                $cmd eq MMSOMFY::Command::open_for_timer ||
                $cmd eq MMSOMFY::Command::close_for_timer
            )
        {
            $timerStopAfter = $cmdarg;
            $cmd = ($cmd eq MMSOMFY::Command::open_for_timer)
                ? MMSOMFY::Command::open
                : MMSOMFY::Command::close;
            $cmdarg = undef;
        }

        # Validate timing attributes before movement
        unless (MMSOMFY::Timing::ValidateTimingAttributes($main::FHEM_Hash)) {
            main::Log3($main::FHEM_Hash->{NAME}, 1, "Movement cancelled due to timing validation errors");
            return;
        }

        if ($cmd eq MMSOMFY::Command::go_my)
        {
            if ($main::FHEM_Hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::off)
            {
                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Nothing to be done with command '$cmd' with timing '" . MMSOMFY::Timing::off . "'");
                return;
            }

            my $myPosition = main::AttrVal($main::FHEM_Hash->{NAME}, MMSOMFY::Attribute::myPosition, undef);
            unless (defined($myPosition) && $myPosition =~ /^\d*\.?\d+$/)
            {
                main::Log3($main::FHEM_Hash->{NAME}, 1, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Command go_my ignored because attribute myPosition is not set.");
                return;
            }

            my $targetPosition = $myPosition;
            if (main::AttrVal($main::FHEM_Hash->{NAME}, MMSOMFY::Attribute::positionInverse, 0) eq "1")
            {
                $targetPosition = MMSOMFY::Position::ENDPOS() - $targetPosition;
            }

            my $factor = main::ReadingsVal($main::FHEM_Hash->{NAME}, MMSOMFY::Reading::factor, undef);
            unless (defined($factor) && $factor =~ /^\d*\.?\d+$/)
            {
                main::Log3($main::FHEM_Hash->{NAME}, 1, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Command go_my ignored because reading factor is missing.");
                return;
            }

            my $targetFactor = $targetPosition / MMSOMFY::Position::ENDPOS();
            my $delta = $targetFactor - $factor;

            if (abs($delta) < 0.01)
            {
                main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Command go_my ignored because device is already near target position.");
                return;
            }

            if ($delta < 0)
            {
                my $fullTime = MMSOMFY::Timing::Closed2Opened($main::FHEM_Hash);
                unless (defined($fullTime) && $fullTime > 0)
                {
                    main::Log3($main::FHEM_Hash->{NAME}, 1, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Command go_my cannot be executed due to missing timing attributes.");
                    return;
                }

                $timerStopAfter = abs($delta) * $fullTime;
                $cmd = MMSOMFY::Command::open;
            }
            else
            {
                my $fullTime = MMSOMFY::Timing::Opened2Closed($main::FHEM_Hash);
                unless (defined($fullTime) && $fullTime > 0)
                {
                    main::Log3($main::FHEM_Hash->{NAME}, 1, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Command go_my cannot be executed due to missing timing attributes.");
                    return;
                }

                $timerStopAfter = abs($delta) * $fullTime;
                $cmd = MMSOMFY::Command::close;
            }

            $timerStopAfter = sprintf("%.2f", $timerStopAfter);
            main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): go_my -> '$cmd' for ${timerStopAfter}s");
        }

        if ($cmd eq MMSOMFY::Command::open)
        {
            if ($main::FHEM_Hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::off)
            {
                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Set state to ". MMSOMFY::State::opened);
                $main::FHEM_Hash->{STATE} = MMSOMFY::State::opened;
            }
            elsif ($main::FHEM_Hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::basic || $main::FHEM_Hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::extended)
            {
                my $movement = main::ReadingsVal($main::FHEM_Hash->{NAME}, MMSOMFY::Reading::movement, undef);
                my $factor = main::ReadingsVal($main::FHEM_Hash->{NAME}, MMSOMFY::Reading::factor, undef);

                if (defined($timerStopAfter) && defined($main::FHEM_Hash->{SimulationKey}) && $movement eq MMSOMFY::Movement::up)
                {
                    $main::FHEM_Hash->{SimulationKey}{TimerStopTime} = main::gettimeofday() + $timerStopAfter;
                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Updated timer-stop for current up movement to ${timerStopAfter}s");
                    return;
                }

                if ($movement eq MMSOMFY::Movement::up || $factor eq 0.0)
                {
                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Ignore command '$cmd' as device is already going up or is already opened");
                }
                else
                {
                    if (defined($main::FHEM_Hash->{SimulationKey}))
                    {
                        main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Cancel simulation");
                        main::RemoveInternalTimer($main::FHEM_Hash, "MMSOMFY::DeviceModel::TimerCallback");
                        MMSOMFY::DeviceModel::TimerCallback($main::FHEM_Hash, 1);
                    }

                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Start moving up");
                    main::readingsSingleUpdate($main::FHEM_Hash, MMSOMFY::Reading::movement, MMSOMFY::Movement::up, 1);

                    my $startTime = main::gettimeofday();

                    $main::FHEM_Hash->{SimulationKey} = {
                        StartTime => $startTime,
                        StartFactor => $factor,
                        Command => $cmd
                    };

                    $main::FHEM_Hash->{SimulationKey}{Arguments} = $cmdarg if (defined($cmdarg));
                    $main::FHEM_Hash->{SimulationKey}{TimerStopTime} = $startTime + $timerStopAfter if (defined($timerStopAfter));

                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Start timer for moving up");
                    ScheduleNextTimerCallback($main::FHEM_Hash);
                }
            }
        }
        elsif ($cmd eq MMSOMFY::Command::close)
        {
            if ($main::FHEM_Hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::off)
            {
                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Set state to ". MMSOMFY::State::closed);
                $main::FHEM_Hash->{STATE} = MMSOMFY::State::closed;
            }
            elsif ($main::FHEM_Hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::basic || $main::FHEM_Hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::extended)
            {
                my $movement = main::ReadingsVal($main::FHEM_Hash->{NAME}, MMSOMFY::Reading::movement, undef);
                my $factor = main::ReadingsVal($main::FHEM_Hash->{NAME}, MMSOMFY::Reading::factor, undef);

                if (defined($timerStopAfter) && defined($main::FHEM_Hash->{SimulationKey}) && $movement eq MMSOMFY::Movement::down)
                {
                    $main::FHEM_Hash->{SimulationKey}{TimerStopTime} = main::gettimeofday() + $timerStopAfter;
                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Updated timer-stop for current down movement to ${timerStopAfter}s");
                    return;
                }

                if ($movement eq MMSOMFY::Movement::down || $factor eq 1.0)
                {
                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Ignore command '$cmd' as device is already going up or is already opened");
                }
                else
                {
                    if (defined($main::FHEM_Hash->{SimulationKey}))
                    {
                        main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Cancel simulation");
                        main::RemoveInternalTimer($main::FHEM_Hash, "MMSOMFY::DeviceModel::TimerCallback");
                        MMSOMFY::DeviceModel::TimerCallback($main::FHEM_Hash, 1);
                    }

                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Start moving down");
                    main::readingsSingleUpdate($main::FHEM_Hash, MMSOMFY::Reading::movement, MMSOMFY::Movement::down, 1);

                    my $startTime = main::gettimeofday();

                    $main::FHEM_Hash->{SimulationKey} = {
                        StartTime => $startTime,
                        StartFactor => $factor,
                        Command => $cmd
                    };

                    $main::FHEM_Hash->{SimulationKey}{Arguments} = $cmdarg if (defined($cmdarg));
                    $main::FHEM_Hash->{SimulationKey}{TimerStopTime} = $startTime + $timerStopAfter if (defined($timerStopAfter));

                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Start timer for moving down");
                    ScheduleNextTimerCallback($main::FHEM_Hash);
                }
            }
        }
        elsif ($cmd eq MMSOMFY::Command::stop)
        {
            if ($main::FHEM_Hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::off)
            {
                main::Log3($main::FHEM_Hash->{NAME}, 5, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Nothing to be done with command '$cmd' with timing '" . MMSOMFY::Timing::off . "'");
            }
            elsif ($main::FHEM_Hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::basic || $main::FHEM_Hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::extended)
            {
                if (defined($main::FHEM_Hash->{SimulationKey}))
                {
                    main::Log3($main::FHEM_Hash->{NAME}, 3, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Cancel simulation");
                    main::RemoveInternalTimer($main::FHEM_Hash, "MMSOMFY::DeviceModel::TimerCallback");
                    MMSOMFY::DeviceModel::TimerCallback($main::FHEM_Hash, 1);
                }
            }
        }

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Exit 'CalculateAwningShutter'");
    }

    sub Calculate($$$)
    {
        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Enter 'Calculate'");
        my ($mode, $cmd, $cmdarg) = @_;

        # Handle calibration commands.
        # FHEM UI interaction is command-based, therefore confirmation is done with calibrate_next.
        if ($cmd eq MMSOMFY::Command::calibrate) {
            my $timing = $main::FHEM_Hash->{MMSOMFY::Internal::TIMING};
            my $requestedType = ($timing && $timing eq MMSOMFY::Timing::extended) ? 'extended' : 'basic';

            if ($main::FHEM_Hash->{CalibrationMode}) {
                my $activeType = $main::FHEM_Hash->{CalibrationData}{type};
                return (undef, "Calibration '$activeType' is active. Use 'calibrate_next' to continue or 'calibrate_abort' to cancel.");
            }

            my $result = StartInteractiveCalibration($main::FHEM_Hash, $requestedType);
            return (undef, undef) if !defined($result);  # Success
            return (undef, $result);  # Error message
        }
        elsif ($cmd eq MMSOMFY::Command::calibrate_next) {
            return (undef, "No calibration is active. Start with 'calibrate'.")
                unless $main::FHEM_Hash->{CalibrationMode};

            HandleCalibrationInput($main::FHEM_Hash);
            return (undef, undef);
        }
        elsif ($cmd eq MMSOMFY::Command::calibrate_abort) {
            return (undef, "No calibration is active.") unless $main::FHEM_Hash->{CalibrationMode};

            AbortCalibration($main::FHEM_Hash);
            return (undef, undef);
        }
        elsif ($cmd eq MMSOMFY::Command::calibrate_verify) {
            VerifyCalibration($main::FHEM_Hash);
            return (undef, undef);
        }
        elsif ($cmd eq MMSOMFY::Command::calibrate_reset) {
            ResetCalibrationData($main::FHEM_Hash);
            return (undef, undef);
        }

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

        main::Log3($main::FHEM_Hash->{NAME}, 4, "MMSOMFY::DeviceModel ($main::FHEM_Hash->{NAME}): Exit 'Calculate'");
        return ($cmd, $cmdarg);
    }

    sub AbortCalibration($) {
        my ($hash) = @_;

        delete $hash->{CalibrationMode};
        delete $hash->{CalibrationData};

        MMSOMFY::Internal::SetCalibrationValues(
            "aborted",
            "done",
            "Calibration aborted by user",
            MMSOMFY::Command::calibrate,
            $hash->{MMSOMFY::Internal::CALIBRATION_LAST_MEASUREMENT},
            $hash
        );

        main::Log3($hash->{NAME}, 1, "Calibration aborted by user.");
    }

    # Interactive calibration for timing values
    sub StartInteractiveCalibration($$) {
        my ($hash, $calibrationType) = @_;

        # Check if device is in correct state for calibration
        if ($hash->{MMSOMFY::Internal::TIMING} eq MMSOMFY::Timing::off) {
            return "Calibration not possible: Device timing is set to 'off'. Set timing to 'basic' or 'extended' first.";
        }

        # Initialize calibration data
        $hash->{CalibrationMode} = 1;
        $hash->{CalibrationData} = {
            type => $calibrationType,
            step => 0,
            measurements => [],
            startTime => undef,
            waitingForInput => 0,
        };

        main::Log3($hash->{NAME}, 2, "MMSOMFY::DeviceModel ($hash->{NAME}): Starting interactive calibration: $calibrationType");

        # Start first calibration step
        ProcessCalibrationStep($hash);

        return "Calibration started. Follow the instructions in the FHEM log/console.";
    }

    sub ProcessCalibrationStep($) {
        my $hash = shift;
        my $cal = $hash->{CalibrationData};

        if ($cal->{type} eq 'basic') {
            ProcessBasicCalibrationStep($hash);
        } elsif ($cal->{type} eq 'extended') {
            ProcessExtendedCalibrationStep($hash);
        }
    }

    sub ProcessBasicCalibrationStep($) {
        my $hash = shift;
        my $cal = $hash->{CalibrationData};

        my @steps = (
            {
                instruction => "Ensure the shutter is COMPLETELY CLOSED, then press ENTER in the console",
                action => 'prepare_closed'
            },
            {
                instruction => "Movement will start... Press ENTER WHEN the shutter is COMPLETELY OPEN",
                action => 'measure_open'
            },
            {
                instruction => "Movement will start... Press ENTER WHEN the shutter is COMPLETELY CLOSED",
                action => 'measure_close'
            },
            {
                instruction => "Calibration complete. Processing results...",
                action => 'complete'
            }
        );

        if ($cal->{step} >= @steps) {
            CompleteBasicCalibration($hash);
            return;
        }

        my $currentStep = $steps[$cal->{step}];
        my $confirmCmd = MMSOMFY::Command::calibrate_next;

        # Log instruction for user
        main::Log3($hash->{NAME}, 1, "="x60);
        main::Log3($hash->{NAME}, 1, "SHUTTER CALIBRATION - Step " . ($cal->{step} + 1) . "/" . scalar(@steps));
        main::Log3($hash->{NAME}, 1, "="x60);
        main::Log3($hash->{NAME}, 1, $currentStep->{instruction});
        main::Log3($hash->{NAME}, 1, "");

        if ($currentStep->{action} eq 'prepare_closed') {
            # Wait for explicit UI confirmation via repeated set command.
            main::Log3($hash->{NAME}, 1, "Confirm with: set $hash->{NAME} $confirmCmd");
            $cal->{waitingForInput} = 1;
            MMSOMFY::Internal::SetCalibrationValues(
                "waiting",
                ($cal->{step} + 1),
                $currentStep->{instruction},
                $confirmCmd,
                $hash->{MMSOMFY::Internal::CALIBRATION_LAST_MEASUREMENT},
                $hash
            );
        } elsif ($currentStep->{action} eq 'measure_open') {
            # Start movement and wait for UI confirmation.
            main::Log3($hash->{NAME}, 1, "STARTING: Movement from CLOSED to OPEN...");
            $cal->{startTime} = time();
            MMSOMFY::Command::Send2Device(MMSOMFY::Command::open, undef);
            $cal->{waitingForInput} = 1;
            MMSOMFY::Internal::SetCalibrationValues(
                "measuring",
                ($cal->{step} + 1),
                $currentStep->{instruction},
                $confirmCmd,
                $hash->{MMSOMFY::Internal::CALIBRATION_LAST_MEASUREMENT},
                $hash
            );
        } elsif ($currentStep->{action} eq 'measure_close') {
            # Start movement and wait for UI confirmation.
            main::Log3($hash->{NAME}, 1, "STARTING: Movement from OPEN to CLOSED...");
            $cal->{startTime} = time();
            MMSOMFY::Command::Send2Device(MMSOMFY::Command::close, undef);
            $cal->{waitingForInput} = 1;
            MMSOMFY::Internal::SetCalibrationValues(
                "measuring",
                ($cal->{step} + 1),
                $currentStep->{instruction},
                $confirmCmd,
                $hash->{MMSOMFY::Internal::CALIBRATION_LAST_MEASUREMENT},
                $hash
            );
        }
    }

    sub ProcessExtendedCalibrationStep($) {
        my $hash = shift;
        my $cal = $hash->{CalibrationData};

        my @steps = (
            {
                instruction => "Ensure the shutter is COMPLETELY CLOSED, then press ENTER",
                action => 'prepare_closed'
            },
            {
                instruction => "Movement starts... Press ENTER at the DOWN position (95% closed)",
                action => 'measure_to_down'
            },
            {
                instruction => "Movement starts... Press ENTER WHEN fully OPEN",
                action => 'measure_down_to_open'
            },
            {
                instruction => "Movement starts... Press ENTER at the DOWN position (95% closed)",
                action => 'measure_to_down_reverse'
            },
            {
                instruction => "Movement starts... Press ENTER WHEN fully CLOSED",
                action => 'measure_down_to_closed'
            },
            {
                instruction => "Extended calibration complete. Processing results...",
                action => 'complete'
            }
        );

        if ($cal->{step} >= @steps) {
            CompleteExtendedCalibration($hash);
            return;
        }

        my $currentStep = $steps[$cal->{step}];
        my $confirmCmd = MMSOMFY::Command::calibrate_next;

        main::Log3($hash->{NAME}, 1, "="x60);
        main::Log3($hash->{NAME}, 1, "EXTENDED SHUTTER CALIBRATION - Step " . ($cal->{step} + 1) . "/" . scalar(@steps));
        main::Log3($hash->{NAME}, 1, "="x60);
        main::Log3($hash->{NAME}, 1, $currentStep->{instruction});
        main::Log3($hash->{NAME}, 1, "");

        if ($currentStep->{action} eq 'prepare_closed') {
            main::Log3($hash->{NAME}, 1, "Confirm with: set $hash->{NAME} $confirmCmd");
            $cal->{waitingForInput} = 1;
            MMSOMFY::Internal::SetCalibrationValues(
                "waiting",
                ($cal->{step} + 1),
                $currentStep->{instruction},
                $confirmCmd,
                $hash->{MMSOMFY::Internal::CALIBRATION_LAST_MEASUREMENT},
                $hash
            );
        } elsif ($currentStep->{action} eq 'measure_to_down') {
            main::Log3($hash->{NAME}, 1, "STARTING: Movement from CLOSED to OPEN...");
            $cal->{startTime} = time();
            MMSOMFY::Command::Send2Device(MMSOMFY::Command::open, undef);
            $cal->{waitingForInput} = 1;
            MMSOMFY::Internal::SetCalibrationValues(
                "measuring",
                ($cal->{step} + 1),
                $currentStep->{instruction},
                $confirmCmd,
                $hash->{MMSOMFY::Internal::CALIBRATION_LAST_MEASUREMENT},
                $hash
            );
        } elsif ($currentStep->{action} eq 'measure_down_to_open') {
            main::Log3($hash->{NAME}, 1, "STARTING: Movement from DOWN to OPEN...");
            $cal->{startTime} = time();
            MMSOMFY::Command::Send2Device(MMSOMFY::Command::open, undef);
            $cal->{waitingForInput} = 1;
            MMSOMFY::Internal::SetCalibrationValues(
                "measuring",
                ($cal->{step} + 1),
                $currentStep->{instruction},
                $confirmCmd,
                $hash->{MMSOMFY::Internal::CALIBRATION_LAST_MEASUREMENT},
                $hash
            );
        } elsif ($currentStep->{action} eq 'measure_to_down_reverse') {
            main::Log3($hash->{NAME}, 1, "STARTING: Movement from OPEN to CLOSED...");
            $cal->{startTime} = time();
            MMSOMFY::Command::Send2Device(MMSOMFY::Command::close, undef);
            $cal->{waitingForInput} = 1;
            MMSOMFY::Internal::SetCalibrationValues(
                "measuring",
                ($cal->{step} + 1),
                $currentStep->{instruction},
                $confirmCmd,
                $hash->{MMSOMFY::Internal::CALIBRATION_LAST_MEASUREMENT},
                $hash
            );
        } elsif ($currentStep->{action} eq 'measure_down_to_closed') {
            main::Log3($hash->{NAME}, 1, "STARTING: Movement from DOWN to CLOSED...");
            $cal->{startTime} = time();
            MMSOMFY::Command::Send2Device(MMSOMFY::Command::close, undef);
            $cal->{waitingForInput} = 1;
            MMSOMFY::Internal::SetCalibrationValues(
                "measuring",
                ($cal->{step} + 1),
                $currentStep->{instruction},
                $confirmCmd,
                $hash->{MMSOMFY::Internal::CALIBRATION_LAST_MEASUREMENT},
                $hash
            );
        }
    }

    # Handle user input during calibration
    sub HandleCalibrationInput($) {
        my $hash = shift;
        my $cal = $hash->{CalibrationData};

        return unless $cal->{waitingForInput};

        if ($cal->{startTime}) {
            # Record measurement
            my $elapsed = time() - $cal->{startTime};
            push @{$cal->{measurements}}, $elapsed;

            # Stop movement at the user-confirmed point.
            MMSOMFY::Command::Send2Device(MMSOMFY::Command::stop, undef);
            $hash->{MMSOMFY::Internal::CALIBRATION_LAST_MEASUREMENT} = sprintf("%.2f", $elapsed);

            main::Log3($hash->{NAME}, 1, sprintf("Measured time: %.2f seconds", $elapsed));
        }

        $cal->{step}++;
        $cal->{waitingForInput} = 0;
        $cal->{startTime} = undef;

        # Process next step
        ProcessCalibrationStep($hash);
    }

    sub CompleteBasicCalibration($) {
        my $hash = shift;
        my $cal = $hash->{CalibrationData};

        my $openTime = $cal->{measurements}[0];
        my $closeTime = $cal->{measurements}[1];

        # Update attributes
        $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeClosedToOpened} = sprintf("%.1f", $openTime);
        $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeOpenedToClosed} = sprintf("%.1f", $closeTime);

        main::Log3($hash->{NAME}, 1, "="x50);
        main::Log3($hash->{NAME}, 1, "BASIC CALIBRATION COMPLETED");
        main::Log3($hash->{NAME}, 1, "="x50);
        main::Log3($hash->{NAME}, 1, sprintf("driveTimeClosedToOpened: %.1fs", $openTime));
        main::Log3($hash->{NAME}, 1, sprintf("driveTimeOpenedToClosed: %.1fs", $closeTime));
        main::Log3($hash->{NAME}, 1, "Attributes have been updated.");

        # Update calibration metadata
        $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::lastCalibration} = time();
        $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::calibrationQuality} = 'good';

        # Cleanup
        delete $hash->{CalibrationMode};
        delete $hash->{CalibrationData};
        MMSOMFY::Internal::SetCalibrationValues(
            "completed",
            "done",
            "Basic calibration finished",
            MMSOMFY::Command::calibrate,
            $hash->{MMSOMFY::Internal::CALIBRATION_LAST_MEASUREMENT},
            $hash
        );
    }

    sub CompleteExtendedCalibration($) {
        my $hash = shift;
        my $cal = $hash->{CalibrationData};

        my $closedToDown = $cal->{measurements}[0];
        my $downToOpen = $cal->{measurements}[1];
        my $openToDown = $cal->{measurements}[2];
        my $downToClosed = $cal->{measurements}[3];

        # Calculate derived timings
        my $closedToOpen = $closedToDown + $downToOpen;
        my $openToClosed = $openToDown + $downToClosed;

        # Update attributes
        $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeDownToOpened} = sprintf("%.1f", $downToOpen);
        $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeOpenedToDown} = sprintf("%.1f", $openToDown);
        $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeClosedToOpened} = sprintf("%.1f", $closedToOpen);
        $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeOpenedToClosed} = sprintf("%.1f", $openToClosed);

        main::Log3($hash->{NAME}, 1, "="x50);
        main::Log3($hash->{NAME}, 1, "EXTENDED CALIBRATION COMPLETED");
        main::Log3($hash->{NAME}, 1, "="x50);
        main::Log3($hash->{NAME}, 1, sprintf("driveTimeClosedToDown: %.1fs (measured, but derived)", $closedToDown));
        main::Log3($hash->{NAME}, 1, sprintf("driveTimeDownToOpened: %.1fs (measured)", $downToOpen));
        main::Log3($hash->{NAME}, 1, sprintf("driveTimeOpenedToDown: %.1fs (measured)", $openToDown));
        main::Log3($hash->{NAME}, 1, sprintf("driveTimeDownToClosed: %.1fs (measured, but derived)", $downToClosed));
        main::Log3($hash->{NAME}, 1, sprintf("driveTimeClosedToOpened: %.1fs (calculated)", $closedToOpen));
        main::Log3($hash->{NAME}, 1, sprintf("driveTimeOpenedToClosed: %.1fs (calculated)", $openToClosed));
        main::Log3($hash->{NAME}, 1, "All attributes have been updated.");

        # Update calibration metadata
        $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::lastCalibration} = time();
        $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::calibrationQuality} = 'good';

        # Cleanup
        delete $hash->{CalibrationMode};
        delete $hash->{CalibrationData};
        MMSOMFY::Internal::SetCalibrationValues(
            "completed",
            "done",
            "Extended calibration finished",
            MMSOMFY::Command::calibrate,
            $hash->{MMSOMFY::Internal::CALIBRATION_LAST_MEASUREMENT},
            $hash
        );
    }

    sub VerifyCalibration($) {
        my $hash = shift;

        main::Log3($hash->{NAME}, 1, "="x50);
        main::Log3($hash->{NAME}, 1, "CALIBRATION VERIFICATION");
        main::Log3($hash->{NAME}, 1, "="x50);

        main::Log3($hash->{NAME}, 1, "Performing test movements to verify calibration accuracy...");
        main::Log3($hash->{NAME}, 1, "Check the FHEM log for detailed instructions.");

        # Simple verification by attempting a short movement
        # In a real implementation, this would guide the user through verification steps
        main::Log3($hash->{NAME}, 1, "Verification not yet fully implemented. Check timing attributes manually.");
    }

    sub ResetCalibrationData($) {
        my $hash = shift;

        delete $hash->{CalibrationMode};
        delete $hash->{CalibrationData};

        # Reset calibration attributes
        delete $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::calibrationMode};
        delete $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::calibrationQuality};
        delete $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::lastCalibration};
        delete $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::calibrationHistory};

        # Reset timing attributes to defaults
        delete $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeClosedToOpened};
        delete $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeOpenedToClosed};
        delete $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeDownToOpened};
        delete $main::attr{$hash->{NAME}}{MMSOMFY::Attribute::driveTimeOpenedToDown};

        MMSOMFY::Internal::ClearCalibrationValues($hash);

        main::Log3($hash->{NAME}, 1, "Calibration data and timing attributes have been reset.");
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
our (%defs, %attr, %modules, $init_done, $readingFnAttributes);

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
    # $cmd can be "del" or "set"
    # $name is device name
    # aName and aVal are Attribute name and value
    my ($cmd,$name,$aName,$aVal) = @_;
    $FHEM_Hash = $defs{$name};

    return "\"MMSOMFY Attr: \" $name does not exist" if (!defined($FHEM_Hash));
    Log3($FHEM_Hash->{NAME}, 4, "MMSOMFY_Attr ($FHEM_Hash->{NAME} / $aName): Enter");
    Log3($FHEM_Hash->{NAME}, 5, "MMSOMFY_Attr ($FHEM_Hash->{NAME}): $cmd $aName ($aVal)") if (defined($aVal));
    Log3($FHEM_Hash->{NAME}, 5, "MMSOMFY_Attr ($FHEM_Hash->{NAME}): $cmd $aName") if (!defined($aVal));
    
    my $retval = undef;

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
1;


=pod
=item summary    supporting devices using the SOMFY RTS protocol - window shades, shutters, remote controls and switches
=item summary_DE für Geräte, die das SOMFY RTS protocol unterstützen - Rolläden, Rolladen, Fernbedienungen und Schalter
=begin html

<a name="MMSOMFY"></a>
<h3>MMSOMFY - Somfy RTS / Simu Hz protocol implementation</h3>
<ul>
  The Somfy RTS (identical to Simu Hz) protocol is used by a wide range of devices such as awnings,
  roller shutters, blinds and wall switches. This module supports SENDING commands to Somfy RTS devices 
  through a <a href="#CUL">CUL</a> device (which must be defined first and set as IODev).
  <br><br>
  
  The module provides position tracking for movable devices (awnings, shutters) with optional timing-based 
  position calculation. Multiple devices can be controlled independently, each with a unique address.
  <br><br>
  
  <b>Note:</b> This module is still under development. Not all features may be fully implemented.
  <br><br>

  <a name="MMSOMFYdefine"></a>
  <b>Define</b>
  <ul>
    <code>define &lt;name&gt; MMSOMFY &lt;address&gt; &lt;model&gt; [&lt;encryption-key&gt;] [&lt;rolling-code&gt;]</code>
    <br><br>

   The address is a unique 6-digit hexadecimal code that identifies this device as a remote control channel 
   for pairing with Somfy RTS receivers.
   <br>
   <b>Pairing Process:</b> Set the receiver in programming mode (usually by pressing the program button 
   on an existing remote or disconnecting/reconnecting power), then send the "prog" command from FHEM. 
   The receiver will acknowledge with a brief movement.
   <br><br>

   <ul>
   <li><code>&lt;address&gt;</code>: A 6-digit hexadecimal number (0-9, A-F) that uniquely identifies 
   this FHEM device as a remote control channel. Use different addresses for each device definition. 
   Example: <code>000001</code>, <code>42ABCD</code>
   </li><br>

   <li><code>&lt;model&gt;</code>: The device model type. Valid values are:
   <ul>
     <li><code>awning</code> - WindowShade, Markise, Rollladen with up/down movement</li>
     <li><code>shutter</code> - Roller shutter with extended timing (0=open, 95=down position where slats meet frame, 100=closed)</li>
     <li><code>switch</code> - Simple switch supporting on/off commands</li>
     <li><code>remote</code> - Remote control (receiver only, no sending)</li>
   </ul>
   </li><br>

   <li><code>&lt;encryption-key&gt;</code> (optional): A 2-digit hexadecimal encryption key used for 
   cloning an existing remote control. The first character is typically 'A'. If specified, you must also 
   provide a matching <code>&lt;rolling-code&gt;</code> and <code>&lt;address&gt;</code> from the original remote.
   </li><br>

   <li><code>&lt;rolling-code&gt;</code> (optional): A 4-digit hexadecimal rolling code counter for synchronization 
   with the receiver. Used when cloning existing remotes. Both encryption key and rolling code will be 
   automatically updated after each command sent to the device (RTS protocol behavior).
   </li><br>
   </ul>
   <br>

   <b>Examples:</b>
   <ul>
      <code>define myAwning MMSOMFY 000001 awning</code><br>
      <code>define myShutter MMSOMFY 000002 shutter</code><br>
      <code>define mySwitch MMSOMFY 000003 switch</code><br>
      <code>define clonedRemote MMSOMFY 42ABCD awning A5 0A1C</code><br>
   </ul>
  </ul>
  <br>

  <a name="MMSOMFYset"></a>
  <b>Set</b>
  <ul>
    <code>set &lt;name&gt; &lt;command&gt; [&lt;parameter&gt;]</code>
    <br><br>
    
    <b>Common Commands (all models):</b><br>
    <pre>
    stop              Stop the current movement
    prog              Pair/unpair the device with the receiver
    </pre>
    
    <b>Awning / Shutter Commands:</b><br>
    <pre>
    open              Move fully upward (position 0)
    close             Move fully downward (position 100 or 200)
    go_my             Move to the "My" position (user-defined favorite)
    position &lt;0-100&gt; Move to a specific position (requires timing attributes)
    manual &lt;value&gt;   Set position without sending RF command (for position correction)
    close_for_timer   Close (down) with automatic stop after timing period
    open_for_timer    Open (up) with automatic stop after timing period
    </pre>

    <b>Switch Commands:</b><br>
    <pre>
    on                Activate switch (moves fully down)
    off               Deactivate switch (moves fully up)
    </pre>

    <b>Remote / Special Commands:</b><br>
    <pre>
    wind_sun_9        Send wind/sun detector code (sun + flag)
    wind_only_a       Send wind-only detector code (flag only)
    z_custom          Send custom RF code (advanced usage)
    calibrate         Start interactive calibration (basic/extended depends on timing)
    calibrate_next    Confirm the next interactive calibration step
    calibrate_abort   Abort the active interactive calibration
    calibrate_verify  Verify calibration accuracy with test movements
    calibrate_reset   Reset all calibration data and timing attributes
    </pre>

    <b>Calibration mode selection:</b> If timing is <code>extended</code>, extended calibration
    is used automatically; otherwise basic calibration is used.
    <br><br>

    During interactive calibration in FHEMWEB, confirm each step with
    <code>set &lt;name&gt; calibrate_next</code>. Cancel with
    <code>set &lt;name&gt; calibrate_abort</code>. Progress is exposed via calibration*
    internals on the device detail page.

    <b>SetExtensions (if eventMap/webCmd configured):</b><br>
    <pre>
    on-for-timer &lt;seconds&gt;   Switch on with automatic off after delay
    off-for-timer &lt;seconds&gt;  Switch off with automatic on after delay
    on-till &lt;HH:MM:SS&gt;       Switch on until specified time
    off-till &lt;HH:MM:SS&gt;      Switch off until specified time
    toggle                    Toggle between on and off states
    </pre>

    <b>Examples:</b>
    <ul>
      <code>set myAwning open</code><br>
      <code>set myAwning close</code><br>
      <code>set myAwning position 50</code><br>
      <code>set myAwning stop</code><br>
      <code>set myAwning prog</code> (for pairing)<br>
      <code>set mySwitch on</code><br>
      <code>set myAwning,myShutter open</code> (multiple devices)<br>
    </ul>
    <br>
    <b>Position-based Commands Notes:</b>
    <ul>
      <li>Position commands (0..100) require the timing attributes to be set. 
      The device calculates movement duration based on configured drive times.</li>
      <li>The <code>manual</code> command updates the position reading without sending 
      RF signals - useful for position correction after manual operations.</li>
      <li><code>close_for_timer</code> and <code>open_for_timer</code> stop movement after a 
      specified duration instead of reaching a target position.</li>
      <li>For extended position range (shutter model): 0=open, 100=down position, 200=completely closed</li>
      <li>Position values are rounded to nearest 5% increment.</li>
    </ul>

  </ul>
  <br>

  <b>Get</b>
  <ul>
    Currently no Get commands are supported. Device state and position are provided as readings.
  </ul>
  <br>

  <a name="MMSOMFYattr"></a>
  <b>Attributes</b>
  <ul>
    <li><b>IODev</b><br>
        Specifies the physical IO device (e.g., a <a href="#CUL">CUL</a> device) through which 
        RF commands are transmitted. <b>REQUIRED:</b> The IODev must be defined and set, 
        otherwise no commands will be sent to the Somfy device!<br>
        If available, use CUL433 for better range with 433 MHz devices.
        <br><br>
    </li>

    <li><b>driveTimeOpenedToDown</b> (seconds, e.g. "12" or "12.5")<br>
        Time in seconds the shutter needs to move from fully open (position 0) down to 
        the "down" position (position 100). For a typical window, this is about 12-15 seconds.
        At least this attribute must be set to enable position tracking.
        <br><br>
    </li>

    <li><b>driveTimeOpenedToClosed</b> (seconds)<br>
        Time in seconds to move from fully open (position 0) to completely closed (position 200).
        This value must be greater than <code>driveTimeOpenedToDown</code>.
        Typically 3-5 seconds more than the down time. Only used for extended position models (shutter).
        <br><br>
    </li>

    <li><b>driveTimeDownToOpened</b> (seconds)<br>
        Time in seconds to move from the "down" position (position 100) all the way up to 
        fully open (position 0). Usually 10-20 seconds. Only used for extended position models (shutter).
        This value must be less than <code>driveTimeClosedToOpened</code>.
        <br><br>
    </li>

    <li><b>driveTimeClosedToOpened</b> (seconds)<br>
        Time in seconds to move from completely closed (position 200) all the way up to 
        fully open (position 0). This value must be greater than <code>driveTimeDownToOpened</code>.
        Typically slightly higher than <code>driveTimeOpenedToClosed</code> due to device weight.
        <br><br>
    </li>

    <li><b>myPosition</b> (0..100)<br>
        The target position for the "go_my" (favorite/memory) command. 
        When the device receives a "go_my" command, it will move to this position.
        Default is typically 95 (partially closed).
        <br><br>
    </li>

    <li><b>symbolLength</b> (microseconds, default: 1240)<br>
        The RF symbol width in microseconds for the Somfy RTS protocol transmission.
        Should not normally be changed unless working with non-standard hardware.
        <br><br>
    </li>

    <li><b>repetition</b> (0..255, default: 6)<br>
        Number of times each RF command is repeated in the transmission. 
        Higher values improve reception reliability for distant devices but increase 
        transmission time. Standard Somfy devices expect value 6.
        <br><br>
    </li>

    <li><b>fixedEnckey</b> (0 or 1, default: 0)<br>
        When set to 1, the encryption key does not change after each command.
        Set to 0 (default) for standard RTS protocol behavior where the encryption key 
        is updated with each transmission for security.
        <br><br>
    </li>

    <li><b>ignore</b> (0 or 1)<br>
        Ignore this device. It will not trigger FileLogs or notifications, and issued 
        commands will be silently discarded without sending RF signals.
        <br><br>
    </li>

    <li><b>disable</b> (0 or 1)<br>
        Disable this device without deleting it. The device won't respond to commands.
        <br><br>
    </li>

    <li><b>calibrationMode</b> (off/basic/extended, default: off)<br>
        Controls automatic calibration behavior. When set to 'basic' or 'extended', 
        the device will periodically suggest recalibration if timing accuracy degrades.
        <br><br>
    </li>

    <li><b>calibrationQuality</b> (unknown/poor/acceptable/good/excellent)<br>
        Indicates the estimated accuracy of the current timing calibration.
        Updated automatically after calibration or verification.
        <br><br>
    </li>

    <li><b>lastCalibration</b> (Unix timestamp)<br>
        Timestamp of the last successful calibration. Used to determine when 
        recalibration might be needed.
        <br><br>
    </li>

    <li><b>calibrationHistory</b> (JSON)<br>
        Stores historical calibration data for trend analysis and drift detection.
        Advanced users can analyze calibration stability over time.
        <br><br>
    </li>

    <li><b>eventMap</b><br>
        Replace set command names and reading values. Format: space-separated list of 
        <code>old:new</code> pairs. Alternative separators (use first character of value):
        <ul>
          <code>attr myAwning eventMap open:up closed:down</code><br>
          <code>attr myAwning eventMap /on_for_timer 10:openWindow/off:closeWindow/</code>
        </ul>
        This allows custom command names or integration with web interfaces.
        <br><br>
    </li>

    <li><b>webCmd</b><br>
        Comma-separated list of commands to display as buttons in web interface.
        Example: <code>attr myAwning webCmd open,stop,close</code>
        <br><br>
    </li>

    <li><b>stateFormat</b><br>
        Control how the STATE reading is displayed. Default shows position and state.
        Example: <code>attr myAwning stateFormat position</code>
        <br><br>
    </li>

    <li><b>devStateIcon</b><br>
        Define custom state icons for web interface display.
        Example: <code>attr myAwning devStateIcon opened:.*@:off closed:.*@:on</code>
        <br><br>
    </li>

    <li><b>rawDevice</b><br>
        For advanced users: define the raw RF device used for receiving/monitoring.
        <br><br>
    </li>

    <li><a href="#loglevel">loglevel</a><br>
        Set logging level (0-5). Higher values produce more detailed log output for debugging.
        <br><br>
    </li>

  </ul>
  <br>

  <a name="MMSOMFYreadings"></a>
  <b>Readings</b><br>
  <ul>
    The module maintains the following readings:
    <ul>
      <li><b>state</b> - Current state: "open", "closed", "stopped", or position value (0-100)</li>
      <li><b>position</b> - Numeric position value (0=open, 95=down position, 100=closed for shutters)</li>
      <li><b>moving</b> - Current movement direction: "none", "up", or "down"</li>
      <li><b>lastCommand</b> - Last command sent to the device</li>
      <li><b>rollingCode</b> - Current RTS rolling code counter</li>
    </ul>
  </ul>
  <br>

  <a name="MMSOMFYnotes"></a>
  <b>Implementation Notes</b><br>
  <ul>
    <li><b>Position Calculation:</b> Position is calculated based on elapsed time and configured drive times.
    For accurate position tracking, drive time attributes must be set correctly for each device.</li>
    
    <li><b>Timing Modes:</b>
      <ul>
        <li><b>No timing attributes:</b> Only generic states (open, closed, moving) are used</li>
        <li><b>Basic timing:</b> Position tracking between 0-100 (simple awning)</li>
        <li><b>Extended timing:</b> Position range 0-100 with down position at 95 (roller shutter - slats rest on frame but still open)</li>
      </ul>
    </li>
    
    <li><b>Rolling Code &amp; Encryption:</b> The RTS protocol uses a rolling code counter 
    and encryption key that are automatically updated with each transmission for security. 
    These values are stored in the device definition and automatically synchronized.</li>
    
    <li><b>Pairing:</b> New devices must be paired with receivers using the "prog" command.
    Each FHEM device gets its own unique remote control address.</li>
    
    <li><b>Multiple Devices:</b> You can control multiple Somfy devices independently by 
    creating separate MMSOMFY device definitions with different addresses.</li>

        <li><b>Migration from original SOMFY module:</b> The original attributes
        <code>positionInverse</code> and <code>additionalPosReading</code> are intentionally not
        implemented in MMSOMFY. Both are display/derived-reading concerns and can be
        implemented by users with <code>userReadings</code> without hardwiring these variants
        into the module itself.</li>

        <li><b>Replacement examples with userReadings:</b><br>
            Inverse position display (replacement for <code>positionInverse</code>):<br>
            <code>attr &lt;name&gt; userReadings position_inverted:position.* { 100-ReadingsNum($name,"position",0) }</code><br>
            Additional/custom position reading (replacement for <code>additionalPosReading</code>):<br>
            <code>attr &lt;name&gt; userReadings position_custom:position.* { sprintf("%.0f", ReadingsNum($name,"position",0)) }</code><br>
            See <a href="#userReadings">userReadings</a> in commandref for trigger syntax and
            more advanced formulas.</li>
    
    <li><b>Still in Development:</b> This module is actively being developed. Some features 
    may be incomplete or subject to change.</li>
  </ul>

</ul>

=end html
=cut

