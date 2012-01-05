package com.monarch.strat.gameplay.unit {
	import com.monarch.strat.Assets;
	
	public class UnitDef {

		// TODO: Make modifiers work
		// private var modifiers:Vector.<Modifier> = new Vector.<Modifier>();
		
		public function UnitDef(asset: *) {
			var xml:XML =
				(asset is XML) ? asset as XML :
				(asset is String) ? XML(new Assets.units[asset as String]) :
				null;

			for each(var stat:XML in xml["stat"])
				_stats[StatType.called(stat.@type)] = new Stat(stat);

			_HP = stats[StatType.MAXHP].value;
			
			var nameXML:XMLList = xml["name"];
			_firstName = nameXML.@first;
			_lastName = nameXML.@last;
			_nickName = ("@nick" in nameXML) ? nameXML.@nick : firstName;
			
			// Have to save base level
			// var level:XML = xml["level"];
			// _baseLevel = level.@start;
		}
		
		public function get stats():Vector.<Stat> { return _stats; }
		private var _stats:Vector.<Stat> = new Vector.<Stat>(StatType.SIZE);
		
		public function get baseLevel():uint { return _baseLevel; }
		public var _baseLevel:uint; 
				
		public function get HP():int { return _HP; }
		private var _HP:int;
		
		public function get exp():uint { return _exp; }
		private var _exp:uint;
		
		public function get level():uint { return _level; }
		private var _level:int = 1;

		public function get firstName():String { return _firstName; }
		private var _firstName:String;

		public function get lastName():String { return _lastName; }
		private var _lastName:String;
		
		public function get nickName():String { return _nickName; }
		private var _nickName:String;
		
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
