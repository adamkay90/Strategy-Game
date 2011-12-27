package com.monarch.strat.gameplay {
	
	/**
	 * Loc: Represents a location on the stage
	 * @author Forrest Jacobs
	 */
	public class Loc {
		
		// Creates a location.
		// Do not use this directory--instead, call Loc.at
		public function Loc(col:uint, row:uint, access:Private){
			if (access == null)
				throw new Error("FACTORY_EXCEPTION");
			_row = row;
			_col = col;
		}
		
		// Contains all the already constructed Locs
		private static var sink:Vector.<Vector.<Loc>> = new Vector.<Vector.<Loc>>;
		
		// Creates/grabs a location for the given x and y.
		public static function at(col:uint, row:uint):Loc {
			if (sink.length <= row)
				sink.length = row + 1;
			var sinkRow:Vector.<Loc> = sink[row];
			if (sinkRow == null){
				sinkRow = new Vector.<Loc>;
				sink[row] = sinkRow;
			}
			if (sinkRow.length <= col)
				sinkRow.length = col + 1;
			var loc:Loc = sinkRow[col];
			if (loc == null){
				loc = new Loc(col, row, new Private);
				sinkRow[col] = loc;
			}
			return loc;
		}
		
		// Getters for row & col
		private var _row:uint;
		
		public function get row():uint {
			return _row;
		}
		
		public function get y():uint {
			return row * Cell.SIZE;
		}
		
		private var _col:uint;
		
		public function get col():uint {
			return _col;
		}
		
		public function get x():uint {
			return col * Cell.SIZE;
		}
		
		// Gets the direction to the next loc
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
		
		// Gets the neighbors (and caches them)
		private var _neighbors:Vector.<Loc> = null;
		
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
		
		// Represents a location by the x and y
		public function toString():String {
			return "(" + col + ", " + row + ")";
		}
	
	}

}

class Private {
}