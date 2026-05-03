// clip_barra_v14_HEX_TIGHT.scad
$fn=120;

// -------- parámetros --------
barra = 19.2;
holgura = 0.3;
grosor = 8;
ancho = 24;

// placa
placa_ancho = 42;
placa_espesor = 8;
placa_alto = 50;

// ranura
gap = 3;

// tornillería m3
d_m3 = 3.2;
tuerca_m3 = 6.3;   // ENTRE CARAS REAL
tuerca_h = 2.6;

// 🔴 HEX CORRECTO (sin inflar AF)
hex_af = tuerca_m3;
hex_d = 2 * hex_af / sqrt(3);

// ajuste fino real (CLAVE)
hex_d_adjusted = hex_d + 0.10;

// posiciones
z_bolts = [ancho*0.33, ancho*0.66];
y_tornillo = barra/2 + grosor + 3;
oreja_offset = 12;


// -------- modelo --------
difference() {

// ===== sólidos =====
union() {

    cylinder(h=ancho, d=barra + 2*grosor + holgura);

    translate([-placa_ancho/2, -(barra/2 + grosor + placa_espesor), 0])
        cube([placa_ancho, placa_espesor, placa_alto]);

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

    for (z = z_bolts) {
        translate([-10, y_tornillo-4, z-6])
            cube([20, 8, 12]);
    }
}

// ===== huecos =====

// tubo interior
translate([0,0,-1])
    cylinder(h=ancho+2, d=barra + holgura);

// ranura
translate([-gap/2, barra/2, 0])
    cube([gap, 20, ancho]);


// ===== OREJAS =====
for (z = z_bolts) {

    // paso tornillo (circular)
    translate([0, y_tornillo, z])
    rotate([0,90,0])
        cylinder(h=200, d=d_m3 + 0.2, center=true);

    // hex exterior visible
    translate([-oreja_offset, y_tornillo, z])
    rotate([0,90,0])
        cylinder(h=4, d=hex_d_adjusted, $fn=6);

    // hex interior (tuerca)
    translate([+oreja_offset, y_tornillo, z])
    rotate([0,90,0])
        cylinder(h=tuerca_h + 0.6, d=hex_d_adjusted, $fn=6);
}


// ===== PLACA =====
for (z=[15,35]) {

    // agujero hex
    translate([0, -(barra/2 + grosor + placa_espesor/2), z])
    rotate([90,0,0])
        cylinder(h=placa_espesor+2, d=hex_d_adjusted, $fn=6);

    // cavidad trasera
    translate([0, -(barra/2 + grosor + placa_espesor + 0.2), z])
    rotate([90,0,0])
        cylinder(h=tuerca_h + 0.6, d=hex_d_adjusted, $fn=6);
}

}