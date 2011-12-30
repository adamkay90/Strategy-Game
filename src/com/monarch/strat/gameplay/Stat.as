package com.monarch.strat.gameplay {

	public class Stat {
		
		private var _modifiers:Vector.<Modifier> = new Vector.<Modifier>;
		private var _pureValue:int;
		private var _baseValue:int;
		private var _modifiedValue:int;
		private var _growthValue:int = 0;
		
		public function Stat(xml:XML) {
			_pureValue = xml.@start;
			_baseValue = xml.@start;
			_modifiedValue = xml.@start;
			if (xml.@levelUp != 0) {
				_growthValue = xml.@levelUp;
			}
		}
		
		public function get pureValue():int { return _pureValue; }
		public function get baseValue():int { return _baseValue; }
		public function get modifiedValue():int { return _modifiedValue; }
		public function get growthValue():int { return _growthValue; }

		public function set pureValue(value:int):void { _pureValue = value; }
		public function set baseValue(value:int):void { _baseValue = value; }
		public function set modifiedValue(value:int):void { _modifiedValue = value;  }
		public function set growthValue(value:int):void { _growthValue = value; }
		
		public function get modifiers():Vector.<Modifier> { return _modifiers; }
		public function get modifierValue():int {
			var total:int = 0;
			for each (var modifier:Modifier in modifiers) {
				total += modifier.value;
			}
			return total;
		}

		public function get value(): int { return pureValue + modifierValue; }
		
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
