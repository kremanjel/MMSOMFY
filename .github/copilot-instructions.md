# Project Guidelines

## Code Style
- This repository is a FHEM Perl module project. Keep changes Perl-first and compatible with FHEM runtime APIs (`main::Log3`, `main::readings*`, `%main::attr`, `%main::defs`).
- Follow existing naming patterns:
  - Public module entry points: `MMSOMFY_*`.
  - Internal helpers: `_MMSOMFY_*`.
  - Domain constants: fully-qualified namespaces such as `MMSOMFY::Attribute::*` and `MMSOMFY::Model::*`.
- Prefer minimal, targeted edits in existing packages instead of broad refactors in `10_MMSOMFY.pm`.

## Architecture
- Core implementation is in `10_MMSOMFY.pm` with domain packages (`MMSOMFY::Mode`, `::Movement`, `::Model`, `::Timing`, `::Command`, `::DeviceModel`, etc.) and a `package main` integration section.
- `10_SOMFY.pm` is a legacy/reference module. Use it for protocol background, but treat `10_MMSOMFY.pm` as the active source of truth.
- Device behavior is model-specific (`shutter`, `awning`, `remote`, `switch`). Preserve model boundaries when adding logic.

## Build and Test
- There is no standalone build system, package manager, or CI in this repository.
- This module is loaded by FHEM via `fhem.cfg`; validation is primarily runtime/manual.
- For behavior checks, use configured test devices in `fhem.cfg` (`somfytest`, `somfytest2`, `somfytest3`) and verify readings/log output.

## Conventions
- Keep timing validation and calibration logic consistent with model requirements; timing attributes are not universally applicable to every model.
- Preserve existing attribute and reading keys to avoid breaking persisted FHEM configurations.
- Treat commented `IOWrite(...)` debug lines as intentional unless a task explicitly asks to re-enable real sending.
- Keep commit message generation aligned with `.github/instructions/CommitMessage.instructions.md`.

## References
- Existing commit-message policy: `.github/instructions/CommitMessage.instructions.md`
- Example runtime configuration: `fhem.cfg`
- Primary module implementation: `10_MMSOMFY.pm`
