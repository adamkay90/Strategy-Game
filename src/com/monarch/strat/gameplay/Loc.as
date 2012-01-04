package com.monarch.strat.gameplay {
	
	/**
	 * Represents a location on the stage.
	 * @author Forrest Jacobs
	 */
	public class Loc {
		
		private static const MAX:uint = 500;
		
		/**
		 * The constructor for Loc.
		 * @param col Column.
		 * @param row Row.
		 * @param access Used to prevent direct instantiation. Use Loc.at(col, row) instead.
		 * @private
		 */
		public function Loc(col:uint, row:uint, access:Private){
			if (access == null) throw new Error("FACTORY_EXCEPTION");
			_row = row;
			_col = col;
		}
		
		/**
		 * Creates or reuses a Loc at the given row and column
		 * @param col Column.
		 * @param row Row.
		 * @return A Loc at the given row and column.
		 */
		public static function at(col:uint, row:uint):Loc {
			if (row >= MAX || col >= MAX) return null;
			
			var sinkRow:Vector.<Loc> = sink[row] == null?
				sink[row] = new Vector.<Loc>(MAX) :
				sink[row];
			
			return sinkRow[col] == null?
				sinkRow[col] = new Loc(col, row, new Private) :
				sinkRow[col];
		}
		private static var sink:Vector.<Vector.<Loc>> = new Vector.<Vector.<Loc>>(MAX);

		/** The row. */
		public function get row():uint { return _row; }
		private var _row:uint;
		
		/** The column. */
		public function get col():uint { return _col; }
		private var _col:uint;

		/** The y position on screen. */
		public function get y():uint { return row * GridBlock.SIZE; }
		
		/** The x position on screen. */
		public function get x():uint { return col * GridBlock.SIZE; }
		
		/**
		 * Returns the Direction from the current Loc to the given Loc
		 * @param dest The destination Loc.
		 * @return The Direction pointing to the destination.
		 */
		public function directionTo(dest:Loc):uint {
			if (row != 0 && dest == Loc.at(col, row - 1))
				return Direction.NORTH;
			else if (dest == Loc.at(col + 1, row))
				return Direction.EAST;
			else if (dest == Loc.at(col, row + 1))
				return Direction.SOUTH;
			else if (col != 0 && dest == Loc.at(col - 1, row))
				return Direction.WEST;
			else
				return Direction.NONE;
		}
		
		/** The neighbors in each Direction */
		public function get neighbors():Vector.<Loc> {
			if (_neighbors == null){
				_neighbors = new Vector.<Loc>;
				_neighbors.push(Loc.at(col + 1, row));
				if (col != 0)
					_neighbors.push(Loc.at(col - 1, row));
				_neighbors.push(Loc.at(col, row + 1));
				if (row != 0)
					_neighbors.push(Loc.at(col, row - 1));
				if ((row + col) % 2 == 0)
					_neighbors.reverse();
			}
			return _neighbors;
		}
		private var _neighbors:Vector.<Loc> = null;
		
	}

}

internal class Private{}