// axle_1kg_light.scad — Lightened 1kg spool axle (thin-tube middle)
// El medio es un tubo de pared fina (imprime como paredes, no como relleno):
// ahorro real de peso a CUALQUIER porcentaje de infill.
$fn=160;

// --- Parameters ---
outer = 55.6;        // mm, diámetro exterior (Creality)
bearing = 22.5;      // mm, alojamiento 608 (22mm + 0.5mm tolerancia)
width = 70;          // mm, largo total
bearing_depth = 7.5; // mm, profundidad rodamiento
eje = 8.2;           // mm, paso eje (agujero varilla M8)

// Tubo central (pared fina; sin anillo de refuerzo interior)
wall = 2.0;                  // mm, espesor de pared del medio
mid_len = width - 2*bearing_depth - 3; // mm, largo del tubo (52: deja 1.5mm a cada bolsillo)

// Ranuras exteriores tangentes (paralelas al eje)
lightening_holes = 6;   // número de ranuras
lightening_d = 8;       // mm, diámetro ranuras (atraviesa la pared del tubo)

// Chaflán exterior (quita material no estructural)
chamfer = 2.5;

difference() {
  // Cuerpo principal con chaflanes
  union() {
    cylinder(h=width, d=outer);
    // Chaflanes en los bordes exteriores
    translate([0,0,-0.01])
      cylinder(h=chamfer+0.01, d1=outer-chamfer*2, d2=outer);
    translate([0,0,width-chamfer])
      cylinder(h=chamfer+0.01, d1=outer, d2=outer-chamfer*2);
  }

  // Rodamiento lado 1 (pasa del chaflán inferior para que el alojamiento
  // quede abierto en la cara: -0.02 .. bearing_depth)
  translate([0,0,-0.02])
    cylinder(h=bearing_depth+0.02, d=bearing);

  // Rodamiento lado 2 (llega hasta el chaflán superior: abierto en la cara)
  translate([0,0,width-bearing_depth])
    cylinder(h=bearing_depth+0.02, d=bearing);

  // Paso eje
  translate([0,0,-1])
    cylinder(h=width+2, d=eje);

  // Tubo central: vacía el medio dejando pared fina
  translate([0,0,width/2])
    cylinder(h=mid_len, d=outer - 2*wall, center=true);

  // Ranuras de aligerado (tangentes a la superficie, a lo largo del medio)
  for (i = [0:lightening_holes-1]) {
    rotate([0, 0, i * 360 / lightening_holes])
      translate([outer/2, 0, width/2])
        cylinder(h=mid_len, d=lightening_d, center=true);
  }
}