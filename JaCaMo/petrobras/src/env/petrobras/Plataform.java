package petrobras;

import cartago.*;

public class Plataform extends Artifact{
	
	@OPERATION 
	// I'm using "int bool" as a parameter to verify if this plataform is a waiting area
	// because I'm getting an error when using 'true' or 'false' in the jcm file (1 = true)
    public void init(String name, int capacity, int x, int y, int bool) {
		defineObsProperty("plataform", name, capacity);
		defineObsProperty("location", name, x, y);
		if(bool == 1){
			defineObsProperty("isWaitingArea", name);
		}
	}	
}
