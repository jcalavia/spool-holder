// axle_test.scad — Pieza mínima para verificar ajuste del 608ZZ
$fn=160;

// --- Parameters ---
bearing = 22.5;     // mm, diámetro bolsillo (22mm + 0.5mm tolerancia)
bearing_depth = 7.5;// mm, profundidad bolsillo
eje = 8.2;          // mm, agujero varilla M8
wall = 3;           // mm, pared bajo el rodamiento
alto = bearing_depth + wall;

difference() {
  cylinder(h=alto, d=40);
  translate([0, 0, wall])
    cylinder(h=bearing_depth, d=bearing);
  translate([0, 0, -1])
    cylinder(h=alto + 2, d=eje);
}
