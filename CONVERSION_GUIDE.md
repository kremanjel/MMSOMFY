# SOMFY to MMSOMFY Conversion Guide

This guide helps migrate from the legacy SOMFY module to MMSOMFY.

## Recommendation

Preferred migration path:
- Create new MMSOMFY devices and retire old SOMFY devices after validation.
- Do not do a global text replacement in the full `fhem.cfg`.

Why:
- Command names differ.
- Model names differ.
- Timing attribute names differ.
- Some readings and behavior are not 1:1.

## 1) Prepare

1. Back up your current `fhem.cfg` and state files.
2. Ensure `FHEM/10_MMSOMFY.pm` is installed.
3. Ensure SIGNALduino dispatch is configured for MMSOMFY:
- Client list contains `MMSOMFY`.
- Matchlist has: `"15:MMSOMFY" => '^Ys[0-9A-F]+'`.

## 2) Define new devices (parallel run)

Create new MMSOMFY devices with new names first.

Example:

- old:
  define rollo_kueche SOMFY 000001 AF 016F
- new:
  define rolladen_kueche MMSOMFY 000001 shutter AF 016F

After creating the new devices, assign `IODev` and test open/close/stop.

## 3) Mapping: model values

SOMFY model attribute to MMSOMFY define model:

- somfyblinds -> awning
- somfyshutter -> shutter
- somfyremote -> remote
- somfyswitch2 / somfyswitch4 -> switch

Note:
- MMSOMFY uses model in define command, not as a SOMFY-style model attribute.

## 4) Mapping: command names

Most important command mappings:

- on -> close (awning/shutter)
- off -> open (awning/shutter)
- go-my -> go_my
- pos / position -> position
- on-for-timer -> close_for_timer
- off-for-timer -> open_for_timer
- manual -> manual
- prog -> prog

Switch devices:
- on / off stay on / off.

## 5) Mapping: timing attributes

SOMFY timing attributes to MMSOMFY attributes:

- drive-down-time-to-100 -> driveTimeOpenedToDown
- drive-down-time-to-close -> driveTimeOpenedToClosed
- drive-up-time-to-100 -> driveTimeClosedToOpened
- drive-up-time-to-open -> driveTimeDownToOpened

Keep in mind:
- Semantics are similar, names are different.
- Validate timing with real movement and adjust values.

## 6) Other attribute differences

- fixed_enckey -> fixedEnckey
- symbol-length -> symbolLength
- positionInverse -> positionInverse (same name)
- repetition -> repetition (same name)
- rawDevice -> rawDevice (same name)

Legacy SOMFY-only attributes like `additionalPosReading` or `finalPosReading` are not part of the MMSOMFY core attribute set.

## 7) Reading expectations

MMSOMFY uses a different reading model than legacy SOMFY.
Verify your automations for references to old readings and update them as needed.

Common MMSOMFY readings include:
- enc_key
- rolling_code
- factor
- position
- movement
- received
- command

## 8) Suggested cut-over procedure

1. Keep old SOMFY devices for reference only.
2. Create MMSOMFY devices in parallel.
3. Copy and map required attributes.
4. Test each device manually (open/close/stop/position).
5. Verify automations, notify rules, and UI views.
6. Switch automations to MMSOMFY device names.
7. Remove old SOMFY devices.

## 9) Minimal checklist

- MMSOMFY module file installed
- SIGNALduino dispatch updated
- New MMSOMFY defines created
- Timing attributes mapped and validated
- Automation references updated
- Old SOMFY devices removed only after successful validation
