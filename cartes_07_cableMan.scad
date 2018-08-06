
detail=60;

//z position of main bolts (holding rollers)
boltZ = -6;

//belt & pulleys
beltWide = 6;
beltSpce = 16;
beltThic = 1.3;
beltToothDep = beltThic - 1.6;
pulleyDiam = 14;
pulleyShift = pulleyDiam/2+beltSpce/2;
bearingDep = 4;


//narrow rail (z-pos)
//(defined)
narrRailZ = 21; ////////

//rail height
railHeight = 20;

//narrow rail width
narrRailWide = 20;
//wide rail width
wideRailWide = 40;

//roller full diameter
rollerDiam = 15.35;
//roller height
rollerHeight = 9;

//bolt centreline spacing from rail (roller bearing rolling radius)
//(bearing+rail)-(rail)-(roller radius)
railBearingRadius = 54-wideRailWide-(rollerDiam/2);

//height of narrow rail bearings from zero ref
//(narrow rail Z) + (rail height/2) - (roller height / 2)
narrRailBearingZ = narrRailZ + railHeight/2 - rollerHeight/2;
wideRailBearingY = railBearingRadius + narrRailWide + railBearingRadius;

//height of wide rail bearings from zero ref (bottom of wide rail)
//(centreline of rail) - (half roller height)
wideRailBearingZ = railHeight/2-rollerHeight/2;
wideRailBearingBaseY = 50;
wideRailBearingBackY = -(wideRailBearingBaseY-wideRailBearingY);
wideRailBearingX = railBearingRadius + wideRailWide + railBearingRadius;

//narrow rail (y-pos)
narrRailY = railBearingRadius;

//z position of belt pulleys
pulleyZ = narrRailZ+railHeight+1;

//base and main mount dimensions
baseFullThick = 15;
baseRollerSupportZ1 = 15.46;    //short support
baseRollerSupportZ2 = 36.4;    //long support
baseRollerSupportD1 = 8;        //inner, contacts bearing
baseRollerSupportD2 = 15;       //outer, for strength
baseEdgePad = 10;
railClearance = 1;

//upper dimensions
upperZ = 50.4;
upperFullThick = 5;
upperRollerSupportZ1 = 40.85;    //short support
upperRollerSupportZ2 = 19.8;    //long support
upperRollerSupportD1 = 8;        //inner, contacts bearing
upperRollerSupportD2 = 15;       //outer, for strength
upperEdgePad = 10;
upperPulleySupportZ = 15;//9.5-4.6+0.4;
upperPulleySupportD = 7;


//***********************************************************************************************
//ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEM

//wide rail bearings
translate([0,wideRailBearingBackY,wideRailBearingZ])vRoller();
translate([0,wideRailBearingBaseY,wideRailBearingZ])vRoller();
translate([wideRailBearingX,wideRailBearingBackY,wideRailBearingZ])vRoller();
translate([wideRailBearingX,wideRailBearingBaseY,wideRailBearingZ])vRoller();

//narrow rail bearings
translate([0,0,narrRailBearingZ])vRoller();
translate([wideRailBearingX,0,narrRailBearingZ])vRoller();
translate([0,wideRailBearingY,narrRailBearingZ])vRoller();
translate([wideRailBearingX,wideRailBearingY,narrRailBearingZ])vRoller();







//Carriage: ASSEMBLY DETAILS
carriageBolts(0,0);
beltBolts(0,0);
rollers(0);
pulleys();
belts();


translate([200,narrRailY,narrRailZ])rotate([0,0,90])railNarr(0,0);
translate([railBearingRadius,-100,0])railWide(0,0);


//MAIN ASSEMBLIES - assembly arrangement
baseAssembly();
upperAssembly();

//far end
translate([6.5,-100,0])endAssembly();
translate([5.4,-163,-12])stepper();

//home end
translate([53.5,60,0])rotate([0,0,180]) {
    translate([6.5,-100,0])endAssembly();
    translate([5.4,-163,-12])stepper();
}
//

returnPulleyMount();

translate([-164-7.2,-8,25])rotate([0,90,180])9g_servo(1,-60); //top -110, bottom -60
translate([-164,-8,25])rotate([0,90,180])9g_servo(1,-90);
translate([-175.1,0,0])penLift_base();
translate([-175.1,0,0])penLift_carriage();
translate([-175.1,0,0])penLift_holder();
translate([-150-10,narrRailY+narrRailWide/2,narrRailZ+railHeight+16])rotate([0,180,0])import("smallReturnPulley.stl");

beltClampMount();

//end cable manager
translate([-169,33,18])cableMan();
//central cable manager 1 & 2
translate([32,55,55])rotate([0,0,180])cableMan();
translate([32.5,-25,55])rotate([0,0,90])cableMan();
//home cable manager
translate([57,200,25])rotate([0,0,-90])cableMan();

floorLevel();
//
//ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEMBLY ASSEM
//***********************************************************************************************


//***********************************************************************************************
//PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT 
//render one-by-one for printing, orientations should be OK for print

//rotate([0,180,0])upperAssembly();
//baseAssembly();

//pulleys();

//rotate([90,0,0])endBase();

//rotate([180,0,0])endStepperMount();

//returnPulleyMount();

//beltClampMount();

//vertical lift pen mount parts
//rotate([0,90,0])penLift_base();
//rotate([0,90,0])penLift_holder();
//rotate([0,-90,0])penLift_carriage();

//washer();

//cableMan();

//PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT PRINT 
//***********************************************************************************************


