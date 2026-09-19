# spool-holder — AGENTS.md

Repo-specific rules and design decisions for the Creality Ender 3 V3 Plus spool holder.
Applies on top of the parent [`/Users/jcalavia/Development/Github/3d-design/AGENTS.md`](../AGENTS.md) conventions.

## Purpose

Functional parts (not toys): a 608ZZ-bearing axle, extrusion clamps, and a triangular brace
for a roller-style filament spool holder. Parts are printed on an Ender 3 V3 Plus
(300 × 300 mm bed; keep parts within ~250 × 250 mm usable footprint, no supports).

## Repo Layout

```
designs/                 # OpenSCAD sources (one file per model/variant)
  axle.scad              # Parametric solid axle (width via -D override)
  axle_1kg_light.scad    # Thin-tube light axle (see Design Decisions)
  axle_1kg_light_v2.scad # Previous light variant, kept for reference
  axle_test.scad         # 608ZZ press-fit test piece
  clamp.scad             # Extrusion clamp (side via -D override)
  triangle.scad          # Triangular brace (variant via -D override)
stl/                     # Generated STLs (gitignored — NEVER commit)
Makefile                 # `make all` renders every STL; `make clean` removes them
.github/workflows/render.yml  # CI renders STLs on pushes touching designs/*.scad
```

STL naming: lowercase with underscores; parametric variants append the override value
(e.g. `triangle_8.2.stl`, `axle_1kg.stl`, `clamp_izquierda.stl`).

## Design Decisions (read before changing geometry)

### Bearing system (must never regress)

- 608ZZ bearing: 22 mm OD × 7 mm width. The axle pockets use **22.5 mm diameter × 7.5 mm depth**
  (0.5 mm press-fit tolerance; 7.5 mm leaves clearance for the bearing shield).
- Pockets must be **open at both faces** — through to the outside. If a chamfer or feature
  closes the opening, the bearing cannot be pressed in. See `axle_test.scad`.
- M8 rod passes through an **8.2 mm bore** (0.2 mm clearance) along the full length.
- 2021-09 lesson: a chamfer floor previously sealed both pockets; the fix pierces the
  chamfer by extending the pocket cylinders 0.02 mm past the face (z=−0.02 / z=width+0.02).

### Lightening philosophy (the important one)

- **Printed weight at 15–20 % infill ≈ CAD volume × 1.24 × ~0.30.** Removing *interior*
  volume only saves infill-% of that mass — cuts that stay inside the walls barely move
  the scale. Only removing **shell/wall material** shows up.
- Therefore: to make a part genuinely lighter, make the *walls* thinner or remove solid
  bands — not add internal voids. (Measured: deep interior grooves + hex bore only saved 3 g.)

### Axle light variants

| File | Design | CAD volume | Why it exists |
|------|--------|-----------|---------------|
| `axle_1kg_light.scad` | Thin-tube middle: 2 mm wall, 6 tangent grooves (d=8), chamfer 2.5, **no internal ring** | 50,420 mm³ (~35 g printed) | Prints as walls → real saving at any infill. **Print standing on end (bearing face down)** — flat would need unbridgeable 50 mm bridging |
| `axle_1kg_light_v2.scad` | Deep grooves (d=10) + hexagonal bore (16.4 mm diagonal) + chamfer 2.5 | 143,214 mm³ (~54 g printed) | Previous variant; user printed and tested it — kept for reference |

- The thin-tube middle length = `width − 2×bearing_depth − 3` (1.5 mm margin on each side):
  grooves must never intersect the bearing pockets.
- The old internal `refuerzo` ring was removed from the light axle: it floated inside the
  tube void and contributed nothing structural.

### Verification before committing geometry changes

1. Render the STL: `make stl/<target>.stl`.
2. Compute the CAD volume from STL facets (signed tetrahedron sum) and check it against
   the expected value above.
3. Verify pocket openings: scan facet vertices at face planes (z=0.01 / z=width−0.01);
   the opening ring's min radius must be ≈ 11.25 (bearing 22.5/2), not 0 (sealed).
4. Flat-facet cylinder meshes have NO mid-span vertices on longitudinal surfaces:
   check volume + face bands, never z-band minimums, when verifying tube/groove features.

## Working Rules for Agents

- All changes go through the Makefile workflow; never hand-craft STL paths.
- Declare tunable parameters at the top of each `.scad` with `//` comments; metric mm only.
- `$fn` ≥ 64 for renders; 160 for round parts in final designs (keep as-is on light axles).
- Comments: Spanish or English both fine in `.scad`; docs and commits in English.
- After ANY geometry edit: re-render, re-volume, re-check pockets (see above) — then report numbers to the user.
- `.scad` sources live in `designs/`; render outputs land in `stl/` (gitignored).
- CI trigger pattern is `designs/*.scad` — keep it in sync if paths change.
- Commits: semantic English messages (`feat:`/`fix:`/`chore:`/`test:`), one concern per commit;
  use the git-master skill workflow for anything beyond a plain commit+push.
- The bearer of truth for printed-weight expectations is the **scale**, not the slicer:
  when a claimed improvement is based on CAD volume alone, say so and flag the ~0.30 factor.

## Printer / Slicer Notes

- No supports needed for any part (orientation chosen accordingly).
- Axle: 30–40 % infill, 3 perimeters (the lights still print fine at 15–20 % — wall-based).
- Clamps: 40 % infill. Triangle: 20 %.