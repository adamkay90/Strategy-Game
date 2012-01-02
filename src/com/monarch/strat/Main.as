package com.monarch.strat {
	
	import net.flashpunk.*;
	
	/**
	 * Mediates between views of the game.
	 * @author Forrest Jacobs
	 */
	public class Main extends Engine {

		/** The constructor for Main. */		
		public function Main(){
			super(800, 600, 60, true);
			FP.world = new Gameplay("test");
		}
	
	}
}