//MAIN UPPER SECTION
module upperAssembly() {
    difference() {
        union() {
            translate([-baseEdgePad,wideRailBearingBackY-baseEdgePad,upperZ])upper();
            upperRollerSupports();
        }
        carriageBolts(1,0.5);
        beltBolts(0,-0.5);
        //fitting hole at centre for belts (NOT easy to thread without)
        translate([-baseEdgePad,wideRailBearingBackY-baseEdgePad,upperZ])translate([(wideRailWide+2*railBearingRadius+baseEdgePad*2)/2,(wideRailBearingBaseY-wideRailBearingBackY+baseEdgePad*2)/2,0])cylinder(h=upperFullThick,d=32,$fn=detail);
    }
}
//

module baseAssembly() {
    //MAIN BASE SECTION
    union() {
        difference() {
            union() {
                //base
                translate([-baseEdgePad,wideRailBearingBackY-baseEdgePad,-10])base();
                //side-side adjustments, pad ups
                //  wide rails
                translate([-baseEdgePad-5,wideRailBearingBackY-5,-10])cube([6,10,baseFullThick]);
                translate([-baseEdgePad-5,wideRailBearingBaseY-5,-10])cube([6,10,baseFullThick]);
                //  narrow rails
                translate([wideRailBearingX,0,-10])rotate([0,0,-45])translate([0,-8/2,0])cube([15,8,35]);
                translate([0,0,-10])rotate([0,0,-135])translate([0,-8/2,0])cube([15,8,35]);
                
                //roller supports
                translate([0,0,-10])baseRollerSupports();
                //bracing
                difference() {
                    union() {
                        translate([-baseRollerSupportD2/2,0,0])cube([20,wideRailBearingY,20]);
                        translate([wideRailBearingX-20+baseRollerSupportD2/2,0,0])cube([20,wideRailBearingY,20]);
                    }
                    translate([railBearingRadius,-50,0])railWide(railClearance*2,30);
                }
            }
            carriageBolts(1,0.5);
            rollers(5);
            //adjustment bolt holes
            //  wide rails
            translate([-baseEdgePad-2.5,wideRailBearingBackY,0])rotate([0,90,0])boltHole(3,6.5,12,2.2);
            translate([-baseEdgePad-2.5,wideRailBearingBaseY,0])rotate([0,90,0])boltHole(3,6.5,12,2.2);
            //  narrow rails
            translate([wideRailBearingX,0,20])rotate([0,-90,-45])translate([0,0,-13])boltHole(3,6.5,12,2.2);
            translate([0,0,20])rotate([0,-90,-135])translate([0,0,-13])boltHole(3,6.5,12,2.2);
            
        }
        //print support for overhang of bolts above head diameter
        translate([-baseEdgePad,wideRailBearingBackY-baseEdgePad,-10+4.00])cube([wideRailWide+2*railBearingRadius+baseEdgePad*2,wideRailBearingBaseY-wideRailBearingBackY+baseEdgePad*2,0.2]);
    }
}
//

module endAssembly() {
    endBase();
    translate([-10,-70-10+15,20+10])endStepperMount();
}
//

module cableMan() {
    color([0.8,0.5,0.2])difference() {
        cube([25,12,12]);
        //pipe hole
        translate([10.3,6,-2])rotate([0,15,0])cylinder(h=20,d=5,$fn=detail);
        //pipe clamp
        translate([12.5,12,6])rotate([90,0,0])cylinder(h=12,d=2,$fn=detail);
        //mounting bolts
        translate([25-5,12-3,6])rotate([90,0,0])boltHole(15,6,12,3.1);
        translate([5,12-3,6])rotate([90,0,0])boltHole(15,6,12,3.1);
        translate([25-5,6,12-3])rotate([180,0,0])boltHole(15,6,12,3.1);
        translate([5,6,12-3])rotate([180,0,0])boltHole(15,6,12,3.1);
    }
}
//

module returnPulleyMount() {
    returnSide = 7;
    
    translate([-150-10-10,narrRailY-returnSide,narrRailZ-5]) {
        difference() {
            union() {
                difference() {
                    cube([50,narrRailWide+returnSide+returnSide,railHeight+5]);
                    translate([20,returnSide-0.25,5-0.25])cube([50,narrRailWide+0.5,railHeight+0.5]);
                }
                translate([30,returnSide+20/2-5/2-0.5/2,0]) {
                    translate([0,1/2,7])hull() {
                        translate([0,-3/2,2])cube([20,8,1]);
                        translate([0,0,0])cube([20,5,1]);
                    }
                    cube([20,6,10]);
                }
            }
            //side mounting bolts
            translate([20+10,returnSide-12+6+0.5,5+railHeight/2])rotate([-90,0,0])boltHole(3,6.5,12,2);
            translate([50-10,returnSide-12+6+0.5,5+railHeight/2])rotate([-90,0,0])boltHole(3,6.5,12,2);
            translate([20+10,returnSide+returnSide+narrRailWide+12-returnSide-6-0.5,5+railHeight/2])rotate([90,0,0])boltHole(3,6.5,12,2);
            translate([50-10,returnSide+returnSide+narrRailWide+12-returnSide-6-0.5,5+railHeight/2])rotate([90,0,0])boltHole(3,6.5,12,2);
            //return pully mount
            translate([10,returnSide+narrRailWide/2+0.5/2,railHeight+5])rotate([180,0,0])boltHole(3,6.5,30,2);
            //lift mounting bolts
            translate([-5,0,-11]) {
                translate([3.5,28,30])rotate([0,90,0])boltHole(4,6.8,20,2);
                translate([3.5,6,15])rotate([0,90,0])boltHole(4,6.8,20,2);
            }
        }
    }
}
//

