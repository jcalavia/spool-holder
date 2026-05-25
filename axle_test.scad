// axle_test.scad — Pieza mínima para verificar ajuste del 608ZZ
$fn=160;

bearing = 22.5;     // diámetro bolsillo (22mm + 0.5mm tolerancia)
bearing_depth = 7.5;// profundidad bolsillo
eje = 8.2;          // agujero varilla M8
wall = 3;           // pared bajo el rodamiento
alto = bearing_depth + wall;

difference() {
  cylinder(h=alto, d=40);
  translate([0, 0, wall])
    cylinder(h=bearing_depth, d=bearing);
  translate([0, 0, -1])
    cylinder(h=alto + 2, d=eje);
}
