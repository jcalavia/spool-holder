// axle_1kg_light.scad — Lightened 1kg spool axle (reduced filament)
$fn=160;

// --- Parameters ---
outer = 55.6;        // diámetro exterior (Creality)
bearing = 22.5;      // alojamiento 608 (22mm + 0.5mm tolerancia, igual que axle.scad)
width = 70;          // largo total
bearing_depth = 7.5; // profundidad rodamiento
eje = 8.2;           // paso eje (agujero varilla M8)

// Refuerzo central (reducido para ahorrar filamento)
refuerzo = 2.0;            // espesor anillo interno (antes 3)
refuerzo_diam_ratio = 0.45; // diámetro anillo = outer * ratio (antes 0.60)

// Orificios de aligerado (lightening holes)
lightening_holes = 6;      // número de agujeros
lightening_d = 8;          // diámetro agujeros
lightening_z = width / 2;  // centrados en la pieza

// Chaflán exterior (quita material no estructural)
chamfer = 1.5;

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

  // Orificios de aligerado radiales
  for (i = [0:lightening_holes-1]) {
    rotate([0, 0, i * 360 / lightening_holes])
      translate([outer/2, 0, lightening_z])
        rotate([90, 0, 0])
          cylinder(h=outer, d=lightening_d, center=true);
  }
}

// Refuerzo central (reducido)
translate([0,0,width/2 - refuerzo/2])
difference(){
  cylinder(h=refuerzo, d=outer * refuerzo_diam_ratio);
  translate([0,0,-0.5])
    cylinder(h=refuerzo+1, d=eje);
}