module penLift_base() {
    translate([0,-0.7,5]) {
        difference() {
            union() {
                //base plate
                cube([5,20+7+7,40]);
                //bottom servo mount
                translate([0,-14,0])cube([5,15,8]);
                //top servo mount
                translate([0,-14,32])cube([5,15,8]);
                //lift guide bolts
                translate([-8,10,8])cube([5+8,28,15]);
            }
            //mounting bolts
            translate([3.5,28,30])rotate([0,90,0])boltHole(4,6.8,12,3.25);
            translate([3.5,6,15])rotate([0,90,0])boltHole(4,6.8,12,3.25);
            //servo mount bolts
            translate([7,-7.5,37.5])rotate([0,-90,0])boltHole(4,5.5,12,2.5);
            translate([7,-7.5,2])rotate([0,-90,0])boltHole(4,5.5,20,2.5);
            //top carve away
            translate([-1,5,42])rotate([0,90,0])hull() {
                cylinder(h=10,d=12,$fn=detail);
                translate([0,30,0])cylinder(h=10,d=12,$fn=detail);
            }
            //lift guide bolts
            translate([0,-12,0]) {
                //bottom
                translate([-5,40+10-4,-11.5])boltHole(3,5.5,35,2.5);
                translate([-5,40+10-4-15,-11.5])boltHole(3,5.5,35,2.5);
                //top
                translate([-5,40+10-4,-11.5])translate([0,-5,35+19])rotate([180,0,0])boltHole(3,5.5,35,2.5);
                translate([-5,40+10-4-15,-11.5])translate([0,-5,35+19])rotate([180,0,0])boltHole(3,5.5,35,2.5);
            }
//            //bearing bolt
//            #translate([-20,27+6+8,6])rotate([0,90,0])boltHole(5,8.36,25,4.2);
        }
    }
}
//

module penLift_carriage() {
    difference() {
        union() {
            translate([0,0,-11])translate([-11,9.3,5]) {
                cube([2,28,42]);
                translate([0,0,0])cube([10,28,7]);
                translate([0,0,42-7])cube([10,28,7]);
            }
        }
        translate([0,-12.7,0]) {
            //guide bolts
            //bottom
            translate([-5,40+10-4,-11.5])boltHole(3,5.5,35,3);
            translate([-5,40+10-4-15,-11.5])boltHole(3,5.5,35,3);
            //top
            translate([-5,40+10-4,-11.5])translate([0,-5,35+19])rotate([180,0,0])boltHole(3,5.5,35,3);
            translate([-5,40+10-4-15,-11.5])translate([0,-5,35+19])rotate([180,0,0])boltHole(3,5.5,35,3);
            //mounting holes
            translate([-14.2,22.7,-6]) {
                translate([2,12,39])rotate([0,90,0])boltHole(5,6.1,15,2);
                translate([2,12,3])rotate([0,90,0])boltHole(5,6.1,15,2);
            }
            
        }
    }
}
//

//NOT USED FOR VERTICAL LIFT
module penLift_arm() {
    difference() {
        union() {
            difference() {
                union() {
                    translate([-16,26,-10])cube([10,12,5]);
                    translate([-11,26.3+6+8,-15])cylinder(h=4+4+2,d=10+2+2,$fn=detail);
                }
                translate([-11,26.3+6+8,-15])cylinder(h=4+4+2,d=10,$fn=detail);
            }
            translate([-11,26.3+6+8,-15+4])cylinder(h=2,d=10,$fn=detail);
            penLift_holder();
            translate([-16-12,-13,-10])cube([5,25,5]);
        }
        translate([-11,26.3+6+8,-15+4])cylinder(h=2,d1=8,d2=10,$fn=detail);
    }
}
//

module penLift_holder() {
    union() {
        holdLen = 42;
        translate([-14.2,10,-6])rotate([0,0,0]) {
            difference() {
                union() {
                    difference() {
                        translate([-15+3,0,0])cube([15,18,holdLen]);
                        hull() {
                            translate([-7,10,0])rotate([0,0,360/9])cylinder(h=holdLen,d=15,$fn=6);
                            translate([-7,10+20,0])rotate([0,0,360/9])cylinder(h=holdLen,d=15,$fn=6);
                        }
                    }
                    translate([3,17,0])rotate([0,0,90])cube([5,13,holdLen]);
                    translate([-4,-6,22])cube([7,10,7]);
                }
                //fixing screw
                translate([-6,21,25])rotate([0,90,-90])boltHole(5,6.5,6,2);
                //mounts
                translate([2,12,39])rotate([0,90,0])boltHole(5,6.1,6,3);
                translate([2,12,3])rotate([0,90,0])boltHole(5,6.1,6,3);
            }
        }
    }
    
}
//

module beltClampMount() {
    returnSide = 7;
    
