package com.monarch.strat.gameplay.unit {
	/**
	 * @author Forrest Jacobs
	 */
	public class Team {
		
		public static const NONE:int = -1;

		public static const FRIEND:int = 0;
		public static const FOE:int = 1;
		
		private static const VALUES:Vector.<String> = Vector.<String>([
			"friend", "foe"
		]);
		public static function called(tag:String):int {
			return VALUES.indexOf(tag);
		}
		
	}
}
