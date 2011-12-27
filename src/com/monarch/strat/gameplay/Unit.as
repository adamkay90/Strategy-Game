package com.monarch.strat.gameplay {
	import flash.utils.Dictionary;
	import com.monarch.strat.Assets;
	import net.flashpunk.graphics.Image;
	/**
	 * @author forrest
	 */
	public class Unit extends Cell {
		
		private var _maxHP:Stat;
		private var _HP:int;
		private var _strength:Stat;
		private var _magic:Stat;
		private var _skill:Stat;
		private var _speed:Stat;
		private var _luck:Stat;
		private var _vitality:Stat;
		private var _resistance:Stat;
		
		public function Unit(loc: Loc) {
			super(loc);
			this.layer = Layers.UNIT;
			this.graphic = new Image(Assets.cells["placeholder"]);
			_speed = new Stat(12);
		}
		
		public function get maxHP():Stat { return _maxHP; }
		public function get HP():int { return _HP; }
		public function get strength():Stat { return _strength; }
		public function get magic():Stat { return _magic; }
		public function get skill():Stat { return _skill; }
		public function get speed():Stat { return _speed; }
		public function get luck():Stat { return _luck; }
		public function get vitality():Stat { return _vitality; }
		public function get resistance():Stat { return _resistance; }
		
		public function get paths():Dictionary {
			if(stage == null) return null;
			return stage.findPaths(loc, speed.current);
		}
		
	}
}
