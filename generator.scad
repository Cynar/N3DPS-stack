// Hacked together Script to generate printable stacks of N3DPS v7 masks. Masks are unchanged from the original, just some supports added to make it print.
// Paul Hegarty cynar@hotmail.com 27/4/2020

/**********************************************************************************************************************************************/


TAG=0.29;                  // Height of support tags (OpenSCAD has issues if it intersects the STL, should be just smaller than GAP
GAP=0.3;                   // Gap between masks in stack. Should be 1 layer height.

TAG_COUNT=72;              // Number of support tags, more is better for printing, but more cleanup when finished
TAG_ROTATE=0;              // Offsets the tag positions to avoid awkward locations
TAG_THICKNESS=0.3;         // Thicknes of the tags, Should be 1-2 print widths
TAG_CLEARANCE=0.25;        // Inset of the support tags to avoid sharp edges to forehead


TAB_SUPPORT_THICKNESS=0.4; // Thickness of tab sides. Should be 1-2 print widths
TAB_ROOF=0.6;              // Thickness of tab top. Should be 1-2 layers


STACK=3;                   // How many masks in stack.


/**********************************************************************************************************************************************/


MASK_HEIGHT=10+GAP;


/**********************************************************************************************************************************************/


initial();
for (i=[1:STACK-1]){
   translate([0,0,MASK_HEIGHT*i]) upper(); 
}

//support(29);
//support_mask_maker();


/**********************************************************************************************************************************************/
/**********************************************************************************************************************************************/
/**********************************************************************************************************************************************/


module upper(){
    height=-GAP/2;
    union(){
        translate([-296.25,0,0]) import("N3DPS v7-fixed.stl");
 
        color("red")   translate([0,0,height]) support(TAG);
        color("grey")                          front_tag();
        color("green") mirror([1,0,0])         front_tag();
        color("orange")                        side_tag();
        color("blue")  mirror([1,0,0])         side_tag();
        
                
    }

}

module initial(){
    translate([-296.25,0,0]) import("N3DPS v7-fixed.stl");
}


module front_tag() {
        translate([-38.55,-91.8,-6]) difference(){
            hull(){
                translate([-(1.45-TAB_SUPPORT_THICKNESS),TAB_SUPPORT_THICKNESS-0.4,0]) cylinder(r=TAB_SUPPORT_THICKNESS+0.1,h=5.7,center=false,$fn=50);
                translate([+1.45-TAB_SUPPORT_THICKNESS,TAB_SUPPORT_THICKNESS-0.4,0]) cylinder(r=TAB_SUPPORT_THICKNESS+0.1,h=5.7,center=false,$fn=50);
                translate([0,6,5.7/2]) rotate([0,0,-29]) cube(size=[3.6,0.001,5.7],center=true);
            }
            
            hull(){
                translate([-(1.45-TAB_SUPPORT_THICKNESS),TAB_SUPPORT_THICKNESS-0.4,-TAB_ROOF]) cylinder(r=0.1,h=5.7,center=false,$fn=50);
                translate([+1.45-TAB_SUPPORT_THICKNESS,TAB_SUPPORT_THICKNESS-0.4,-TAB_ROOF]) cylinder(r=0.1,h=5.7,center=false,$fn=50);
                translate([0,6.6,5.7/2-TAB_ROOF]) rotate([0,0,-29]) cube(size=[3.6-TAB_SUPPORT_THICKNESS*2,0.01,5.7],center=true);
            }
        }
}

module side_tag(){
    translate([75.9,-17.9,-6]) rotate([0,0,111]) difference(){
        hull(){
            translate([-(1.95-TAB_SUPPORT_THICKNESS),TAB_SUPPORT_THICKNESS-0.5,0]) cylinder(r=TAB_SUPPORT_THICKNESS+0.1,h=5.7,center=false,$fn=50);
            translate([+(1.95-TAB_SUPPORT_THICKNESS),TAB_SUPPORT_THICKNESS-0.5,0]) cylinder(r=TAB_SUPPORT_THICKNESS+0.1,h=5.7,center=false,$fn=50);
            translate([0,4.5,5.7/2]) rotate([0,0,-15.5]) cube(size=[4.1,0.001,5.7],center=true);
        }
        
        hull(){
            translate([-(1.95-TAB_SUPPORT_THICKNESS),TAB_SUPPORT_THICKNESS-0.5,-TAB_ROOF]) cylinder(r=0.1,h=5.7,center=false,$fn=50);
            translate([(1.95-TAB_SUPPORT_THICKNESS),TAB_SUPPORT_THICKNESS-0.5,-TAB_ROOF]) cylinder(r=0.1,h=5.7,center=false,$fn=50);
            translate([0,4.5,5.7/2-TAB_ROOF]) rotate([0,0,-15.5]) cube(size=[4.1-TAB_SUPPORT_THICKNESS*2,0.01,5.7],center=true);
        }
    }
}

module support(H){  
    linear_extrude(height=H, center=true) render() intersection(){
        support_mask_maker();
        union(){
            for (i=[0:TAG_COUNT]){
                rotate([0,0,TAG_ROTATE+(360/TAG_COUNT)*i]) translate([-TAG_THICKNESS/2,0]) square(size=[TAG_THICKNESS,200],center=false);
            }
            rotate([0,0,+12.7]) translate([-TAG_THICKNESS/2,0]) square(size=[TAG_THICKNESS,200],center=false);   
            rotate([0,0,-12.7]) translate([-TAG_THICKNESS/2,0]) square(size=[TAG_THICKNESS,200],center=false);   
        }
    }
}

module support_mask_maker(){
    render() difference(){
        square(size=[249,249],center=true);
        minkowski(){
            difference(){
                square(size=[250,250],center=true);
                projection() {
                    difference(){
                        translate([-296.25,0,0]) import("N3DPS v7-reduced.stl");
                        translate([0,0,4.9]) cube(size=[500,500,10],center=true);
                    }
                }
            }
            circle(r=TAG_CLEARANCE);
        }
    }
}   
    