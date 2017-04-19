package petrobras;

public class Vessel extends CargoHolder {
	
	private int capacity;
	private int fuel;
	private boolean isEmpty;
	
	public Vessel(String name, int x, int y, int capacity, int fuel, boolean isEmpty) {
		super(name, capacity, x, y);
		this.setCapacity(capacity);
		this.setFuel(fuel);
		this.setEmpty(isEmpty);
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public int getFuel() {
		return fuel;
	}

	public void setFuel(int fuel) {
		this.fuel = fuel;
	}

	public boolean isEmpty() {
		return isEmpty;
	}

	public void setEmpty(boolean isEmpty) {
		this.isEmpty = isEmpty;
	}

}
