// axle.scad — Casquillo portacarretes con rodamiento 608ZZ
$fn=160;

// --- Parameters ---
outer = 55.6;       // mm, diámetro exterior (Creality)
bearing = 22.5;     // mm, alojamiento 608ZZ: 22mm + 0.5mm tolerancia FDM
width = 76;         // mm, ancho total (variable: 48→200g, 76→1kg, +3mm margen c/u)
bearing_depth = 7.5;// mm, profundidad bolsillo: 7mm + 0.5mm fondo
eje = 8.2;          // mm, agujero pasante varilla M8
refuerzo = 3;       // mm, espesor anillo de refuerzo central

difference() {
  cylinder(h=width, d=outer);

  translate([0, 0, 0])
    cylinder(h=bearing_depth, d=bearing);

  translate([0, 0, width - bearing_depth])
    cylinder(h=bearing_depth, d=bearing);

  translate([0, 0, -1])
    cylinder(h=width + 2, d=eje);
}

translate([0, 0, width / 2])
  difference() {
    cylinder(h=refuerzo, d=outer * 0.6);
    cylinder(h=refuerzo + 1, d=eje);
  }
