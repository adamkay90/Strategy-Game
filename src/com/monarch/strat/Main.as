package com.monarch.strat {
	/**
	 * ...
	 * @author Forrest Jacobs
	 */
	
	import net.flashpunk.*;
	
	public class Main extends Engine {
		
		public function Main(){
			super(800, 600, 60, true);
			FP.world = new Gameplay("test");
		}
		
		override public function init():void {
		}
	
	}
}