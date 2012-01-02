package com.monarch.strat.gameplay {
	import com.monarch.strat.Assets;
	
	import Math;
	
	public class UnitDefinition {

		private var _stats:Array;
		private var _HP:int;
		private var _movement:uint;
		private var _level:int;
		private var _exp:int;
		
		
		private var modifiers:Vector.<Modifier> = new Vector.<Modifier>();
		
		private var _firstName:String;
		private var _lastName:String;
		private var _nickName:String = null;
		
		public function UnitDefinition(asset: *) {
			var xml:XML;
			if(asset is XML) {
				xml = asset as XML;
			}
			if(asset is String) {
				xml = XML(new Assets.units[asset as String]);
			}
			_stats = new Array;
			for each(var stat:XML in xml["stat"])
				_stats[stat.@type] = new Stat(stat);

			_HP = stats["maxHP"];
			_movement = stats["movement"];
			
			_firstName = xml["name"].@first;
			_lastName = xml["name"].@last;
			
			if("@nick" in xml["name"])
				_nickName = xml["name"].@nick;
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
