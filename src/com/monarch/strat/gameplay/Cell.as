package com.monarch.strat.gameplay {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Forrest Jacobs
	 */
	public class Cell extends Entity {
		
		public static const SIZE:uint = 24;
		
		public function Cell(loc:Loc, definition:CellDefinition = null) {
			super(loc.x, loc.y);
			if (definition == null)
				definition = CellDefinition.DEFAULT;
			_loc = loc;
			_cost = definition.cost;
			_walkable = definition.walkable;
			if (definition.graphic != null)
				graphic = new Image(definition.graphic);
		}
		
		private var _loc:Loc;
		
		public function get loc():Loc {
			return _loc;
		}
		
		private var _cost:uint;
		
		public function get cost():uint {
			return _cost;
		}
		
		private var _walkable:Boolean;
		
		public function get walkable():Boolean {
			return _walkable;
		}
		
		private var _distance:uint = uint.MAX_VALUE;
		private var _previous:Cell = null;
		
		public function get distance():uint {
			return _distance;
		}
		
		public function get previous():Cell {
			return _previous;
		}
		
		public function visit(prev:Cell, dist:uint):void {
			_distance = dist;
			_previous = prev;
		}
		
		public function reset():void {
			_distance = uint.MAX_VALUE;
			_previous = null;
		}
	
	}

}