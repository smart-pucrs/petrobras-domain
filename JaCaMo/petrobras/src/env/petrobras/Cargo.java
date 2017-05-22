package petrobras;

import cartago.*;

public class Cargo extends Artifact{
	
	@OPERATION
    public void init(String name, int weight, String location) {
		defineObsProperty("cargo", name, weight);
		defineObsProperty("cargoAt", name, location);
	}
	
	@OPERATION
	public void after_load(String cargoName){
		try {
			removeObsPropertyByTemplate("cargoAt", cargoName, null);
		} catch (Exception e) {}
	}
	
	@OPERATION
	public void after_unload(String cargoName, String location){
		if(getObsPropertyByTemplate("cargoAt", cargoName, null) != null){
			removeObsPropertyByTemplate("cargoAt", cargoName, null);
		}
		defineObsProperty("cargoAt", cargoName, location);
	}
	
}
