# spool-holder

Filament spool holder for Creality Ender 3 V3 Plus. Holds 200 g and 1 kg spools on a 608ZZ bearing with an M8 steel rod axle.

## Description

This repo generates the axle, clamps, crosspiece, and triangular support for a roller-style spool holder. The axle uses a 608ZZ bearing (22 mm OD × 7 mm width) press-fitted into a printed sleeve. Two printed clamps grip the printer frame's 19.2 mm aluminium extrusion, and a hollow triangular brace provides vertical support.

### Parts

| Part | File | Notes |
|------|------|-------|
| Axle (1 kg) | `axle.scad` | Parametric; `width=76` for 1 kg spools |
| Axle (1 kg light) | `axle_1kg_light.scad` | Thin-tube middle: ~65 % less material, real weight saving at any infill. **Print standing on end** (no supports) |
| Axle (1 kg light v2) | `axle_1kg_light_v2.scad` | Previous variant: deep grooves + hexagonal bore (143.2 cm³) |
| Axle (200 g) | `axle.scad` | Parametric; `width=48` for 200 g spools |
| Axle test piece | `axle_test.scad` | Minimal print to verify 608ZZ fit |
| Clamp (left) | `clamp.scad` | `lado_tuerca="izquierda"` |
| Clamp (right) | `clamp.scad` | `lado_tuerca="derecha"` |
| Triangle support | `triangle.scad` | `lado="fijo"` (8.2 mm) or `"libre"` (8.5 mm) |
| Crosspiece | `crosspiece.scad` | Connects clamps to the axle |

## Print Settings

| Setting | Value |
|---------|-------|
| Layer height | 0.2 mm |
| Infill | 30–40 % (axle), 20 % (triangle), 40 % (clamps) |
| Supports | No |
| Orientation | Flat on build plate |
| Perimeters | 3 |

**Recommended filament**: PLA or PETG. The axle sleeve benefits from higher infill for rigidity.

## Rendering

```bash
cd spool-holder
make all            # Render all STLs into stl/
make clean          # Remove stl/ and dist/
```

Requires [OpenSCAD](https://openscad.org/) (macOS auto-discovered if installed in `/Applications`).

## Assembly

1. Press-fit the 608ZZ bearing into each end of the axle sleeve.
2. Slide the M8 rod through the axle and both bearings.
3. Attach the clamps to the printer frame extrusion.
4. Mount the crosspiece between clamps.
5. Insert the axle into the crosspiece and secure with the triangular brace.

## License

MIT
