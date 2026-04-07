# MMSOMFY

MMSOMFY is a FHEM module for controlling Somfy RTS / Simu Hz devices (for example awnings, shutters, and switches) over 433 MHz.

The module provides:
- Sending RTS commands via a FHEM IO device (typically CUL/SIGNALduino)
- Model-specific behavior for `awning`, `shutter`, `switch`, and `remote`
- Position/state tracking including timing-based calculations
- Interactive calibration for movement times
- Usage as a virtual remote address per device

## What is this project for?

This repository contains the active development of a FHEM Perl module for Somfy RTS.
Its goal is a robust, day-to-day usable FHEM integration for:
- local smart-home automation without cloud dependency
- reproducible control of multiple RTS devices
- transparent behavior through FHEM readings/internals and logs

## Who is this for?

- FHEM users who want to integrate Somfy RTS / Simu Hz devices
- Developers who want to extend or test the module
- Users who already have a 433 MHz setup (for example CUL, SIGNALduino)

## Requirements

- Running FHEM installation
- 433 MHz IO device in FHEM (for example CUL/SIGNALduino)
- This module (`10_MMSOMFY.pm`) in the FHEM module path

For local development/testing additionally:
- Perl
- Test modules (`Test2::Suite`)
- Optional for coverage: `Devel::Cover`

## Installation in FHEM

1. Copy `10_MMSOMFY.pm` into the FHEM module directory.
2. Restart FHEM or reload the configuration.
3. Define your IO device (for example CUL) in FHEM.
4. Define MMSOMFY devices and assign the IODev.

## Migration from SOMFY to MMSOMFY

If you replaced the original `SOMFY` setup with `MMSOMFY`, the working installation shows these required changes:

Recommended approach:
- Recreate devices instead of in-place string replacement.
- The old SOMFY module and MMSOMFY differ in command names, model handling, and timing attribute names.
- A direct search/replace in `fhem.cfg` is error-prone.

For a step-by-step migration and mapping table, see:
- [CONVERSION_GUIDE.md](CONVERSION_GUIDE.md)

1. Module file in FHEM modules directory:
- Ensure `FHEM/10_MMSOMFY.pm` is present on the target system.

2. Device definitions in `fhem.cfg`:
- Use `MMSOMFY` in all device definitions, for example:

```text
define rolladen_kueche MMSOMFY 000001 shutter AF 016F
define somfytest2 MMSOMFY FFFFFF shutter A6 0006
define somfytest MMSOMFY 270507 remote
define somfytest3 MMSOMFY FFFFFA switch A0 001A
```

- No active `define ... SOMFY ...` entries should remain.

3. SIGNALduino client/matchlist support:
- In `FHEM/00_SIGNALduino.pm`, `MMSOMFY` must be included in the SIGNALduino client list.
- A dispatch regex entry for MMSOMFY must exist in `%matchListSIGNALduino`:

```perl
"15:MMSOMFY" => '^Ys[0-9A-F]+'
```

Without this dispatch mapping, incoming Somfy RTS telegrams are not routed to MMSOMFY devices.

4. Optional cleanup:
- Keeping `FHEM/10_SOMFY.pm` is possible, but not required for MMSOMFY operation.
- Room names like `SOMFY` in attributes are only labels and do not affect functionality.

## Create a device (Define)

Syntax:

```text
define <name> MMSOMFY <address> <model> [<encryption-key>] [<rolling-code>]
```

- `<address>`: 6-digit hexadecimal address (for example `42ABCD`)
- `<model>`: `awning`, `shutter`, `switch`, `remote`
- `<encryption-key>` / `<rolling-code>` optional for cloning/syncing existing remotes

Examples:

```text
define myAwning MMSOMFY 000001 awning
define myShutter MMSOMFY 000002 shutter
define mySwitch MMSOMFY 000003 switch
define clonedRemote MMSOMFY 42ABCD awning A5 0A1C
```

## Typical operation (Set)

General:

```text
set <name> <command> [<parameter>]
```

Common commands:

- All models: `stop`, `prog`
- Awning/Shutter: `open`, `close`, `go_my`, `position <0-100>`, `manual <value>`, `open_for_timer`, `close_for_timer`
- Switch: `on`, `off`
- Advanced/service: `z_custom`, `wind_sun_9`, `wind_only_a`

## Calibration

The module supports interactive calibration:

- Start: `set <name> calibrate`
- Next step: `set <name> calibrate_next`
- Abort: `set <name> calibrate_abort`
- Verify: `set <name> calibrate_verify`
- Reset: `set <name> calibrate_reset`

Notes:
- If timing is `extended`, extended calibration mode is used automatically.
- Progress is available in the device's calibration internals.

## Development and testing

### Run all tests

```powershell
prove -lr test
```

### Run tests with coverage (Windows/PowerShell)

```powershell
./run-tests.ps1
```

Optional automatic opening of the HTML report:

```powershell
./run-tests.ps1 -OpenCoverage
```

Artifacts are written to:
- `reports/test-report.txt`
- `reports/coverage-summary.txt`
- `reports/coverage-html/`
- `cover_db/`

## Project structure

- `10_MMSOMFY.pm`: Active module (source of truth)
- `10_SOMFY.pm`: Legacy/reference
- `test/`: Unit/integration tests for the module
- `run-tests.ps1`: Local test and coverage helper
- `reports/`, `cover_db/`: generated test/coverage artifacts

## Notes

- This project has no separate build system or CI pipeline in the repository.
- Validation is done primarily through FHEM runtime behavior and local tests.

## License

The module is distributed in the FHEM context under GPL (see header in `10_MMSOMFY.pm`).
