// CArtAgO artifact code for project petrobras

package petrobras;

import java.util.logging.Logger;
import cartago.Artifact;
import cartago.OPERATION;

/*
 *  INIT:
 *  port(Port, Capacity) ->           (string, int)
 *  plataform(Plataform, Capacity) -> (string, int)
 *  vessel(Vessel, Capacity, Fuel) -> (string, int, int)
 *  "final (don't change after definition)":
 *  cargo(Cargo, Weight) ->           (string, int)
 *  isWaitingArea(Location) ->        (string) 
 *  canRefuel(Plataform) ->           (string) ****SKIPED ( not curently used )
 *  location(Location, X, Y) ->       (string, int X, int Y)  (Ports, Plataforms)
 * 
 *  UPDATE beliefs using data from model:
 *  cargoAt(Cargo, Location) ->       (string, string)
 *  vesselAt(Vessel, Location) ->     (string, string)
 *  inVessel(Cargo, Vessel) ->        (string, string)
 *  inPort(Cargo, Port)            -> cargoAt( Cargo, "PortLocation" )
 *  inPlataform(Cargo, Plataform)  -> cargoAt( Cargo, "PlatLocation" )
 *  isDocked(Vessel, Location)     -> vesselAt( Vessel, "(Port/Plat)Location" )
 *  vesselEmpty(Vessel) ->            (string)
 *  port/vessel/plataform aswell.
 */

public class PetrobrasDomain extends Artifact {
	
	//Object used for generating log-messages.
	private static Logger logger = Logger.getLogger(PetrobrasDomain.class.getName());
	
	static EnviromentModel  model = null;
	int agentId;
	
	void init(int id, int envID) {
		this.agentId = id;
		if(model == null){
			switch (envID){
				case 1:  model = EnviromentModel.Enviroment1(); break;
				default: logger.info("Invalid index!"); return;
			}
		}
		for (Vessel v : model.getVessels()){
			defineObsProperty("vessel", v.getName(), v.getCapacity(), v.getFuel());
		}
		for (Port p : model.getPorts()){
			defineObsProperty("port", p.getName(), p.getCapacity());
			defineObsProperty("location", p.getName(), p.getLocation().x, p.getLocation().y);
		}
		for (Plataform plat : model.getPlataforms()){
			defineObsProperty("plataform", plat.getName(), plat.getCapacity());
			if(plat.isWaitingArea()) defineObsProperty("isWaitingArea", plat.getName());
			defineObsProperty("location", plat.getName(), plat.getLocation().x, plat.getLocation().y);
		}
		for (Cargo c : model.getCargos()){
			defineObsProperty("cargo", c.getName(), c.getWeight());
			}
		
		updateAgPercept();
		
		//Define objectives
		//for (Cargo c : model.getCargos()){defineObsProperty("cargoAt", c.getName(), c.getDestination());}
	}
	
	private void updateAgPercept(){
		
	}
	
	@SuppressWarnings("unused")
	private void removeAllObsProperties(String name){
		while(getObsProperty(name) != null){
			removeObsProperty(name);
		}
		return;
	}
	
	@OPERATION
	void load_vessel(String cargo, String vessel, String location){
		model.load_vessel(cargo, vessel, location);
		updateAgPercept();
	}
	
	@OPERATION
	void unload_vessel(String cargo, String vessel, String location){
		model.unload_vessel(cargo, vessel, location);
		updateAgPercept();
	}
	
	@OPERATION
	void move_vessel(String vessel, String loc1, String loc2, int mod){
		model.move_vessel(vessel,loc1,loc2,mod);
		updateAgPercept();
	}
	
	@OPERATION
	void vesselAt(String vessel, String location){
		// TODO remove old vesselAt(Vessel,oldLocation) (?)
		// and define new vesselAt(Vessel,Location)
	}	
}



