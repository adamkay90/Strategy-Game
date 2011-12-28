package com.monarch.strat.gameplay {
	import com.monarch.strat.Assets;
	
	/**
	 * ...
	 * @author Forrest Jacobs
	 */
	public class CellDefinition {
		
		public static const DEFAULT_COST:uint = 1;
		public static const DEFAULT_WALKABLE:Boolean = true;
		
		private var _cost:uint;
		private var _walkable:Boolean;
		private var _graphic:Class;
		
		public function CellDefinition(cost:uint = DEFAULT_COST, walkable:Boolean = DEFAULT_WALKABLE, graphic:Class = null){
			_cost = cost;
			_walkable = walkable;
			_graphic = graphic;
		}
		
		public static function fromXML(node:XML, defaultBG:Class):CellDefinition {
			var cost:uint = DEFAULT_COST;
			if ("@cost" in node)
				cost = node.@cost;
			
			var walkable:Boolean = DEFAULT_WALKABLE;
			if ("@walkable" in node)
				walkable = (node.@walkable == "true");
			
			var graphic:Class = null;
			if ("@graphic" in node)
				graphic = Assets.backgrounds[node.@graphic];
			else
				graphic = defaultBG;
			
			return new CellDefinition(cost, walkable, graphic);
		}
		
		public function get cost():uint {
			return _cost;
		}
		
		public function get walkable():Boolean {
			return _walkable;
		}
		
		public function get graphic():Class {
			return _graphic;
		}
	
	}

}