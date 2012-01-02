package com.monarch.strat.gameplay {
	/**
	 * @author forrest
	 */
	public class StatType {
		
		public static const SIZE:uint = 9;
		
		public static const MAXHP:uint = 0;
		public static const STRENGTH:uint = 1;
		public static const MAGIC:uint = 2;
		public static const SKILL:uint = 3;
		public static const SPEED:uint = 4;
		public static const LUCK:uint = 5;
		public static const VITALITY:uint = 6;
		public static const RESISTANCE:uint = 7;
		public static const MOVEMENT:uint = 8;
		
		private static const VALUES:Vector.<String> = Vector.<String>([
			"maxHP", "strength", "magic", "skill", "speed", "luck", "vitality", "resistance", "movement"
		]);
		
		public static function called(tag:String):int {
			return VALUES.indexOf(tag);
		}
		
	}
}
