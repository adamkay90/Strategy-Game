package com.monarch.strat.gameplay {
	
	/**
	 * ...
	 * @author Forrest Jacobs
	 */
	public class Direction {
		
		public static const SOUTH:uint = 0;
		public static const WEST:uint = 1;
		public static const NORTH:uint = 2;
		public static const EAST:uint = 3;
		
		public static const NONE:uint = 4;
		
		public static function reverse(dir:uint):uint{
			switch (dir){
				case SOUTH: 
					return NORTH;
				case WEST: 
					return EAST;
				case NORTH: 
					return SOUTH;
				case EAST: 
					return WEST;
				default: 
					return NONE;
			}
		}
	
	}

}