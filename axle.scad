// axle.scad — Casquillo portacarretes con rodamiento 608ZZ
$fn=160;

outer = 55.6;       // Diámetro exterior (Creality)
bearing = 22.5;     // Alojamiento 608ZZ: 22mm + 0.5mm tolerancia FDM
width = 76;         // Ancho total (variable: 48→200g, 76→1kg, +3mm margen c/u)
bearing_depth = 7.5;// Profundidad bolsillo: 7mm + 0.5mm fondo
eje = 8.2;          // Agujero pasante varilla M8
refuerzo = 3;       // Espesor anillo de refuerzo central

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