    translate([150+70,returnSide*2+narrRailWide-0.5-0.15,narrRailZ-5])rotate([0,0,180]) {
        difference() {
            union() {
                difference() {
                    cube([50,narrRailWide+returnSide+returnSide,railHeight+5]);
                    translate([20,returnSide-0.25,5-0.25])cube([50,narrRailWide+0.5,railHeight+0.5]);
                }
                translate([30,returnSide+20/2-5/2-0.5/2,0]) {
                    translate([0,1/2,7])hull() {
                        translate([0,-3/2,2])cube([20,8,1]);
                        translate([0,0,0])cube([20,5,1]);
                    }
                    cube([20,6,10]);
                }
                //clamp blocks
                translate([0,returnSide+narrRailWide/2-12/2,railHeight+5])cube([20,12,10]);
                translate([0,returnSide+narrRailWide/2-14/2-5.5-2,railHeight+5])cube([20,5,10]);
                translate([0,returnSide+narrRailWide/2-14/2+14+1.5+1,railHeight+5])cube([20,5,10]);
                translate([0,returnSide,railHeight+5+8])cube([20,20,2]);
            }
            //side mounting bolts
            translate([20+10,returnSide-12+6+0.5,5+railHeight/2])rotate([-90,0,0])boltHole(3,6.5,12,2);
            translate([50-10,returnSide-12+6+0.5,5+railHeight/2])rotate([-90,0,0])boltHole(3,6.5,12,2);
            translate([20+10,returnSide+returnSide+narrRailWide+12-returnSide-6-0.5,5+railHeight/2])rotate([90,0,0])boltHole(3,6.5,12,2);
            translate([50-10,returnSide+returnSide+narrRailWide+12-returnSide-6-0.5,5+railHeight/2])rotate([90,0,0])boltHole(3,6.5,12,2);
            //clamp bolts
            translate([5,3,railHeight+5+2+beltWide/2])rotate([-90,0,0])boltHole(3,6.5,8,2);
            translate([20-5,3,railHeight+5+2+beltWide/2])rotate([-90,0,0])boltHole(3,6.5,8,2);
            translate([5,31,railHeight+5+2+beltWide/2])rotate([90,0,0])boltHole(3,6.5,8,2);
            translate([20-5,31,railHeight+5+2+beltWide/2])rotate([90,0,0])boltHole(3,6.5,8,2);
        }
    }
}
//

module carriageBolts(headClearance,shaftClearance) {
    headD = 8.34+headClearance;
    shaftD = 5+shaftClearance;
    shifty = 70;
    swingy = 1.1;
    spinny = -45;
    
    //end bolt - with adjust
    color([0.4,0.6,0.1])union() {
        translate([0,wideRailBearingBackY,boltZ])boltHole(5,headD,70,shaftD);                  
        translate([0,wideRailBearingBackY,boltZ+shifty])rotate([0,swingy/2,0])translate([0,0,-shifty])boltHole(5,headD,70,shaftD);
        translate([0,wideRailBearingBackY,boltZ+shifty])rotate([0,swingy,0])translate([0,0,-shifty])boltHole(5,headD,70,shaftD);
    }
    
    //end bolt
    translate([wideRailBearingX,wideRailBearingBackY,boltZ])boltHole(5,headD,70,shaftD);

    //mid bolt - with adjust
    color([0.4,0.6,0.1])union() {
        translate([0,0,boltZ])boltHole(5,headD,70,shaftD);
        rotate([0,0,spinny])translate([0,0,boltZ])rotate([swingy,0,0])boltHole(5,headD,70,shaftD);
        rotate([0,0,spinny])translate([0,0,boltZ])rotate([swingy*2,0,0])boltHole(5,headD,70,shaftD);
    }
    
    //end bolt - with adjust
    color([0.4,0.6,0.1])union() {
        translate([0,wideRailBearingBaseY,boltZ])boltHole(5,headD,70,shaftD);
        translate([0,wideRailBearingBaseY,boltZ+shifty])rotate([0,swingy,0])translate([0,0,-shifty])boltHole(5,headD,70,shaftD);
        translate([0,wideRailBearingBaseY,boltZ+shifty])rotate([0,swingy/2,0])translate([0,0,-shifty])boltHole(5,headD,70,shaftD);
    }
    
    //mid bolt - with adjust
    color([0.4,0.6,0.1])union() {
        translate([wideRailBearingX,0,boltZ])boltHole(5,headD,70,shaftD);
        translate([wideRailBearingX,0,0])rotate([0,0,-spinny])translate([0,0,boltZ])rotate([swingy,0,0])boltHole(5,headD,70,shaftD);
        translate([wideRailBearingX,0,0])rotate([0,0,-spinny])translate([0,0,boltZ])rotate([swingy*2,0,0])boltHole(5,headD,70,shaftD);
    }
    
    //end bolt
    translate([wideRailBearingX,wideRailBearingBaseY,boltZ])boltHole(5,headD,70,shaftD);
    
    //mid bolt
    translate([0,wideRailBearingY,boltZ])boltHole(5,headD,70,shaftD);
    
    translate([wideRailBearingX,wideRailBearingY,boltZ])boltHole(5,headD,70,shaftD);
}
//

module beltBolts(headClearance,shaftClearance) {
    //pulleys: cylinder(h=1+beltWide+1,d=pulleyDiam,$fn=detail)
    translate([railBearingRadius+wideRailWide/2-pulleyShift,railBearingRadius+narrRailWide/2-pulleyShift,pulleyZ+(1+beltWide+1)/2-bearingDep/2])boltHole(3,5.15+headClearance,12,3+shaftClearance);
    translate([railBearingRadius+wideRailWide/2-pulleyShift,railBearingRadius+narrRailWide/2+pulleyShift,pulleyZ+(1+beltWide+1)/2-bearingDep/2])boltHole(3,5.15+headClearance,12,3+shaftClearance);
    translate([railBearingRadius+wideRailWide/2+pulleyShift,railBearingRadius+narrRailWide/2-pulleyShift,pulleyZ+(1+beltWide+1)/2-bearingDep/2])boltHole(3,5.15+headClearance,12,3+shaftClearance);
    translate([railBearingRadius+wideRailWide/2+pulleyShift,railBearingRadius+narrRailWide/2+pulleyShift,pulleyZ+(1+beltWide+1)/2-bearingDep/2])boltHole(3,5.15+headClearance,12,3+shaftClearance);
}
//

