package com.monarch.strat.gameplay {
	import com.monarch.strat.Assets;
	
	/**
	 * Represents a Cell type.
	 * @author Forrest Jacobs
	 */
	public class CellDef {
		
		public static const DEFAULT_NODE:XML =
			<define walkable="true" cost="1" />;
		
		public function CellDef(node:XML){
			_cost = ("@cost" in node? node : DEFAULT_NODE).@cost;
			_walkable = ("@walkable" in node? node : DEFAULT_NODE).@walkable == "true";
			_graphic = Assets.backgrounds[node.@graphic];
		}
		
		public function get cost():uint { return _cost; }
		private var _cost:uint;
		
		public function get walkable():Boolean { return _walkable; }
		private var _walkable:Boolean;

		public function get graphic():Class { return _graphic; }
		private var _graphic:Class;
		
	}

}