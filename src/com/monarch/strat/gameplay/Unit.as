package com.monarch.strat.gameplay {
	import flash.utils.Dictionary;
	import com.monarch.strat.Assets;
	import net.flashpunk.graphics.Image;
	/**
	 * @author forrest
	 */
	public class Unit extends Cell {
		
		private var _definition:UnitDefinition;
				
		public function Unit(definition: UnitDefinition, loc: Loc) {
			super(loc);
			_definition = definition;
			this.layer = Layers.UNIT;
			this.graphic = new Image(Assets.cells["placeholder"]);
		}
		
		public function get definition():UnitDefinition { return _definition; }
		public function get stats():Array { return definition.stats; }
		
		public function get paths():Dictionary {
			if(stage == null) return null;
			return stage.findPaths(loc, (stats["movement"] as Stat).value);
		}

	}
}
