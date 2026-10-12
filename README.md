# qgame

Building blocks for games, written in [QAX-LANG](https://github.com/Heyz24/QAX-LANG) and installed with its package manager.

```text
qpm add Heyz24/qgame --ref v1.0.0
```

```qax
import "qgame/qgame.qax"      // everything; or "qgame/rng.qax", "qgame/grid.qax", ...

fn main() {
    let dice = qg_rng(2024)                       // same seed, same rolls, on every machine
    print(qg_rng_range(dice, 1, 6), qg_rng_range(dice, 1, 6))
}
```

Used by the example apps `space-shooter` and `life-lab` in the QAX-LANG repository (`examples/apps`).

## What is in it

QAX has one shared namespace, so everything is prefixed: `qg_` for functions, `Qg` for types.

| File | Provides |
|---|---|
| `rng.qax` | `QgRng`, `qg_rng(seed)`, `qg_rng_u32`, `qg_rng_below(r, n)` (no modulo bias), `qg_rng_range(r, lo, hi)`, `qg_rng_float`, `qg_rng_chance(r, pct)`, `qg_rng_shuffle(r, xs)`. Deterministic xorshift32; **not** for security. |
| `rect.qax` | `QgRect`, `qg_rect`, `qg_rect_overlap`, `qg_rect_has`, `qg_rect_intersection`, `qg_rect_move`, `qg_rect_right`, `qg_rect_bottom`. Edges that only touch do not overlap. |
| `grid.qax` | `QgGrid` (a w x h grid of ints): `qg_grid`, `qg_in`, `qg_get`, `qg_get_or`, `qg_set`, `qg_fill`, `qg_count`, `qg_grid_copy`, `qg_grid_equal`, `qg_grid_from_rows`, `qg_grid_rows`. |
| `life.qax` | `qg_life_step(grid)` (Conway's Game of Life, dead edges), `qg_life_neighbors`. |
| `path.qax` | `qg_path_len(grid, sx, sy, tx, ty, wall)` (breadth-first, 4-way), `qg_region_size(grid, x, y)` (flood fill). |
| `clock.qax` | `QgClock` fixed time step (`qg_clock`, `qg_clock_advance`, `qg_clock_alpha`) and `QgCooldown` (`qg_cooldown`, `qg_cooldown_use`, `qg_cooldown_tick`, `qg_cooldown_ready`). |

`example.qax` is a runnable tour (a seeded dice roll, a glider, a maze, hit boxes, a fixed time step).

## Things to know

- **Structs are references.** `let b = a` makes `b` and `a` the same object. Use `qg_grid_copy` for an independent grid. This is how
  QAX structs work, not something the package chose.
- **Misuse stops the program.** An out-of-bounds `qg_get`, a zero-size grid, `qg_rng_below(r, 0)` and similar stop it with
  `assertion failed [file.qax:line]` and exit code 101. There is no error value to forget to check. `negative.qax` lists every case.
- **Integer only.** Everything except `qg_rng_float`, `qg_clock_alpha` is integer arithmetic, so results are exactly reproducible.
- **Limits.** A grid holds at most 16,777,216 cells; `qg_rng_below` takes `1 <= n <= 4294967295`; the RNG period is 2^32 - 1.
- **Names.** Do not name your own functions like QAX built-ins (`pop`, `push`, `len`, ...): a user function with a built-in's
  name replaces it for the whole program, packages included.

## Tests

```text
./run-tests.sh          # Linux/macOS: set QAX_RUN=wine64
run-tests.bat           # Windows
```

99 checks in `selftest.qax` (known-answer values from an independent Python port, comparison against slow reference code,
invariants over random inputs, edge cases) plus 17 deliberate misuse cases in `negative.qax`, each of which must stop with the
expected assertion. See [AUDIT.md](AUDIT.md) for what was checked and what was not.

## Versions

`MAJOR.MINOR.PATCH`, tagged `vX.Y.Z`; `qax.json` carries the same number. Adding an exported name is MINOR; removing or renaming one,
changing a signature or a struct's fields is MAJOR. See the QAX-LANG docs, *Cookbook: Packages*, section 7. Changes are listed in
[CHANGELOG.md](CHANGELOG.md).

## Licence

No licence file has been added yet; until the owner adds one, the usual default (all rights reserved) applies.
