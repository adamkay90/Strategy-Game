package com.monarch.strat.gameplay {

	/**
	 * Represents a character's stat.
	 * @author Forrest Jacobs
	 */
	public class Stat {
		
		/**
		 * The constructor for Stat.
		 * @param xml The XML tag that describes the stat.
		 */
		public function Stat(xml:XML) {
			_pureValue = xml.@start;
		}
		
		/** The stat's numberical value without modifiers. */
		public function get pureValue():int { return _pureValue; }
		private var _pureValue:int;

		/** List of modifiers currently affecting the stat. */
		public function get modifiers():Vector.<Modifier> { return _modifiers; }
		private var _modifiers:Vector.<Modifier> = new Vector.<Modifier>;

		/** Value of all the modifiers added together. */
		public function get modifierValue():int {
			var total:int = 0;
			for each (var modifier:Modifier in modifiers) {
				total += modifier.value;
			}
			return total;
		}

		/** Current value of the stat. */
		public function get value(): int {
			return pureValue + modifierValue;
		}
		
		/** Call between turns to remove expired modifiers from the list. */
		public function step():void {
			for each (var modifier:Modifier in modifiers) {
				modifier.step();
			}
			_modifiers = modifiers.filter(function(e: Modifier, i:uint, a:Vector.<Modifier>):Boolean {
				return e.isAlive();
			});
		}
		
	}
}
