package com.monarch.strat.gameplay {
	
	public class UnitDefinition {

		private var _stats:Array;
		private var _HP:int;
		
		public function UnitDefinition(xml:XML) {
			_stats = new Array;
			for each(var stat:XML in xml["stat"])
				_stats[stat.@type] = new Stat(stat);
			_HP = stats["HP"];
		}
		
		public function get stats():Array {
			return _stats;
		}
		
	}
	
}
