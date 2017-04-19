package petrobras;

import jason.environment.grid.Location;

public class CargoHolder {
	
	protected String name;
	protected Location location;
	protected int capacity;
	
	public CargoHolder(String name, int capacity, int x, int y){
		this.name = name;
		this.capacity = capacity;
		this.location = new Location(x, y);
	}
	
	public int getCapacity(){
		return capacity;
	}
	
	public String getName(){
		return name;
	}
	
	public Location getLocation(){
		return location;
	}
	
	//Maybe will be protected
	public void setLocation(Location l){
		this.location = l;
	}
	
}
