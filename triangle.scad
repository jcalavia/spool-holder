// triangulo_integrado_FINAL.scad
$fn=80;
// PARÁMETROS CLAVE
altura = 110;
prof = 80;
espesor = 12;
// eje
diam_eje_fijo = 8.2;
diam_eje_tol = 8.5;
// base pinza
ancho_clip = 36;
alto_oreja = 24;
// ---------------------
// TRIÁNGULO PRINCIPAL
// ---------------------
module nodo(x,y){
translate([x,y,0])
cylinder(h=espesor, d=24);
}
hull(){
nodo(0,0);
nodo(prof,0);
nodo(prof/2,altura);
}
// ---------------------
// OREJAS PARA PINZAS
// ---------------------
// delantera
translate([0,-espesor,0])
difference(){
cube([ancho_clip, espesor, alto_oreja]);
translate([ancho_clip/2, espesor/2, alto_oreja/2])
rotate([90,0,0])
cylinder(h=espesor+2, d=4.2);
}
// trasera
translate([prof-ancho_clip,-espesor,0])
difference(){
cube([ancho_clip, espesor, alto_oreja]);
translate([ancho_clip/2, espesor/2, alto_oreja/2])
rotate([90,0,0])
cylinder(h=espesor+2, d=4.2);
}
// ---------------------
// SOPORTE EJE (lado fijo)
// ---------------------
translate([prof/2-12,altura-6,0])
difference(){
cube([24,24,espesor]);
translate([12,12,-1])
cylinder(h=espesor+2, d=diam_eje_fijo);
}
// ---------------------
// SOPORTE EJE (lado tolerante)
// ---------------------
translate([prof/2-12,altura+18,0])
difference(){
cube([24,24,espesor]);
translate([12,12,-1])
cylinder(h=espesor+2, d=diam_eje_tol);
}