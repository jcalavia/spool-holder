// axle_test.scad — Pieza mínima para verificar ajuste del 608ZZ
// Alojamiento del rodamiento a AMBOS lados, como el eje final.
$fn=160;

// --- Parameters ---
bearing = 22.5;     // mm, diámetro bolsillo (22mm + 0.5mm tolerancia)
bearing_depth = 7.5;// mm, profundidad bolsillo
eje = 8.2;          // mm, agujero pasante varilla M8
wall = 3;           // mm, pared central entre bolsillos
d = 40;             // mm, diámetro exterior de la pieza de prueba

alto = bearing_depth + wall + bearing_depth;

difference() {
  cylinder(h=alto, d=d);

  // rodamiento lado 1 (inferior)
  translate([0, 0, 0])
    cylinder(h=bearing_depth, d=bearing);

  // rodamiento lado 2 (superior)
  translate([0, 0, alto - bearing_depth])
    cylinder(h=bearing_depth, d=bearing);

  // paso eje (agujero 8mm M8)
  translate([0, 0, -1])
    cylinder(h=alto + 2, d=eje);
}