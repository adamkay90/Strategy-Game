package com.monarch.strat.gameplay {
	import net.flashpunk.graphics.Image;

	/**
	 * Represents a tile on the stage.
	 * @author Forrest Jacobs
	 */
	public class Cell extends GridBlock {
		
		/**
		 * Constructor.
		 * @param loc The Cell's location.
		 * @param definition The Cell type.
		 */
		public function Cell(loc: Loc, def: CellDef) {
			super(loc);
			_def = def;
			reset();

			layer = Layers.CELL;
			graphic = new Image(def.graphic);
		}

		/** The Cell type. */
		public function get def(): CellDef { return _def; }
		private var _def: CellDef;

		/** Distance to the start Cell. Used for pathfinding. */
		internal function get distance(): uint { return _distance; }
		private var _distance: uint;

		/** Previous Cell on the path. Used for pathfinding. */
		internal function get previous(): Cell { return _previous; }
		private var _previous: Cell;

		/** Sets the distance and previous Cell. Used for pathfinding. */
		internal function visit(prev: Cell, dist: uint): void {
			_distance = dist;
			_previous = prev;
		}

		/** Resets the distance and previous Cell. Used for pathfinding. */
		public function reset(): void {
			_distance = uint.MAX_VALUE;
			_previous = null;
		}
	}
}