package com.monarch.strat.gameplay {
	import net.flashpunk.graphics.Image;

	public class Cell extends GridBlock {
		private var definition : CellDefinition;
		private var _distance : uint = uint.MAX_VALUE;
		private var _previous : Cell = null;

		public function Cell(loc : Loc, definition : CellDefinition = null) {
			super(loc);

			layer = Layers.CELL;
			graphic = new Image(definition.graphic);

			this.definition = definition;
		}

		public function get cost() : uint {
			return definition.cost;
		}

		public function get walkable() : Boolean {
			return definition.walkable;
		}

		public function get distance() : uint {
			return _distance;
		}

		public function get previous() : Cell {
			return _previous;
		}

		public function visit(prev : Cell, dist : uint) : void {
			_distance = dist;
			_previous = prev;
		}

		public function reset() : void {
			_distance = uint.MAX_VALUE;
			_previous = null;
		}
	}
}