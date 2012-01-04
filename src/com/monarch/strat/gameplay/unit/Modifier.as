package com.monarch.strat.gameplay.unit {
	
	/**
	 * Represents a modifier to a Stat
	 * @author Forrest Jacobs
	 */
	public class Modifier {
		
		/**
		 * The constructor for Modifier.
		 * @param value The amount to add to the stat.
		 * @param turns How many turns this modifier lasts.
		 */
		public function Modifier(value: int, turns: int) {
			_value = value;
			_turns = turns;
		}
		
		/** The amount added to the stat. */
		public function get value():int { return _value; }
		private var _value: int;
		
		/** How many turns until the modifier is removed. */
		public function get turns():int { return _turns; }
		private var _turns: int;
		
		/** Called by Stat between turns. */
		internal function step():void { --_turns; }
		
		/** True if the modifier is alive. **/
		public function isAlive():Boolean { return turns != 0; }
		
	}
}
