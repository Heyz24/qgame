# Changelog

## [1.0.0] - 2026-10-11

First release.

- `rng.qax`: seeded xorshift32 generator, unbiased `below`, `range`, `float`, `chance`, `shuffle`.
- `rect.qax`: axis-aligned hit boxes.
- `grid.qax`: integer grids with bounds checks, copy/compare, text round trip.
- `life.qax`: Game of Life step.
- `path.qax`: breadth-first shortest path and flood-fill region size.
- `clock.qax`: fixed time step with a stall cap, cooldowns.
- Tests: `selftest.qax` (99 checks), `negative.qax` (17 misuse cases), `run-tests.sh` / `run-tests.bat`, `example.qax`.
- `AUDIT.md`: what was reviewed, how it was tested, what was not.
