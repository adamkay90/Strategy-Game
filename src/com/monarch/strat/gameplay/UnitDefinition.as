package com.monarch.strat.gameplay {
	
	import Math;
	
	public class UnitDefinition {

		private var _stats:Array;
		private var _HP:int;
		private var _movement:uint;
		private var _level:int;
		private var _exp:int;
		
		
		private var modifiers:Vector.<Modifier> = new Vector.<Modifier>();
		
		public function UnitDefinition(xml:XML) {
			_stats = new Array;
			for each(var stat:XML in xml["stat"])
				_stats[stat.@type] = new Stat(stat);
			_HP = stats["maxHP"];
			_movement = stats["movement"];
			
		}
		
		public function get stats():Array {
			return _stats;
		}
		
				
		public function unmodifiedLevelUp():void {
			++_level;
			for each(var stat:Stat in _stats) {
				var random:Number = Math.random() * 100;
				if (stat.growthValue != 0 && random < stat.growthValue) {
					stat.pureValue++;
				}
				trace (stat.pureValue);
			}
		}
		
	}
	
}
