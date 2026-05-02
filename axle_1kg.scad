// casquillo_608_v2.scad
$fn=160;
// PARAMETROS CLAVE
outer = 55.6; // diámetro exterior (Creality)
bearing = 22.15; // alojamiento 608
width = 70; // <-- NUEVO (antes 42)
bearing_depth = 7.2;
eje = 8.2;
// refuerzo central
refuerzo = 3; // espesor anillo interno
difference(){
  cylinder(h=width, d=outer);
  // rodamiento lado 1
  translate([0,0,0])
    cylinder(h=bearing_depth, d=bearing);

  // rodamiento lado 2
  translate([0,0,width-bearing_depth])
    cylinder(h=bearing_depth, d=bearing);

  // paso eje
  translate([0,0,-1])
    cylinder(h=width+2, d=eje);
}
// refuerzo central (evita flexión)
translate([0,0,width/2])
difference(){
cylinder(h=refuerzo, d=outer*0.6);
cylinder(h=refuerzo+1, d=eje);
}