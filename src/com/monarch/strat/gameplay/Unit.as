package com.monarch.strat.gameplay {
	import flash.utils.Dictionary;
	import com.monarch.strat.Assets;
	import net.flashpunk.graphics.Image;

	public class Unit extends GridBlock {
		
		private var _definition:UnitDefinition;
				
		public function Unit(definition: UnitDefinition, loc: Loc) {
			super(loc);
			_definition = definition;
			layer = Layers.UNIT;
			graphic = new Image(Assets.cells["placeholder"]);
		}
		
		public function get definition():UnitDefinition { return _definition; }
		
		public function get paths():Dictionary {
			if(stage == null) return null;
			return stage.findPaths(loc, definition.stats[StatType.MOVEMENT].value);
		}

	}
}
