package petrobras;

import java.util.HashMap;

public class EnviromentModel {
	
	//private String id = "EnviromentModel";
	
	private HashMap<String,CargoHolder> holders; // Vessels, Ports, Plataforms
	private HashMap<String,Vessel> vessels;
	private HashMap<String,Cargo> cargos;
	private HashMap<String,Plataform> plataforms;
	private HashMap<String,Port> ports;
	
	protected static EnviromentModel model = null;
	
    synchronized public static EnviromentModel create() {
        if (model == null) {
            model = new EnviromentModel();
        }
        return model;
    }
    
    static EnviromentModel Enviroment1() {
    	// Vessel with cargo on right location 
		EnviromentModel env1 = create();
		Vessel v1 = new Vessel("v1", 20, 20, 1000, 500, true);
		Plataform plat1 = new Plataform("plat1", 10000, 59, 42, true);
		Cargo c1 = new Cargo("c1", v1, 20, "p1");
		Port p1 = new Port("p1", 10000, 20, 20);
		env1.plataforms.put("plat1", plat1);
		env1.vessels.put("v1", v1);
		env1.cargos.put("c1", c1);
		env1.ports.put("p1", p1);
		return env1;		
	}

	private EnviromentModel(){
		holders = new HashMap<String, CargoHolder>();
    	vessels = new HashMap<String, Vessel>();
    	cargos = new HashMap<String, Cargo>();
    	plataforms = new HashMap<String, Plataform>();
    	ports = new HashMap<String, Port>();
    }
    
    public static EnviromentModel get() {
        return model;
    }
	
    public static void destroy() {
        model = null;
    }

	public Iterable<Vessel> getVessels() {
		return vessels.values();
	}

	public Iterable<Cargo> getCargos() {
		return cargos.values();
	}

	public Iterable<Plataform> getPlataforms() {
		return plataforms.values();
	}
	
	public Iterable<Port> getPorts() {
		return ports.values();
	}

	public void load_vessel(String cargo, String vessel, String location) {
		Cargo c = cargos.get(cargo);
		Vessel v = vessels.get(vessel);
		v.setCapacity(v.getCapacity() - c.getWeight());
		v.setEmpty(false);
		c.setHolder(v);
		return;
	}

	public void unload_vessel(String cargo, String vessel, String location) {
		Cargo c = cargos.get(cargo);
		Vessel v = vessels.get(vessel);
		CargoHolder ch = holders.get(location);
		v.setCapacity(v.getCapacity() + c.getWeight());
		v.setEmpty(true);
		c.setHolder(ch);
		return;		
	}

	public void move_vessel(String vessel, String loc1, String loc2, int mod) {
		Vessel v = vessels.get(vessel);
		CargoHolder h1 = holders.get(loc1);
		CargoHolder h2 = holders.get(loc2);
		int updated_fuel_meter = v.getFuel() - (h1.getLocation().distance(h2.getLocation())/mod);
		v.setFuel(updated_fuel_meter);
		v.setLocation(h2.getLocation());
		return;
	}
	
	
	
    
}
