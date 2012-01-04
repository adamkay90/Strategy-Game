package com.monarch.strat.gameplay.unit {

	/**
	 * Represents a character's stat.
	 * @author Forrest Jacobs
	 * @author Adam Kay
	 */
	public class Stat {
		
		/**
		 * The constructor for Stat.
		 * @param xml The XML tag that describes the stat.
		 */
		public function Stat(xml:XML) {
			_pureValue = xml.@start;
			_baseValue = xml.@start;
			_modifiedValue = xml.@start;
			if (xml.@levelUp != 0) {
				_growthValue = xml.@levelUp;
			}
		}
		
		/** Current value without modifiers. */
		public function get pureValue():int { return _pureValue; }
		public function set pureValue(value:int):void { _pureValue = value; }
		private var _pureValue:int;

		/** Value at first level. */
		public function get baseValue():int { return _baseValue; }
		public function set baseValue(value:int):void { _baseValue = value; }
		private var _baseValue:int;
		
		/** Current value with modifiers. */
		public function get value():int { return _modifiedValue; }
		public function set value(value:int):void { _modifiedValue = value;  }
		private var _modifiedValue:int;

		/** Growth rate */
		public function get growthValue():int { return _growthValue; }
		public function set growthValue(value:int):void { _growthValue = value; }
		private var _growthValue:int = 0;

	}
}
