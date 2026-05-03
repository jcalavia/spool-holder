// clip_barra_v12_FINAL.scad
$fn=120;
// -------- parámetros --------
barra = 19.2;
holgura = 0.3;
grosor = 8;
ancho = 24;
// placa para el triángulo
placa_ancho = 42;
placa_espesor = 8;
placa_alto = 50;
// ranura de cierre
gap = 3; // se cierra al apretar
// tornillería m3
d_m3 = 3.2;
tuerca_m3 = 6.3;   // + tolerancia Ender
tuerca_h = 2.6;clearance = 0.2;
// posiciones de los tornillos de abrazadera (en Z)
z_bolts = [ancho*0.33, ancho*0.66];
// posición tangencial (fuera del radio de la barra)
y_tornillo = barra/2 + grosor + 3;
// -------- modelo --------
difference() {
// ====== SÓLIDOS ======
union() {

    // anillo
    cylinder(h=ancho, d=barra + 2*grosor + holgura);

    // placa frontal (para el triángulo)
    translate([-placa_ancho/2, -(barra/2 + grosor + placa_espesor), 0])
        cube([placa_ancho, placa_espesor, placa_alto]);

    // refuerzos laterales (gussets)
    hull() {
        translate([-placa_ancho/2, -(barra/2 + grosor), 0])
            cube([4,2,ancho]);
        translate([-6,0,0])
            cylinder(h=ancho, d=12);
    }
    hull() {
        translate([placa_ancho/2-4, -(barra/2 + grosor), 0])
            cube([4,2,ancho]);
        translate([6,0,0])
            cylinder(h=ancho, d=12);
    }

    // orejas exteriores para tornillos tangenciales
    for (z = z_bolts) {
        translate([-10, y_tornillo-4, z-6])
            cube([20, 8, 12]);
    }
}

// ====== HUECOS ======

// interior barra (libre)
translate([0,0,-1])
    cylinder(h=ancho+2, d=barra + holgura);

// ranura de cierre (arriba)
translate([-gap/2, barra/2, 0])
    cube([gap, 20, ancho]);

// ---- tornillos de la abrazadera (FIX REAL COMPLETO) ----
for (z = z_bolts) {
// agujero pasante TOTAL (sale por ambos lados)
translate([0, y_tornillo, z])
rotate([0,90,0])
    cylinder(h=200, d=d_m3 + clearance, center=true);

// cavidad tuerca (solo lado derecho)
translate([+12, y_tornillo, z])
rotate([0,90,0])
    cylinder(h=tuerca_h + 0.6, d=tuerca_m3 + clearance, $fn=6);
}

// ---- placa: 2 tornillos m3 para el triángulo ----
for (z=[15,35]) {

    // paso tornillo
    translate([0, -(barra/2 + grosor + placa_espesor/2), z])
    rotate([90,0,0])
        cylinder(h=placa_espesor+2, d=d_m3 + clearance);

    // cavidad tuerca (parte trasera de la placa)
    translate([0, -(barra/2 + grosor + placa_espesor + 0.2), z])
    rotate([90,0,0])
        cylinder(h=tuerca_h + 0.6, d=tuerca_m3 + clearance, $fn=6);
}
}