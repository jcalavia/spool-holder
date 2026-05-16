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

// guía de filamento (solo lado libre)
spool_separation = 85;       // separación entre las dos piezas triangulares
guide_z = spool_separation / 2;  // centro del ancho de la bobina
eyelet_pos = [55, 110];      // [X, Y] del ojal (hacia el frente desde el eje)
eyelet_id = 5;               // diámetro interior del ojal (para filamento 1.75mm)
eyelet_ptfe_id = 4.1;        // diámetro para insertar tubo PTFE (4mm OD) a presión
arm_d = 10;                  // diámetro del brazo guía

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

// ---------------------
// GUÍA DE FILAMENTO (solo lado libre)
// ---------------------
module filament_guide(){
    // Brazo curvo desde el soporte del eje hasta la parte inferior del anillo
    // (offset Y = -8 para conectar por debajo del ojal sin obstruir el agujero)
    hull(){
        translate([prof/2, altura, 0])
            cylinder(d=arm_d, h=1);
        translate([eyelet_pos[0], eyelet_pos[1] - 8, guide_z])
            sphere(d=arm_d);
    }

    // Ojal guía con agujero escalonado en dirección X
    // - Lado +X (hacia la bobina): Ø5mm  → entrada del filamento 1.75mm
    // - Lado -X (hacia el frente):  Ø4.1mm → salida para tubo PTFE 4mm OD
    translate([eyelet_pos[0], eyelet_pos[1], guide_z])
        difference(){
            rotate([0, 90, 0])
                cylinder(d=arm_d*1.2, h=8, center=true);

            // Entrada (bobina, lado +X): filamento 1.75mm
            translate([2, 0, 0])
            rotate([0, 90, 0])
                cylinder(d=eyelet_id, h=4.1, center=true);

            // Salida (frente, lado -X): tubo PTFE 4mm
            translate([-2, 0, 0])
            rotate([0, 90, 0])
                cylinder(d=eyelet_ptfe_id, h=4.1, center=true);
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

        // GUÍA DE FILAMENTO (solo lado libre)
        if (lado == "libre") {
            filament_guide();
        }
    }


    // =====================
    // AGUJERO DEL EJE (GLOBAL)
    // =====================
    translate([prof/2, altura, espesor/2])
        cylinder(h=bloque+6, d=diam_eje, center=true);
}