module base() {
    difference() {
        cube([wideRailWide+2*railBearingRadius+baseEdgePad*2,wideRailBearingBaseY-wideRailBearingBackY+baseEdgePad*2,baseFullThick]);
        translate([(wideRailWide+2*railBearingRadius+baseEdgePad*2)/2-wideRailWide/2-railClearance,0,10-railClearance])cube([wideRailWide+2*railClearance,wideRailBearingBaseY-wideRailBearingBackY+baseEdgePad*2,80]);
    }
}
//

module baseRollerSupports() {
    difference() {
        union() {
            //short supports
            translate([0,wideRailBearingBackY,0])cylinder(h=baseRollerSupportZ1,d=baseRollerSupportD1,$fn=detail);
            translate([wideRailBearingX,wideRailBearingBackY,0])cylinder(h=baseRollerSupportZ1,d=baseRollerSupportD1,$fn=detail);
            
            //long support
            translate([0,0,0])cylinder(h=baseRollerSupportZ2,d=baseRollerSupportD1,$fn=detail);     //inner
            translate([0,0,0])cylinder(h=baseRollerSupportZ2-0.4,d=baseRollerSupportD2,$fn=detail); //outer
            
            //short
            translate([0,wideRailBearingBaseY,0])cylinder(h=baseRollerSupportZ1,d=baseRollerSupportD1,$fn=detail);
            
            //long
            translate([wideRailBearingX,0,0])cylinder(h=baseRollerSupportZ2,d=baseRollerSupportD1,$fn=detail);  //inner
            translate([wideRailBearingX,0,0])cylinder(h=baseRollerSupportZ2-0.4,d=baseRollerSupportD2,$fn=detail);  //outer
            
            //short
            translate([wideRailBearingX,wideRailBearingBaseY,0])cylinder(h=baseRollerSupportZ1,d=baseRollerSupportD1,$fn=detail);
            
            //long supports
            translate([0,wideRailBearingY,0])cylinder(h=baseRollerSupportZ2,d=baseRollerSupportD1,$fn=detail);
            translate([wideRailBearingX,wideRailBearingY,0])cylinder(h=baseRollerSupportZ2,d=baseRollerSupportD1,$fn=detail);
            translate([0,wideRailBearingY,0])cylinder(h=baseRollerSupportZ2-0.4,d=baseRollerSupportD2,$fn=detail);
            translate([wideRailBearingX,wideRailBearingY,0])cylinder(h=baseRollerSupportZ2-0.4,d=baseRollerSupportD2,$fn=detail);
        }
        translate([railBearingRadius,-50,10])railWide(railClearance*2,30);
        translate([100,narrRailY,narrRailZ+10])rotate([0,0,90])railNarr(railClearance*2,0);
    }
}
//

module upper() {
    color([0.5,0.5,1])cube([wideRailWide+2*railBearingRadius+baseEdgePad*2,wideRailBearingBaseY-wideRailBearingBackY+baseEdgePad*2,upperFullThick]);
}
//

