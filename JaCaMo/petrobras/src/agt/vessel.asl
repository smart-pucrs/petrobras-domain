// Agent vessel in project petrobras

/* Initial beliefs and rules */

// Rule for distance between coordinates
calculate_necessary_fuel(X1, Y1, X2, Y2, Result) :- Result = math.sqrt(((X1 - X2)**2 + (Y1 - Y2)**2) / 3).

/* Initial goals */
!start.
/* Plans */
+!start : .my_name(X) & (X == "v1")
<-
load_vessel("cargo1", 3000, "v1", "plat1");
move_vessel("v1", "plat1", 0, 0, "p1", 600, 600, 3);
unload_vessel("cargo1", 3000, "v1", "p1");
move_vessel("v1", "p1", 600, 600, "plat1", 0, 0, 5);
.

+!start : .my_name(X) & (X == "v2")
<- 
move_vessel("v2", "plat1", 0, 0, "p1", 600, 600, 3);
unload_vessel("cargo2", 1000, "v2", "p1");
move_vessel("v2", "p1", 600, 600, "plat1", 0, 0, 5);
.

+!start
<-
.my_name(X);
.println(X).


/* a/2 vesselAt(Vessel, Location) */
+vesselAt(Vessel, LocTo)
<- !vesselAt(Vessel, Locto).

/* a/2 cargoAt(Cargo, Location) */
+cargoAt(Cargo, LocGoal)
<- !cargoAt(Cargo, LocGoal).


/* +!vesselAt */

// not neccessary  
// VesselAt -- Vessel in right location
+!vesselAt(Vessel, LocTo)
: vesselAt(Vessel, LocFrom) & LocFrom == LocTo.
//<- -vesselAt(Vessel, LocFrom);
//   vesselAt(Vessel, LocTo).

// VesselAt --  Vessel in wrong location
+!vesselAt(Vessel, LocTo)
: vesselAt(Vessel, LocFrom) & not (LocFrom == LocTo) & vesselEmpty(Vessel) & location(Locfrom, X1, Y1) & location(LocTo, X2, Y2)
<- move_vessel(Vessel, LocFrom, X1, Y1, LocTo, X2, Y2, 5).

// VesselAt -- Vessel in right location but not empty
+!vesselAt(Vessel, LocTo)
: vesselAt(Vessel, LocFrom) & not (LocFrom == LocTo) & not vesselEmpty(Vessel) & location(Locfrom, X1, Y1) & location(LocTo, X2, Y2)
<- move_vessel(Vessel, LocFrom, X1, Y1, LocTo, X2, Y2, 3).


/* +!cargoAt */

// not neccessary     
// CargoAt -- Already there
+!cargoAt(Cargo, LocGoal)
: cargoAt(Cargo, LocNow) & LocNow = LocGoal.
//<- -cargoAt(Cargo, LocNow);
//   cargoAt(Cargo, LocGoal). 

// CargoAt -- Vessel carrying cargo
+!cargoAt(Cargo, LocGoal)
: inVessel(Cargo, Vessel) & isWaitingArea(LocA) & cargo(Cargo, Weight)
<- vesselAt(Vessel, LocGoal);
   unload_vessel(Cargo, Weight, Vessel, LocGoal);
   vesselAt(Vessel, LocA).

// CargoAt -- Vessel in same location    
+!cargoAt(Cargo, LocGoal)
: cargoAt(Cargo, LocNow) & vesselAt(Vessel, LocNow) & isWaitingArea(LocA) &
  cargo(Cargo, Weight) & vessel(Vessel, Capacity, Fuel) & 0 <= (Capacity - Weight) &
  location(LocGoal, X1, Y1) & location(LocNow, X2, Y2) & calculate_necessary_fuel(X1, Y1, X2, Y2, Result) &  Fuel >= Result
<- load_vessel(Cargo, Weight, Vessel, LocNow);
   vesselAt(Vessel, LocGoal);
   unload_vessel(Cargo, Weight, Vessel, LocGoal);
   vesselAt(Vessel, LocA).

// CargoAt -- Vessel in another location  
+!cargoAt(Cargo, LocGoal)
: cargoAt(Cargo, LocNow) & vesselAt(Vessel, Loc2) & not (LocNow == Loc2) & isWaitingArea(LocA) &
  cargo(Cargo, Weight) & vessel(Vessel, Capacity, Fuel) & 0 <= (Capacity - Weight) &
  location(LocGoal, X1, Y1) & location(LocNow, X2, Y2) & calculate_necessary_fuel(X1, Y1, X2, Y2, Result) &  Fuel >= Result
<- +vesselAt(Vessel, LocNow);
   load_vessel(Cargo, Weight, Vessel, LocNow);
   vesselAt(Vessel, LocGoal);
   unload_vessel(Cargo, Weight, Vessel, LocGoal);
   vesselAt(Vessel, LocA).   
   

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation  
//{ include("$jacamoJar/templates/org-obedient.asl") }
