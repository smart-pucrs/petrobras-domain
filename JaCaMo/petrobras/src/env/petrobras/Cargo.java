package petrobras;

public class Cargo {
	
	private String name;
	private CargoHolder holder;
	private int weight;
	private String destination;
	
	public Cargo(String name, CargoHolder holder, int weight, String destination){
		this.name = name;
		this.setHolder(holder);
		this.weight = weight;
		this.destination = destination;
	}

	public CargoHolder getHolder() {
		return holder;
	}

	public void setHolder(CargoHolder holder) {
		this.holder = holder;
	}

	public int getWeight() {
		return weight;
	}
	
	public String getName(){
		return name;
	}
	
	public String getDestination(){
		return destination;
	}
	
}