module upperRollerSupports() {
    color([0.5,0.5,1])difference() {
        union() {
            //end
            //narrow
            translate([0,wideRailBearingBackY,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ1,d=baseRollerSupportD1,$fn=detail);
            translate([wideRailBearingX,wideRailBearingBackY,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ1,d=baseRollerSupportD1,$fn=detail);
            //wide
            translate([0,wideRailBearingBackY,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ1-0.4,d=baseRollerSupportD2,$fn=detail);
            translate([wideRailBearingX,wideRailBearingBackY,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ1-0.4,d=baseRollerSupportD2,$fn=detail);
            
            //mid
            //narrow
            translate([0,0,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ2,d=upperRollerSupportD1,$fn=detail);     //inner
            translate([0,0,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ2-0.4,d=upperRollerSupportD2,$fn=detail); //outer
            
            //end
            //narrow
            translate([0,wideRailBearingBaseY,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ1,d=baseRollerSupportD1,$fn=detail);
            //wide
            translate([0,wideRailBearingBaseY,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ1-0.4,d=baseRollerSupportD2,$fn=detail);
            
            //mid
            translate([wideRailBearingX,0,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ2,d=upperRollerSupportD1,$fn=detail);  //inner
            translate([wideRailBearingX,0,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ2-0.4,d=upperRollerSupportD2,$fn=detail);  //outer
            
            //end
            //narrow
            translate([wideRailBearingX,wideRailBearingBaseY,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ1,d=baseRollerSupportD1,$fn=detail);
            //wide
            translate([wideRailBearingX,wideRailBearingBaseY,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ1-0.4,d=baseRollerSupportD2,$fn=detail);
            
            //mid
            //narrow
            translate([0,wideRailBearingY,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ2,d=upperRollerSupportD1,$fn=detail);
            translate([wideRailBearingX,wideRailBearingY,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ2,d=upperRollerSupportD1,$fn=detail);
            //wide
            translate([0,wideRailBearingY,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ2-0.4,d=upperRollerSupportD2,$fn=detail);
            translate([wideRailBearingX,wideRailBearingY,upperZ+upperFullThick])rotate([0,180,0])cylinder(h=upperRollerSupportZ2-0.4,d=upperRollerSupportD2,$fn=detail);
            
            
            //bracing
            translate([0,wideRailBearingBackY+baseRollerSupportD2/2,upperZ])rotate([180,0,0])cube([wideRailBearingX,baseRollerSupportD2,25]);
            translate([0,wideRailBearingBaseY+baseRollerSupportD2/2,upperZ])rotate([180,0,0])cube([wideRailBearingX,baseRollerSupportD2,25]);
            
        }
        //clearances
        //rails
        translate([railBearingRadius,-50,10])railWide(railClearance*2,-10);
        translate([100,narrRailY,narrRailZ])rotate([0,0,90])railNarr(railClearance*2,0);
        //pulleys
        translate([railBearingRadius+wideRailWide/2-pulleyShift,railBearingRadius+narrRailWide/2-pulleyShift,pulleyZ-7])cylinder(h=1+beltWide+1+10,d=pulleyDiam+2+1,$fn=detail);
        translate([railBearingRadius+wideRailWide/2-pulleyShift,railBearingRadius+narrRailWide/2+pulleyShift,pulleyZ-7])cylinder(h=1+beltWide+1+10,d=pulleyDiam+2+1,$fn=detail);
        translate([railBearingRadius+wideRailWide/2+pulleyShift,railBearingRadius+narrRailWide/2-pulleyShift,pulleyZ-7])cylinder(h=1+beltWide+1+10,d=pulleyDiam+2+1,$fn=detail);
        translate([railBearingRadius+wideRailWide/2+pulleyShift,railBearingRadius+narrRailWide/2+pulleyShift,pulleyZ-7])cylinder(h=1+beltWide+1+10,d=pulleyDiam+2+1,$fn=detail);
        //belts
        translate([railBearingRadius+wideRailWide/2-pulleyShift+pulleyDiam/2-3,wideRailBearingBackY-baseEdgePad,upperZ-9])cube([6,100,9]);
        translate([railBearingRadius+wideRailWide/2+pulleyShift-pulleyDiam/2-3,wideRailBearingBackY-baseEdgePad,upperZ-9])cube([6,100,9]);
        
    }
}
//

module railWide(pad,extend) {
    color([0.65,0.65,0.65])translate([-pad/2,-pad/2,-pad/2])cube([40+pad,250+pad,20+pad+extend]);
}
//

module railNarr(pad,extend) {
    color([0.65,0.65,0.65])translate([-pad/2,-pad/2,-pad/2])cube([20+pad,350+pad,20+pad+extend]);
}
//

module vRoller(pad) {
    color([0.3,0.3,0.3])union() {
        cylinder(h=1.5,d1=12.36+pad,d2=15.36+pad,$fn=detail);
        translate([0,0,1.5])cylinder(h=6,d=15.36+pad,$fn=detail);
        translate([0,0,1.5+6])cylinder(h=1.5,d2=12.36+pad,d1=15.36+pad,$fn=detail);
    }
}
//

module rollers(padder) {
    //wide rail bearings
    translate([0,wideRailBearingBackY,wideRailBearingZ])vRoller(padder);
    translate([0,wideRailBearingBaseY,wideRailBearingZ])vRoller(padder);
    translate([wideRailBearingX,wideRailBearingBackY,wideRailBearingZ])vRoller(padder);
    translate([wideRailBearingX,wideRailBearingBaseY,wideRailBearingZ])vRoller(padder);

    //narrow rail bearings
    translate([0,0,narrRailBearingZ])vRoller(padder);
    translate([wideRailBearingX,0,narrRailBearingZ])vRoller(padder);
    translate([0,wideRailBearingY,narrRailBearingZ])vRoller(padder);
    translate([wideRailBearingX,wideRailBearingY,narrRailBearingZ])vRoller(padder);
}
//

module pulley(hole) {
    color([0.99,0.99,0.99])difference() {
        union() {
            cylinder(h=1,d1=pulleyDiam+2,d2=pulleyDiam,$fn=detail);
            cylinder(h=1+beltWide+1,d=pulleyDiam,$fn=detail);
            translate([0,0,1+beltWide])cylinder(h=1,d2=pulleyDiam+2,d1=pulleyDiam,$fn=detail);
        }
        cylinder(h=1+beltWide+1,d=6,$fn=detail);
        translate([0,0,(1+beltWide+1)/2-bearingDep/2])cylinder(h=1+beltWide+1,d=hole,$fn=detail);
    }
}
//

module pulleys() {
    //pulleys
    translate([railBearingRadius+wideRailWide/2-pulleyShift,railBearingRadius+narrRailWide/2-pulleyShift,pulleyZ])pulley(10.5);
    translate([railBearingRadius+wideRailWide/2-pulleyShift,railBearingRadius+narrRailWide/2+pulleyShift,pulleyZ])pulley(10.5);
    translate([railBearingRadius+wideRailWide/2+pulleyShift,railBearingRadius+narrRailWide/2-pulleyShift,pulleyZ])pulley(10.5);
    translate([railBearingRadius+wideRailWide/2+pulleyShift,railBearingRadius+narrRailWide/2+pulleyShift,pulleyZ])pulley(10.5);
}
//

module belts() {
    //not perfect, belts do not cross in reality - just to check spacing
    beltLen = 400;
    color([0.3,0.3,0.3])translate([pulleyDiam/2,pulleyDiam/2,43])
    translate([railBearingRadius+wideRailWide/2-pulleyShift,railBearingRadius+narrRailWide/2-pulleyShift,0]) {
        translate([-beltLen/2+beltSpce/2,0,0])cube([beltLen,beltThic,beltWide]);
        translate([-beltLen/2+beltSpce/2,beltSpce-beltThic,0])cube([beltLen,beltThic,beltWide]);
        translate([beltThic,-beltLen/2+beltSpce/2,0])rotate([0,0,90])cube([beltLen,beltThic,beltWide]);
        translate([beltSpce,-beltLen/2+beltSpce/2,0])rotate([0,0,90])cube([beltLen,beltThic,beltWide]);
    }
}
//

module endBase() {
    endPad = 10;
    fixingWidth = 20;
    bottomClearance = 18;
    railInsert = 30;
    countersink = 3;
    fixingDiam = 7;
    difference() {
        union() {
            translate([-endPad,-endPad,-endPad])cube([wideRailWide+endPad*2,railInsert+endPad,railHeight+endPad*2]);
            translate([-endPad-fixingWidth,-endPad,-bottomClearance])cube([wideRailWide+endPad*2+fixingWidth*2,railInsert+endPad,bottomClearance]);
        }
        railWide(0.5,0);
        //fixings: LHS
        translate([-16+6+1,5,railHeight/2])rotate([0,90,0])boltHole(6,6.5,16,2.5);
        translate([-16+6+1,railInsert/2,railHeight/2])rotate([0,90,0])boltHole(6,6.5,16,2.5);
        translate([-16+6+1,railInsert-5,railHeight/2])rotate([0,90,0])boltHole(6,6.5,16,2.5);
        //fixings: RHS
        translate([wideRailWide+0.25+16-6-1,5,railHeight/2])rotate([0,-90,0])boltHole(6,6.5,16,2.5);
        translate([wideRailWide+0.25+16-6-1,railInsert/2,railHeight/2])rotate([0,-90,0])boltHole(6,6.5,16,2.5);
        translate([wideRailWide+0.25+16-6-1,railInsert-5,railHeight/2])rotate([0,-90,0])boltHole(6,6.5,16,2.5);
        //fixings: base LHS
        translate([-endPad-fixingWidth/2,0,-bottomClearance])cylinder(h=bottomClearance,d=7,$fn=detail);
        translate([-endPad-fixingWidth/2,railInsert-endPad,-bottomClearance])cylinder(h=bottomClearance,d=7,$fn=detail);
        translate([wideRailWide+endPad+fixingWidth/2,0,-bottomClearance])cylinder(h=bottomClearance,d=7,$fn=detail);
        translate([wideRailWide+endPad+fixingWidth/2,railInsert-endPad,-bottomClearance])cylinder(h=bottomClearance,d=7,$fn=detail);
        //fixings: base RHS
        translate([-endPad-fixingWidth/2,0,-countersink])cylinder(h=countersink,d1=fixingDiam,d2=fixingDiam*2,$fn=detail);
        translate([-endPad-fixingWidth/2,railInsert-endPad,-countersink])cylinder(h=countersink,d1=fixingDiam,d2=fixingDiam*2,$fn=detail);
        translate([wideRailWide+endPad+fixingWidth/2,0,-countersink])cylinder(h=countersink,d1=fixingDiam,d2=fixingDiam*2,$fn=detail);
        translate([wideRailWide+endPad+fixingWidth/2,railInsert-endPad,-countersink])cylinder(h=countersink,d1=fixingDiam,d2=fixingDiam*2,$fn=detail);
        // end hole
        translate([wideRailWide/2,-0.1,railHeight/2])rotate([90,0,0])cylinder(h=endPad+1.1,d=railHeight,$fn=detail);
        
        stepperWide = 40;
        stepperMountPad = 10;
        //mounting bolts - top (20mm) - 7mm offset from edge
        translate([-10,-70-10+15,20+10]) {
            translate([7,55+7,8])rotate([0,180,0])boltHole(8,6.5,30,2.5);
            translate([stepperWide+stepperMountPad*2-7,55+7,8])rotate([0,180,0])boltHole(8,6.5,30,2.5);
            translate([(stepperWide+stepperMountPad*2)/2,55+7,8])rotate([0,180,0])boltHole(8,6.5,30,2.5);
            //mounting bolts - side (20mm) - 5mm down, 12mm from edge
            translate([12,55-2,-5])rotate([-90,0,0])boltHole(50,6.5,30,2.5);
            translate([(stepperWide+stepperMountPad*2)-12,55-2,-5])rotate([-90,0,0])boltHole(50,6.5,30,2.5);
            translate([12,55-2,-5-35])rotate([-90,0,0])boltHole(50,6.5,30,2.5);
            translate([(stepperWide+stepperMountPad*2)-12,55-2,-5-35])rotate([-90,0,0])boltHole(50,6.5,30,2.5);
        }
    }
}
//

module endStepperMount() {
    //stepper mount plate
    color([0.8,0.5,0.5]) {
        stepperWide = 40;
        stepperMountPad = 10;
        plateLen = 70;
        difference() {
            union() {
                //main plate
                cube([stepperWide+stepperMountPad*2,plateLen,11]);
                //vertical brace
                translate([0,51,-45])cube([stepperWide+stepperMountPad*2,4,45]);
                //side braces
                hull() {
                    translate([0,51,-45])cube([4,4,4]);
                    translate([0,51,0])cube([4,4,4]);
                    translate([0,0,0])cube([4,4,4]);
                }
                //side braces
                translate([stepperWide+stepperMountPad*2-4,0,0])hull() {
                    translate([0,51,-45])cube([4,4,4]);
                    translate([0,51,0])cube([4,4,4]);
                    translate([0,0,0])cube([4,4,4]);
                }
            }
            //stepper undercut
            translate([4,-15-4,-6])cube([(stepperWide+stepperMountPad*2)-8,plateLen,11]);
            //stepper mount holes
            translate([(stepperWide+stepperMountPad*2)/2,23,0]) {    
                cylinder(h=15,d=30,$fn=detail);
                translate([31/2,31/2,0])cylinder(h=15,d=3.5,$fn=detail);
                translate([-31/2,31/2,0])cylinder(h=15,d=3.5,$fn=detail);
                translate([31/2,-31/2,0])cylinder(h=15,d=3.5,$fn=detail);
                translate([-31/2,-31/2,0])cylinder(h=15,d=3.5,$fn=detail);
            }
            //mounting bolts - top (20mm) - 7mm offset from edge
            translate([7,55+7,8])rotate([0,180,0])boltHole(8,6.5,30,3.5);
            translate([stepperWide+stepperMountPad*2-7,55+7,8])rotate([0,180,0])boltHole(8,6.5,30,3.5);
            translate([(stepperWide+stepperMountPad*2)/2,55+7,8])rotate([0,180,0])boltHole(8,6.5,30,3.5);
            //mounting bolts - side (20mm) - 5mm down, 12mm from edge
            translate([12,55-2,-5])rotate([-90,0,0])boltHole(50,6.5,30,3.5);
            translate([(stepperWide+stepperMountPad*2)-12,55-2,-5])rotate([-90,0,0])boltHole(50,6.5,30,3.5);
            translate([12,55-2,-5-35])rotate([-90,0,0])boltHole(50,6.5,30,3.5);
            translate([(stepperWide+stepperMountPad*2)-12,55-2,-5-35])rotate([-90,0,0])boltHole(50,6.5,30,3.5);
        }
    }
    
}
//

module stepper() {
    difference() {
        union() {
            color([0.3,0.3,0.3])cube([42.1,42.1,47]);
            color([0.7,0.7,0.7])translate([42.1/2,42.1/2,0]) {
                cylinder(h=49,d=22,$fn=detail);
                cylinder(h=71.24,d=5,$fn=detail);
            }
        }
        translate([42.1/2,42.1/2,47]) {
            translate([31/2,31/2,-10])cylinder(h=10,d=3,$fn=detail);
            translate([-31/2,31/2,-10])cylinder(h=10,d=3,$fn=detail);
            translate([31/2,-31/2,-10])cylinder(h=10,d=3,$fn=detail);
            translate([-31/2,-31/2,-10])cylinder(h=10,d=3,$fn=detail);
        }
    }
    translate([21,21,69])rotate([0,180,0])import("smallPulley.stl");
}
//

//utility
module boltHole(headLength, headDiam, shaftLength, shaftDiam) {
 	//(M3)
	//head length std = 3mm
	//head diameter std = 5.5mm
        //length defined
	//shaft diameter std = 3mm
        //3,5.5,12,2
        //3,5.5,20,2
        //3,5.5,35,2.5
    // (M5)
    // 5,8.34,70,5
	union() {
		cylinder(h=shaftLength,d=shaftDiam,$fn=detail);
		translate([0,0,-headLength]) cylinder(h=headLength,d=headDiam,$fn=detail); //h=2.9
	}
}
//

module boltHoleNut(nutLen) {
 	//(M3)
	//nutLen std = 2.4

    cylinder(h=nutLen,d=6.9,$fn=6);

}
//

module washer() {
    difference() {
        union() {
            cylinder(d=8.5,h=0.5,$fn=detail);
            cylinder(d=8.0,h=1,$fn=detail);
        }
        cylinder(d=6,h=1,$fn=detail);
    }
}
//

// from http://www.thingiverse.com/TheCase/designs/
// 9G Servo in OpenSCAD by TheCase is licensed under the Creative Commons - Attribution license.
module 9g_servo(horn,hornRot){
	difference(){			
		union(){
			color("steelblue") cube([23,12.5,22], center=true);
			color("steelblue") translate([0,0,5]) cube([32,12,2], center=true);
			color("steelblue") translate([5.5,0,2.75]) cylinder(r=6, h=25.75, $fn=20, center=true);
			color("steelblue") translate([-.5,0,2.75]) cylinder(r=1, h=25.75, $fn=20, center=true);
			color("steelblue") translate([-1,0,2.75]) cube([5,5.6,24.5], center=true);
          if (horn==1) {  
                color("white") translate([5.5,0,3.65]) {
                    cylinder(r=2.35, h=29.25, $fn=20, center=true);
                    rotate([0,0,hornRot]){
                        hull(){
                            translate([0,0,13.7925]) {
                                cylinder(d=7.3,h=1.66,$fn=15,center=true);
                                translate([(16-4.8/2),0,0])cylinder(d=4.8,h=1.66,$fn=15,center=true);
                            }
                        }
                    }
                }
            } else {
                color("white") translate([5.5,0,3.65]) {
                    difference() {
                        cylinder(d=4.7, h=29.25, $fn=20, center=true);
                        translate([0,0,1])cylinder(d=1, h=29.25, $fn=20, center=true);
                    }
                }
            }
		}
		translate([10,0,-11]) rotate([0,-30,0]) cube([8,13,4], center=true);
		for ( hole = [14,-14] ){
			translate([hole,0,5]) cylinder(r=2.2, h=4, $fn=20, center=true);
		}	
	}
}
//

module floorLevel() {
    floorSize = 400;
    translate([-floorSize/2,-floorSize/2,-1-18])color([0.8,0.8,0.8])cube([floorSize,floorSize,1]);
}
//

