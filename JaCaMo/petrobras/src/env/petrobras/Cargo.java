package petrobras;

import cartago.*;

public class Cargo extends Artifact{
	
	@OPERATION
    public void init(String name, int weight, String location) {
		defineObsProperty("cargo", name, weight);
		defineObsProperty("cargoAt", name, location);
	}
	
}
