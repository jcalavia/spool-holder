# spool-holder

Modular filament spool holder designed for Creality 3D printers. Supports both 1 kg and 200 g spools with adjustable triangular side frames, bearing-mounted axle, and an optional detachable crosspiece with a PTFE guide.

## Description

This holder replaces the stock spool mount with a sturdier, low-friction design:

- **Axle** (`axle_1kg`, `axle_200g`) — Bearing-mounted casquillo (608ZZ) for smooth rotation.
- **Side frames** (`triangle_8.2`, `triangle_8.5`) — Hollow triangular structure for rigidity with minimal material.
- **Clamps** (`clamp_izquierda`, `clamp_derecha`) — Bar-mount clamps with captive hex nuts.
- **Crosspiece** (`crosspiece`) — Optional detachable PTFE filament guide.

The `8.2` and `8.5` variants correspond to the axle hole diameter (mm) for fixed vs. free-side frames.

## Print Settings

| Setting | Value |
|---------|-------|
| Layer height | 0.2 mm |
| Infill | 20–30 % (triangles: 25 %; clamps: 30 %) |
| Supports | No (all parts are support-free or self-supporting) |
| Orientation | Print clamps on their flat face; triangles lying flat |
| Walls | 3 |

**Recommended filament**: PETG or ABS for mechanical strength; PLA is acceptable for light use.

## Rendering

```bash
cd spool-holder
make all        # Generate all STLs into stl/
make clean      # Remove stl/ and dist/
```

Requires [OpenSCAD](https://openscad.org/) (macOS auto-discovered if installed in `/Applications`).

## License

CC-BY-4.0
