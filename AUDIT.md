# qgame 1.0.0 — self-audit

This is an audit by the author (an AI assistant working with the maintainer). It is **not** an independent third-party audit.

## What was reviewed
Every .qax file was read line by line for: integer overflow/wrap, off-by-one and bounds errors, reference-type (struct) aliasing, reserved names (`__`), builtin shadowing, and misuse paths (bad arguments must stop with a clear `assert`, never silently corrupt).

## Tests
- selftest.qax: 99 checks (known-answer vectors from independent Python ports, differential tests against slow references, invariants over seeded random inputs).
- negative.qax: 17 misuse cases; each must stop with exit 101 and `assertion failed`.
- Run with run-tests.sh (Linux/Wine) or run-tests.bat (Windows).

## Mutation testing
25 hand-written mutants (operator flips, off-by-one, removed guards, changed constants). Killed by selftest: 25. Killed only by negative cases: 0. Survived: 0. Invalid: 0. Every earlier survivor was closed with a new test.

## Findings fixed during audit
- Helper name colliding with builtin `pop` (C031) — renamed.
- Reserved `__` identifiers (C017/C019) — renamed.
- Span overflow in range helper — guarded.
- Several weak assertions strengthened after mutation survivors.

## Limits (be honest)
- Tested on Wine 9, not on real Windows.
- Small mutation set (hand-made), not exhaustive.
- Pure QAX, user-mode only: no ports, physical memory, drivers or FFI.
- Not independently audited; no formal verification.
