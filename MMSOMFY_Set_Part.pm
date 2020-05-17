        if(0)
        {
            # Get current position, if available this is the exact one.
            # This value is used for calculations.
            my $exact = MMSOMFY::Position::Current;

            # Get position adjusted to stepwidth.
            # Comparison is done with this value, as it gives a range for comparison according to stepwidth.
            my $pos = MMSOMFY::Position::RoundValue2Step($exact);

            # Write log message for command to be executed at current position.
            my $logmessage = "MMSOMFY_set ($name): Handling with mode: $mode / cmd: $cmd";
            if (defined($cmdarg))
            {
                $logmessage = $logmessage . " /  cmdarg: $cmdarg";
            }
            $logmessage = $logmessage . " /  pos: $pos / exact: $exact";
            Log3($name, 3, $logmessage);

            # initialize locals
            my $driveTime = 0; # timings until halt command to be sent for close/open_for_timer and pos <value> -> move by time
            my $updateTime = 0; # timings until halt command to be sent for close/open_for_timer and pos <value> -> move by time
            my $move = MMSOMFY::Movement::none;
            my $newState;
            my $updateState;

            # check timer running - stop timer if running and update detail pos
            # recognize timer running if internal updateState is still set
            if (defined($FHEM_Hash->{updateState}))
            {
                # timer is running so timer needs to be stopped and pos needs update
                RemoveInternalTimer($FHEM_Hash);

                $exact = _MMSOMFY_CalcCurrentPos($FHEM_Hash->{MOVE}, $exact, _MMSOMFY_UpdateStartTime());
                delete $FHEM_Hash->{starttime};
                delete $FHEM_Hash->{updateState};
                delete $FHEM_Hash->{runningtime};
                delete $FHEM_Hash->{runningcmd};
            }

            ################ No error returns after this point to avoid stopped timer causing confusion...

            if($cmd eq MMSOMFY::Command::close)
            {
                # if there are no timings set ...
                if($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::off)
                {
                    Log3($name, 4, "MMSOMFY_set ($name): Move without timings.");

                    # ... use end positions for state ...
                    $newState = MMSOMFY::State::closed;

                    # ... start closing ...
                    $move = MMSOMFY::Movement::close;
                }
                # ... otherwise there are timings ...
                else
                {
                    # ... get all relevant positions and ranges ...
                    my $posOpened = MMSOMFY::Position::FromState(MMSOMFY::State::opened);
                    my $posDown = MMSOMFY::Position::FromState(MMSOMFY::State::down);
                    my $posClosed = MMSOMFY::Position::FromState(MMSOMFY::State::closed);
                    my $rOpenedDown = MMSOMFY::Position::diffPosition($posOpened, $posDown);
                    my $rDownClosed = MMSOMFY::Position::diffPosition($posDown, $posClosed);
                    my $rOpenedClosed = MMSOMFY::Position::diffPosition($posOpened, $posClosed);
                
                    # ... if closed state is reached ...
                    if ($pos == MMSOMFY::Position::FromState(MMSOMFY::State::closed))
                    {
                        # ... nothing todo.
                        Log3($name, 4, "MMSOMFY_set ($name): Position closed already achieved. No move.");
                    }
                    # ... otherwise move is needed ...
                    else
                    {
                        # ... start closing ...
                        $move = MMSOMFY::Movement::close;

                        # ... the state to be achieved is closed ...
                        $updateState = MMSOMFY::State::closed;

                        # ... if basic timings are set ...
                        if ($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::basic)
                        {
                            Log3($name, 4, "MMSOMFY_set ($name): Move with basic timings.");
                            
                            # ... get remaining distance from current position to closed position ...
                            my $rRemainToClosed = MMSOMFY::Position::diffPosition($exact, $posClosed);

                            # ... and calculate the remaining time to closed state.
                            $driveTime = MMSOMFY::Timing::Opened2Closed() * ($rRemainToClosed / $rOpenedClosed);
                        }
                        # ... if extended timings are set ...
                        elsif ($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::extended)
                        {
                            Log3($name, 4, "MMSOMFY_set ($name): Move with extended timings.");

                            # ... if current position is between down and closed ...
                            if (MMSOMFY::Position::IsPosBetween($exact, MMSOMFY::State::down, MMSOMFY::State::closed))
                            {
                                Log3($name, 4, "MMSOMFY_set ($name): Position is between down and closed.");

                                # ... get remaining distance from current position to closed position ...
                                my $rRemainToClosed = MMSOMFY::Position::diffPosition($exact, $posClosed);
                                
                                # ... and calculate the remaining time to closed state.
                                $driveTime = MMSOMFY::Timing::Down2Closed() * ($rRemainToClosed / $rDownClosed);
                            }

                            # ... else current position is between opened and down ...
                            else
                            {
                                Log3($name, 4, "MMSOMFY_set ($name): Position is between opened and down.");

                                # ... get remaining distance from current position to down position ...
                                my $rRemainToDown = MMSOMFY::Position::diffPosition($exact, $posDown);
                                
                                # ... and calculate the remaining time to closed state.
                                $driveTime = MMSOMFY::Timing::Opened2Down() * ($rRemainToDown / $rOpenedDown) + MMSOMFY::Timing::Down2Closed;
                            }
                        }
                    }
                }
            }
            elsif($cmd eq MMSOMFY::Command::open)
            {
                #if there are no timings set ...
                if($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::off)
                {
                    Log3($name, 4, "MMSOMFY_set ($name): Move without timings.");

                    # ... use end positions for state.
                    $newState = MMSOMFY::State::opened;
                }
                # ... otherwise there are timings ...
                else
                {
                    # ... get all relevant positions and ranges ...
                    my $posOpened = MMSOMFY::Position::FromState(MMSOMFY::State::opened);
                    my $posDown = MMSOMFY::Position::FromState(MMSOMFY::State::down);
                    my $posClosed = MMSOMFY::Position::FromState(MMSOMFY::State::closed);
                    my $rClosedDown = MMSOMFY::Position::diffPosition($posClosed, $posDown);
                    my $rDownOpened = MMSOMFY::Position::diffPosition($posDown, $posOpened);
                    my $rClosedOpened = MMSOMFY::Position::diffPosition($posClosed, $posOpened);
                
                    # ... if opened state is reached ...
                    if ($pos == MMSOMFY::Position::FromState(MMSOMFY::State::opened))
                    {
                        Log3($name, 4, "MMSOMFY_set ($name): Position opened already achieved. No move.");
                    }
                    # ... otherwise move is needed ...
                    else
                    {
                        # ... start opening ...
                        $move = MMSOMFY::Movement::open;

                        # ... the state to be achieved is opened ...
                        $updateState = MMSOMFY::State::opened;

                        # ... if basic timings are set ...
                        if ($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::basic)
                        {
                            Log3($name, 4, "MMSOMFY_set ($name): Move with basic timings.");
                            
                            # ... get remaining distance from current position to closed position ...
                            my $rRemainToOpened = MMSOMFY::Position::diffPosition($exact, $posOpened);

                            # ... and calculate the remaining time to opened state.
                            $driveTime = MMSOMFY::Timing::Closed2Opened() * ($rRemainToOpened / $rClosedOpened);
                        }
                        # ... if extended timings are set ...
                        elsif ($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::extended)
                        {
                            Log3($name, 4, "MMSOMFY_set ($name): Move with extended timings.");

                            # ... if current position is between down and opened ...
                            if (MMSOMFY::Position::IsPosBetween($exact, MMSOMFY::State::down, MMSOMFY::State::opened))
                            {
                                Log3($name, 4, "MMSOMFY_set ($name): Position is between down and opened.");

                                # ... get remaining distance from current position to opened position ...
                                my $rRemainToOpened = MMSOMFY::Position::diffPosition($exact, $posOpened);
                                
                                # ... and calculate the remaining time to closed state.
                                $driveTime = MMSOMFY::Timing::Down2Opened() * ($rRemainToOpened / $rDownOpened);
                            }

                            # ... else current position is between closed and down ...
                            else
                            {
                                Log3($name, 4, "MMSOMFY_set ($name): Position is between closed and down.");

                                # ... get remaining distance from current position to down position ...
                                my $rRemainToDown = MMSOMFY::Position::diffPosition($exact, $posDown);
                                
                                # ... and calculate the remaining time to closed state.
                                $driveTime = MMSOMFY::Timing::Closed2Down() * ($rRemainToDown / $rClosedDown) + MMSOMFY::Timing::Down2Opened;
                            }
                        }
                    }
                }
            }
            elsif($cmd eq MMSOMFY::Command::position)
            {
                #if there are no timings set ...
                if($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::off)
                {
                    # ... ignore command.
                    Log3($name, 1, "MMSOMFY_set ($name): Move to position without timings is not possible.");
                    
                    # JM: Anything todo? $newState = $FHEM_Hash->{STATE};
                }
                # ... otherwise there are timings ...
                else
                {
                    # ... get all relevant positions and ranges ...
                    my $posOpened = MMSOMFY::Position::FromState(MMSOMFY::State::opened);
                    my $posDown = MMSOMFY::Position::FromState(MMSOMFY::State::down);
                    my $posClosed = MMSOMFY::Position::FromState(MMSOMFY::State::closed);
                    my $rClosedOpened = MMSOMFY::Position::diffPosition($posClosed, $posOpened);
                    my $rClosedDown = MMSOMFY::Position::diffPosition($posClosed, $posDown);
                    my $rDownOpened = MMSOMFY::Position::diffPosition($posDown, $posOpened);
                    my $rCurrent2Pos = MMSOMFY::Position::diffPosition($exact, $cmdarg);
                    my $rCurrent2Down = MMSOMFY::Position::diffPosition($exact, $posDown);
                    my $rDown2Pos = MMSOMFY::Position::diffPosition($posDown, $cmdarg);
                
                    # ... if triggered position is reached nothing todo ...
                    if ($pos == $cmdarg)
                    {
                        Log3($name, 4, "MMSOMFY_set ($name): Position $cmdarg already achieved. No move.");
                    }
                    # ... otherwise move is needed ...
                    else
                    {
                        # ... the state to be achieved is triggered position ...
                        $updateState = $cmdarg;

                        # ... if basic timings are set ...
                        if ($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::basic)
                        {
                            Log3($name, 4, "MMSOMFY_set ($name): Move with basic timings.");
                            
                            # if triggered position is between state opened and the current position ...
                            if (MMSOMFY::Position::IsPosBetween($cmdarg, MMSOMFY::State::opened, MMSOMFY::State::current))
                            {
                                # ... movement must be direction open ...
                                $move = MMSOMFY::Movement::open;
                                
                                # ... state is opening ...
                                $newState = MMSOMFY::State::opening;
                                
                                # ... and the remaining time calculated with opening timing.
                                $driveTime = MMSOMFY::Timing::Closed2Opened() * ($rCurrent2Pos / $rClosedOpened);
                            }
                            # ... else the triggered position is between state closed and the current position ...
                            else
                            {
                                # ... movement must be direction close ...
                                $move = MMSOMFY::Movement::close;
                                
                                # ... state is closing ...
                                $newState = MMSOMFY::State::closing;

                                # ... and the remaining time calculated with closing timing.
                                $driveTime = MMSOMFY::Timing::Opened2Closed() * ($rCurrent2Pos / $rClosedOpened);
                            }
                        }
                        # ... if extended timings are set ...
                        elsif ($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::extended)
                        {
                            Log3($name, 4, "MMSOMFY_set ($name): Move with extended timings.");
                            
                            my $breachDownBarrier = 0;

                            # ... if movement from current position to triggered position breaches down barrier ...
                            if
                                (
                                    # ... current position is between down and closed, but triggered position is between down and opened ...
                                    ( 
                                        MMSOMFY::Position::IsPosBetween($exact, MMSOMFY::State::down, MMSOMFY::State::opened) &&
                                        !MMSOMFY::Position::IsPosBetween($cmdarg, MMSOMFY::State::down, MMSOMFY::State::opened)
                                    ) ||
                                    # ... or the other way round ... 
                                    (
                                        MMSOMFY::Position::IsPosBetween($exact, MMSOMFY::State::down, MMSOMFY::State::closed) &&
                                        !MMSOMFY::Position::IsPosBetween($cmdarg, MMSOMFY::State::down, MMSOMFY::State::closed)
                                    )
                                )
                            {
                                # ... remember down barrier breach for calculation ...
                                $breachDownBarrier = 1;
                            }

                            # if triggered position is between state opened and the current position ...
                            if (MMSOMFY::Position::IsPosBetween($cmdarg, MMSOMFY::State::opened, MMSOMFY::State::current))
                            {
                                # ... movement must be direction open ...
                                $move = MMSOMFY::Movement::open;
                                
                                # ... state is opening ...
                                $newState = MMSOMFY::State::opening;
                                
                                # ... if down barrier is breached during move ...
                                if ($breachDownBarrier)
                                {
                                    # ... get remaining distance from current position to triggered position.
                                    # Therefore use time from current position to down and from down to triggered position ...
                                    $driveTime = MMSOMFY::Timing::Closed2Down() * ($rCurrent2Down / $rClosedDown) + MMSOMFY::Timing::Down2Open() * ($rDown2Pos / $rDownOpened);
                                }
                                # ... otherwise move is only in one timing section ...
                                else
                                {
                                    # ... we need decision which timing to use, so if position is between down and opened ...
                                    if (MMSOMFY::Position::IsPosBetween($exact, MMSOMFY::State::down, MMSOMFY::State::opened))
                                    {
                                        # ... the remaining time is calculated with down2opened timing only.
                                        $driveTime = MMSOMFY::Timing::Down2Opened() * ($rCurrent2Pos / $rDownOpened);
                                    }
                                    # ... otherwise position is between closed and down ...
                                    else
                                    {
                                        # ... the remaining time is calculated with closed2down timing only.
                                        $driveTime = MMSOMFY::Timing::Closed2Down() * ($rCurrent2Pos / $rClosedDown);
                                    }
                                }
                            }
                            # ... else the triggered position is between state closed and the current position ...
                            else
                            {
                                # ... movement must be direction close ...
                                $move = MMSOMFY::Movement::close;

                                # ... state is closing ...
                                $newState = MMSOMFY::State::closing;
                                
                                # ... if down barrier is breached during move ...
                                if ($breachDownBarrier)
                                {
                                    # ... get remaining distance from current position to triggered position.
                                    # Therefore use time from current position to down and from down to triggered position ...
                                    $driveTime = MMSOMFY::Timing::Opened2Down() * ($rCurrent2Down / $rClosedDown) + MMSOMFY::Timing::Down2Closed() * ($rDown2Pos / $rClosedDown);
                                }
                                # ... otherwise move is only in one timing section ...
                                else
                                {
                                    # ... we need decision which timing to use, so if position is between opened and down ...
                                    if (MMSOMFY::Position::IsPosBetween($exact, MMSOMFY::State::opened, MMSOMFY::State::down))
                                    {
                                        # ... the remaining time is calculated with opened2down timing only.
                                        $driveTime = MMSOMFY::Timing::Opened2Down() * ($rCurrent2Pos / $rDownOpened);
                                    }
                                    # ... otherwise position is down and closed ...
                                    else
                                    {
                                        # ... the remaining time is calculated with down2closed timing only.
                                        $driveTime = MMSOMFY::Timing::Down2Closed() * ($rCurrent2Pos / $rClosedDown);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            elsif ($cmd eq MMSOMFY::Command::close_for_timer)
            {
                # ... if given travel time is 0 or less ...
                if ($cmdarg <= 0)
                {
                    # ... ignore the command ...
                    Log3($name, 4, "MMSOMFY_set ($name): Close for timer with time 0 is ignored.");
                }
                else
                {
                    # if there are no timings set ...
                    if($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::off)
                    {
                        # ... start opening and set drivetime to given travel time ...
                        $move = MMSOMFY::Movement::open;
                        $driveTime = $cmdarg;

                        # ... state to be reached is not detectable due to missing timings, therefore it is current.
                        $updateState = MMSOMFY::State::current;
                    }
                    # ... otherwise there are timings ...
                    else
                    {
                        # ... if basic timings are set ...
                        if ($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::basic)
                        {
                            my $range = MMSOMFY::Position::dPosForTime(MMSOMFY::Position::RANGE, MMSOMFY::Timing::Closed2Opened, $cmdarg);
                            $updateState = MMSOMFY::Position::RoundValue2Step($exact + $range);
                        }
                        # ... if extended timings are set ...
                        elsif ($FHEM_Hash->{TIMING} eq MMSOMFY::Timing::extended)
                        {

                        }
                    }
                }

                #    with timer   calcPos at new time y / cmd close --> halt timer ( newState y )
                $move = 'open';
                $driveTime = $cmdarg;
                if ( $driveTime == 0 ) {
                $move = 'stop';
                } else {
                $updateState =  _MMSOMFY_CalcCurrentPos($move, $pos, $cmdarg );
                }

                # without timer
                $move = $1;
                $newState = MMSOMFY::State::closing;
                $driveTime = $cmdarg;

                if ($driveTime == 0)
                {
                    $move = MMSOMFY::Command::stop;
                }
                else
                {
                    $updateState = MMSOMFY::State::closing;
                }
            }
            elsif ($cmd eq MMSOMFY::Command::open_for_timer)
            {
                


                #    with timer   calcPos at new time y / cmd close --> halt timer ( newState y )
                $move = 'open';
                $driveTime = $cmdarg;
                if ( $driveTime == 0 ) {
                $move = 'stop';
                } else {
                $updateState =  _MMSOMFY_CalcCurrentPos($move, $pos, $cmdarg );
                }

                # without timer
                $move = $1;
                $newState = MMSOMFY::State::opening;
                $driveTime = $cmdarg;

                if ($driveTime == 0)
                {
                    $move = MMSOMFY::Command::stop;
                }
                else
                {
                    $updateState = MMSOMFY::State::opening;
                }
            }
            elsif($cmd eq MMSOMFY::Command::go_my)
            {
                $move = MMSOMFY::Command::stop;
                $newState = MMSOMFY::State::mypos;
            }
            elsif($cmd eq MMSOMFY::Command::stop)
            {
                $move = MMSOMFY::Command::stop;
                # Keep current state
                #$newState = $FHEM_Hash->{STATE};
            }
            elsif($cmd eq MMSOMFY::Command::manual)
            {
                $newState = $cmdarg;
            }
            else
            {
                # State remains unchanged.
                #$newState = $FHEM_Hash->{STATE};
            }
            # todo: JM end

            ### update hash / readings
            Log3($name,4,"MMSOMFY_set: handled command $cmd --> move :$move:  newState :$newState: ");

            if (defined($updateState))
            {
                Log3($name,5,"MMSOMFY_set: handled for drive/udpate:  updateState :$updateState:  drivet :$driveTime: updatet :$updatetime: ");
            }
            else
            {
                Log3($name,5,"MMSOMFY_set: handled for drive/udpate:  updateState ::  drivet :$driveTime: updatet :$updatetime: ");
            }

            MMSOMFY::Reading::Update($exact, $move);

    # todo: JM
    #        if ( defined( $updateState ) ) {
    #            $FHEM_Hash->{updateState} = $updateState;
    #        } else {
    #            delete $FHEM_Hash->{updateState};
    #        }
    #
    #        $FHEM_Hash->{MOVE} = $move;


            ### send command
            if ($mode ne MMSOMFY::Mode::virtual)
            {
                if ($move ne 'none')
                {
                    $args[0] = $somfy_sendCommands{$move};
                    $args[0] = $move if (!defined($args[0]));
                    _MMSOMFY_SendCommand($FHEM_Hash,@args);
                }
                else
                {
                    # do nothing if commmand / move is set to none
                }
            } else {
                # in virtual mode define driveTime as updatetime only, so no commands will be send
                if ($updatetime == 0)
                {
                    $updatetime = $driveTime;
                }

                $driveTime = 0;
            }

            ### update time stamp
            _MMSOMFY_UpdateStartTime();
            $FHEM_Hash->{runningtime} = 0;

            if ($driveTime > 0)
            {
                $FHEM_Hash->{runningcmd} = 'stop';
                $FHEM_Hash->{runningtime} = $driveTime;
            }
            elsif ($updatetime > 0)
            {
                $FHEM_Hash->{runningtime} = $updatetime;
            }

            ### start timer
            if ($FHEM_Hash->{runningtime} > 0)
            {
                # timer fuer stop starten
                if (defined($FHEM_Hash->{runningcmd}))
                {
                    Log3($name,4,"MMSOMFY_set: $name -> stopping in $FHEM_Hash->{runningtime} sec");
                }
                else
                {
                    Log3($name,4,"MMSOMFY_set: $name -> update state in $FHEM_Hash->{runningtime} sec");
                }

                my $utime = $FHEM_Hash->{runningtime} ;

                if($utime > $somfy_updateFreq) {
                    $utime = $somfy_updateFreq;
                }

                InternalTimer(gettimeofday()+$utime,"_MMSOMFY_TimedUpdate",$FHEM_Hash);
            }
            else
            {
                delete $FHEM_Hash->{runningtime};
                delete $FHEM_Hash->{starttime};
            }
        }
