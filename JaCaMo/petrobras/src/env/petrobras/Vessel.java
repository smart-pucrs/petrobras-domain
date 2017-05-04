package petrobras;

import cartago.*;

public class Vessel extends Artifact {
	
	@OPERATION
    public void init(String name, int capacity, int fuel, String location) {
		defineObsProperty("vessel", name, capacity, fuel);
		defineObsProperty("vesselAt", name, location);
		defineObsProperty("vesselEmpty", name);
		
	}
	
	@OPERATION
    public void init(String name, int capacity, int fuel, String location, String cargo) {
		defineObsProperty("vessel", name, capacity, fuel);
		defineObsProperty("vesselAt", name, location);
		defineObsProperty("inVessel", cargo, name);	
	}
	
	@OPERATION
	void load_vessel(String cargo, String vessel, String location){
		ObsProperty thisVessel = getObsPropertyByTemplate("vessel", vessel, null, null);
		ObsProperty opCargo =  getObsPropertyByTemplate("cargo", cargo, null);
		
		int newCapacity = thisVessel.intValue(1) - opCargo.intValue(1);
		
		thisVessel.updateValue(1, newCapacity);
		removeObsPropertyByTemplate("vesselEmpty", vessel);
		defineObsProperty("inVessel", cargo, vessel);	
	}
	
	@OPERATION
	void unload_vessel(String cargo, String vessel, String location){
		ObsProperty thisVessel = getObsPropertyByTemplate("vessel", vessel, null, null);
		ObsProperty opCargo =  getObsPropertyByTemplate("cargo", cargo, null);
		
		int newCapacity = thisVessel.intValue(1) + opCargo.intValue(1);
		
		thisVessel.updateValue(1, newCapacity);
		defineObsProperty("vesselEmpty", vessel);
		removeObsPropertyByTemplate("inVessel", cargo, vessel);
	}
	
	@OPERATION
	void move_vessel(String vessel, String loc1, String loc2, int mod){
		ObsProperty thisVessel = getObsPropertyByTemplate("vessel", vessel, null, null);
		ObsProperty fromLocation = getObsPropertyByTemplate("location", loc1, null, null);
		ObsProperty toLocation = getObsPropertyByTemplate("location", loc2, null, null);
		
		int fuel = thisVessel.intValue(2);
		int updated_fuel = (int) (fuel - (
				(Math.sqrt(
				Math.pow((fromLocation.intValue(1) - toLocation.intValue(1)),2) +
				Math.pow((fromLocation.intValue(2) - toLocation.intValue(2)),2) )) / mod
				));
		
		thisVessel.updateValue(2, updated_fuel);
		removeObsPropertyByTemplate("vesselAt", vessel, loc1);
		defineObsProperty("vesselAt", vessel, loc2);
	}
	
	@OPERATION
	void vesselAt(String vessel, String location){
		removeObsPropertyByTemplate("vesselAt", vessel, null);
		defineObsProperty("vesselAt", vessel, location);
	}
}


