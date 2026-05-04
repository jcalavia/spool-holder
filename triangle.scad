// striangulo_integrado_v2.scad
$fn=80;
// PARÁMETROS
altura = 110;
prof = 80;
espesor = 12;
// eje
diam_eje_fijo = 8.2;
diam_eje_tol = 8.5;
// base anclaje
ancho_base = 42;
alto_base = 50;
esp_base = 8;
// ---------------------
// TRIÁNGULO
// ---------------------
module nodo(x,y){
translate([x,y,0])
cylinder(h=espesor, d=26);
}
hull(){
nodo(0,0);
nodo(prof,0);
nodo(prof/2,altura);
}
// ---------------------
// BASE DELANTERA
// ---------------------
translate([-ancho_base/2, -esp_base, 0])
difference(){
cube([ancho_base, esp_base, alto_base]);
for (z=[15,35])
translate([ancho_base/2, esp_base/2, z])
rotate([90,0,0])
    cylinder(h=esp_base+2, d=4.2);
}
// ---------------------
// BASE TRASERA
// ---------------------
translate([prof-ancho_base/2, -esp_base, 0])
difference(){
cube([ancho_base, esp_base, alto_base]);
for (z=[15,35])
translate([ancho_base/2, esp_base/2, z])
rotate([90,0,0])
    cylinder(h=esp_base+2, d=4.2);
}
// ---------------------
// SOPORTE EJE (fijo)
// ---------------------
translate([prof/2-14,altura-8,0])
difference(){
cube([28,28,espesor]);
translate([14,14,-1])
cylinder(h=espesor+2, d=diam_eje_fijo);
}
// ---------------------
// SOPORTE EJE (tolerante)
// ---------------------
translate([prof/2-14,altura+20,0])
difference(){
cube([28,28,espesor]);
translate([14,14,-1])
cylinder(h=espesor+2, d=diam_eje_tol);
}