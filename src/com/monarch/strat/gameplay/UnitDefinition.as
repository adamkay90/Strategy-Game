package com.monarch.strat.gameplay {
	
	public class UnitDefinition {

		private var _stats:Array;
		private var _HP:int;
		
		private var _firstName:String;
		private var _lastName:String;
		private var _nickName:String = null;
		
		public function UnitDefinition(xml:XML) {
			_stats = new Array;
			for each(var stat:XML in xml["stat"])
				_stats[stat.@type] = new Stat(stat);
			_HP = stats["HP"];
			
			_firstName = xml["name"].@first;
			_lastName = xml["name"].@last;
			
			if("@nick" in xml["name"])
				_nickName = xml["name"].@nick;
		}
		
		public function get stats():Array {
			return _stats;
		}
		
		public function get HP():int {
			return _HP;
		}
		
		public function get firstName():String {
			return _firstName;
		}
		
		public function get lastName():String {
			return _lastName;
		}
		
		public function get nickName():String {
			return _nickName == null ? _firstName : _nickName;
		}
		
	}
	
}
