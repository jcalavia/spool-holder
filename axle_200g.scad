// casquillo_608_ENDER.scad
$fn=160;
outer = 55.6;
bearing = 22.15;
width = 42;
difference(){
  cylinder(h=width, d=outer);
  
  translate([0,0,0])
    cylinder(h=7.2, d=bearing);

  translate([0,0,width-7.2])
    cylinder(h=7.2, d=bearing);

  translate([0,0,-1])
    cylinder(h=width+2, d=8.2);
}