// striangulo_integrado_v6.scad
// Versión aligerada: estructura triangular hueca con aristas reforzadas
$fn=80;

// =====================
// CONFIGURACIÓN
// =====================
lado = "fijo"; // "fijo" o "libre"
diam_eje = (lado == "fijo") ? 8.2 : 8.5;


// =====================
// PARÁMETROS
// =====================
altura_objetivo = 110;
offset_abrazadera = 16;

prof = 179;
espesor = 12;

// base anclaje
ancho_base = 42;
alto_base = 50;
esp_base = 8;

// bloque eje
bloque = 28;
radio_bloque = bloque/2;

altura = (altura_objetivo - offset_abrazadera) - 25;

// diámetro de las aristas del triángulo
diam_arista = 14;
// diámetro de los nodos (vértices)
diam_nodo = 26;

// ---------------------
// MÓDULOS DEL TRIÁNGULO
// ---------------------
module nodo(x,y){
    translate([x,y,0])
        cylinder(h=espesor, d=diam_nodo);
}

module arista(x1, y1, x2, y2){
    hull(){
        translate([x1, y1, 0]) cylinder(h=espesor, d=diam_arista);
        translate([x2, y2, 0]) cylinder(h=espesor, d=diam_arista);
    }
}


// =====================
// MODELO COMPLETO
// =====================
difference(){

    union(){

        // ============================================
        // TRIÁNGULO ESTRUCTURAL HUECO
        // En lugar de un hull() macizo, usamos vigas
        // en las aristas y nodos reforzados en los vértices.
        // ============================================

        // NODOS (vértices reforzados)
        nodo(0,0);
        nodo(prof,0);
        nodo(prof/2,altura);

        // ARISTAS (vigas entre nodos)
        arista(0,0, prof,0);          // arista base
        arista(0,0, prof/2,altura);   // arista lateral izquierda
        arista(prof,0, prof/2,altura); // arista lateral derecha

        // BASE DELANTERA (igual)
        translate([-ancho_base/2, -esp_base - espesor, 0])
        difference(){
            cube([ancho_base, esp_base, alto_base]);
            for (z=[15,35])
            translate([ancho_base/2, esp_base/2, z])
            rotate([90,0,0])
                cylinder(h=esp_base+4, d=4.2, center=true);
        }

        // BASE TRASERA (igual)
        translate([prof-ancho_base/2, -esp_base - espesor, 0])
        difference(){
            cube([ancho_base, esp_base, alto_base]);
            for (z=[15,35])
            translate([ancho_base/2, esp_base/2, z])
            rotate([90,0,0])
                cylinder(h=esp_base+4, d=4.2, center=true);
        }

        // BLOQUE DEL EJE (sin agujero)
        translate([prof/2 - radio_bloque, altura - radio_bloque, 0])
            cube([bloque,bloque,espesor]);

        // NERVIOS (se mantienen para rigidez)
        hull(){
            translate([10,0,espesor])
                cube([6,6,6]);

            translate([prof/2 ,altura,espesor])
                cube([6,6,6]);
        }

        hull(){
            translate([prof-15,0,espesor])
                cube([6,6,6]);

            translate([prof/2,altura,espesor])
                cube([6,6,6]);
        }
    }


    // =====================
    // AGUJERO DEL EJE (GLOBAL)
    // =====================
    translate([prof/2, altura, espesor/2])
        cylinder(h=bloque+6, d=diam_eje, center=true);
}
