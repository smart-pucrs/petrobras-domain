package petrobras;

public class Plataform extends CargoHolder{
	
	private boolean isWaitingArea;
	
	public Plataform(String name, int capacity, int x, int y, boolean waitArea){
		super(name, capacity, x, y);
		isWaitingArea = waitArea;
	}
	
	public boolean isWaitingArea(){
		return isWaitingArea;
	}
	
}
