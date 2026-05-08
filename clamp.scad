// clip_barra_v19_FINAL_v2.scad
$fn=120;

// =====================================================
// CONFIGURACIÓN
// =====================================================

// elegir:
// "derecha"  -> hex visible derecha
// "izquierda" -> hex visible izquierda
lado_tuerca = "izquierda";


// =====================================================
// PARÁMETROS
// =====================================================

// barra
barra = 19.2;
holgura = 0.3;

// cuerpo
grosor = 8;
ancho = 24;

// placa base
placa_ancho = 42;
placa_espesor = 8;
placa_alto = 50;

// ranura
gap = 3;

// tornillería
d_m3 = 3.2;
clearance = 0.2;

// tuerca M3
tuerca_m3 = 5.3;
tuerca_h  = 2.6;
clearance_hex = 0.25;

// hexágono
hex_af = tuerca_m3 + clearance_hex;
hex_d  = 2 * hex_af / sqrt(3);

// posiciones
z_bolts = [ancho*0.33, ancho*0.66];
y_tornillo = barra/2 + grosor + 3;

// orejas
oreja_offset = 12;


// =====================================================
// CONFIGURACIÓN VARIABLE IZQ / DER
// =====================================================

hex_ext_x = (lado_tuerca == "izquierda")
    ? +oreja_offset
    : -oreja_offset;

hex_int_x = (lado_tuerca == "izquierda")
    ? -oreja_offset
    : +oreja_offset;


// =====================================================
// MODELO
// =====================================================

difference() {

    // =================================================
    // CUERPO PRINCIPAL
    // =================================================
    union() {

        // cuerpo abrazadera
        cylinder(
            h = ancho,
            d = barra + 2*grosor + holgura
        );

        // placa base
        translate([
            -placa_ancho/2,
            -(barra/2 + grosor + placa_espesor),
            0
        ])
        cube([
            placa_ancho,
            placa_espesor,
            placa_alto
        ]);

        // oreja izquierda
        hull() {

            translate([
                -placa_ancho/2,
                -(barra/2 + grosor),
                0
            ])
            cube([4,2,ancho]);

            translate([-6,0,0])
                cylinder(h=ancho, d=12);
        }

        // oreja derecha
        hull() {

            translate([
                placa_ancho/2-4,
                -(barra/2 + grosor),
                0
            ])
            cube([4,2,ancho]);

            translate([6,0,0])
                cylinder(h=ancho, d=12);
        }

        // unión orejas
        for (z = z_bolts) {

            translate([
                -10,
                y_tornillo-4,
                z-6
            ])
            cube([20, 8, 12]);
        }
    }


    // =================================================
    // INTERIOR BARRA
    // =================================================
    translate([0,0,-1])
        cylinder(
            h = ancho+2,
            d = barra + holgura
        );


    // =================================================
    // RANURA
    // =================================================
    translate([
        -gap/2,
        barra/2,
        0
    ])
    cube([
        gap,
        20,
        ancho
    ]);


    // =================================================
    // OREJAS + HEX
    // =================================================
    for (z = z_bolts) {

        // paso tornillo
        translate([0, y_tornillo, z])
        rotate([0,90,0])
            cylinder(
                h = 200,
                d = d_m3 + clearance,
                center = true
            );

        // HEX EXTERIOR
        translate([hex_ext_x, y_tornillo, z])
        rotate([0,90,0])
            cylinder(
                h = 4,
                d = hex_d,
                $fn = 6,
                center = true
            );

        // CAPTURA INTERIOR
        translate([hex_int_x, y_tornillo, z])
        rotate([0,90,0])
            cylinder(
                h = tuerca_h + 0.2,
                d = hex_d,
                $fn = 6,
                center = true
            );
    }


    // =================================================
    // BASE HEXAGONAL
    // =================================================
    for (z=[15,35]) {

        // hex pasante visible
        translate([
            0,
            -(barra/2 + grosor + 0.01),
            z
        ])
        rotate([90,0,0])
            cylinder(
                h = placa_espesor + 1,
                d = hex_d,
                $fn = 6
            );

        // captura trasera
        translate([
            0,
            -(barra/2 + grosor + placa_espesor + 0.01),
            z
        ])
        rotate([90,0,0])
            cylinder(
                h = tuerca_h + 0.2,
                d = hex_d,
                $fn = 6
            );
    }
}