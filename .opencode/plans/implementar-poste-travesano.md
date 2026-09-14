# Implementación: Poste vertical + Travesaño desmontable

## 1. Modificaciones a `triangle.scad`

### 1.1 Parámetros (reemplazar líneas 32-44)
```
spool_separation = 85;
guide_z = espesor + spool_separation / 2;  // = 12 + 42.5 = 54.5
eyelet_pos = [19, 140];
eyelet_id = 5;
eyelet_ptfe_id = 4.1;
arm_d = 10;

post_w = 14;
post_x = -14;
dovetail_top = 140;
dovetail_bottom = 125;
```

### 1.2 Reemplazar módulo `filament_guide()` por `vertical_post()`
```openscad
module vertical_post(){
    // Cuerpo del poste (se fusiona con base delantera vía union)
    translate([post_x, (dovetail_bottom + (-12)) / 2 - 4, guide_z])
        cube([post_w, dovetail_bottom + 12, post_w], center=true);
}
```

### 1.3 Base delantera más alta en lado libre
```openscad
cube([ancho_base, esp_base, lado == "libre" ? 65 : alto_base]);
```

### 1.4 En el union{}, reemplazar llamada a filament_guide por:
```openscad
if (lado == "libre") {
    vertical_post();
}
```

### 1.5 En el difference{}, añadir ranura cola de milano:
```openscad
if (lado == "libre") {
    // Ranura cola de milano en cara +X del poste
    translate([post_x + post_w/2 - 4, dovetail_bottom, guide_z - 5])
    hull() {
        cube([4, dovetail_top - dovetail_bottom, 10]);          // fondo
        translate([0, 0, 1])
            cube([4, dovetail_top - dovetail_bottom, 8]);       // boca
    }
}
```

## 2. Archivo nuevo: `crosspiece.scad`

```openscad
// crosspiece.scad — Travesaño desmontable para guía de filamento
$fn=80;

// Parámetros (deben coincidir con triangle.scad)
spool_separation = 85;
espesor = 12;
guide_z = espesor + spool_separation / 2;
eyelet_id = 5;
eyelet_ptfe_id = 4.1;
arm_d = 10;
post_w = 14;
post_x = -14;
dovetail_top = 140;
dovetail_bottom = 125;
eyelet_x = 19;
eyelet_y = 140;

difference() {
    union() {
        // Lengüeta cola de milano
        hull() {
            translate([post_x + post_w/2 - 4, dovetail_bottom, guide_z - 5])
                cube([4, dovetail_top - dovetail_bottom, 10]);
            translate([post_x + post_w/2, dovetail_bottom, guide_z - 4.5])
                cube([0.1, dovetail_top - dovetail_bottom, 8]);
        }

        // Brazo horizontal
        hull() {
            translate([post_x + post_w/2, dovetail_top - 1, guide_z - 4])
                cube([0.1, 1, 8]);
            translate([eyelet_x, eyelet_y, guide_z])
                sphere(d=arm_d);
        }

        // Anillo exterior del ojal
        translate([eyelet_x, eyelet_y, guide_z])
            rotate([0, 90, 0])
                cylinder(d=arm_d*1.1, h=8, center=true);
    }

    // Entrada (bobina, lado +X): Ø5mm
    translate([eyelet_x + 2, eyelet_y, guide_z])
        rotate([0, 90, 0])
            cylinder(d=eyelet_id, h=4.1, center=true);

    // Salida (frente, lado -X): Ø4.1mm para PTFE
    translate([eyelet_x - 2, eyelet_y, guide_z])
        rotate([0, 90, 0])
            cylinder(d=eyelet_ptfe_id, h=4.1, center=true);
}
```

## 3. Verificación

Renderizar ambos lados:
```bash
/Applications/OpenSCAD-2021.01.app/Contents/MacOS/openscad -o /tmp/triangle_libre.stl -D 'lado="libre"' triangle.scad
/Applications/OpenSCAD-2021.01.app/Contents/MacOS/openscad -o /tmp/triangle_fijo.stl -D 'lado="fijo"' triangle.scad
/Applications/OpenSCAD-2021.01.app/Contents/MacOS/openscad -o /tmp/crosspiece.stl crosspiece.scad
```
