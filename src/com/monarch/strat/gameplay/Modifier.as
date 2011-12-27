package com.monarch.strat.gameplay {
	/**
	 * @author forrest
	 */
	public class Modifier {
		
		private var _value: int;
		private var _turns: int;
		
		public function Modifier(value: int, turns: int) {
			_value = value;
			_turns = turns;
		}
		
		public function get value():int { return _value; }
		public function get turns():int { return _turns; }
		
		public function step():void {
			--_turns;
		}
		
		public function isAlive():Boolean {
			return turns != 0;
		}
		
	}
}
