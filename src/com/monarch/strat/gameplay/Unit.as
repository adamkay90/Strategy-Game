package com.monarch.strat.gameplay {
	import flash.utils.Dictionary;

	import com.monarch.strat.Assets;
	import com.monarch.strat.gameplay.unit.*;
	import net.flashpunk.graphics.Image;

	public class Unit extends GridBlock {
		
		private var _def: UnitDef;
				
		public function Unit(def: UnitDef, loc: Loc) {
			super(loc);
			_def = def;
			layer = Layers.UNIT;
			graphic = new Image(Assets.cells["placeholder"]);
		}
		
		public function get def(): UnitDef { return _def; }
		
		public function get paths(): Dictionary {
			if(stage == null) return null;
			return stage.findPaths(loc, def.stats[StatType.MOVEMENT].value);
		}

	}
}
