// crosspiece.scad — Travesaño desmontable para guía de filamento
$fn=80;

spool_separation = 85;
espesor = 12;
guide_z = espesor + spool_separation / 2 - post_w;
eyelet_id = 5;
eyelet_ptfe_id = 4.1;
arm_d = 10;
post_w = 14;
post_x = 7;
dovetail_top = 140;
dovetail_bottom = 125;
eyelet_x = 42.5;
eyelet_y = 140;

difference() {
    union() {
        // Lengüeta cola de milano
        hull() {
            translate([10, dovetail_bottom, guide_z - 4.9])
                cube([0.1, dovetail_top - dovetail_bottom, 9.8]);
            translate([14, dovetail_bottom, guide_z - 3.9])
                cube([0.1, dovetail_top - dovetail_bottom, 7.8]);
        }

        // Brazo horizontal rectangular (conecta lengüeta al anillo por el lateral)
        hull() {
            translate([14, dovetail_top - 5, guide_z - 4])
                cube([0.1, 5, 8]);
            translate([eyelet_x - arm_d*1.1/2, dovetail_top - 5, guide_z - 4])
                cube([0.1, 5, 8]);
        }

        // Anillo exterior del ojal (cilindro a lo largo de Y)
        translate([eyelet_x, eyelet_y, guide_z])
            rotate([-90, 0, 0])
                cylinder(d=arm_d*1.1, h=8, center=true);
    }

    // Agujero cónico vertical (a lo largo de Y): Ø5mm (arriba, +Y) → Ø4.1mm (abajo, -Y)
    translate([eyelet_x, eyelet_y, guide_z])
        rotate([-90, 0, 0])
            cylinder(d1=eyelet_ptfe_id, d2=eyelet_id, h=8, center=true);
}
