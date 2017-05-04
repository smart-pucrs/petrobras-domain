package petrobras;

import cartago.*;

public class Port extends Artifact{
	
	@OPERATION
    public void init(String name, int capacity, int x, int y) {
		defineObsProperty("port", name, capacity);
		defineObsProperty("location", name, x, y);
	}
	
}
