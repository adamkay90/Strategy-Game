package com.monarch.strat.gameplay {
	import com.monarch.strat.Gameplay;
	import net.flashpunk.Entity;

	public class GridBlock extends Entity {
		
		public static const SIZE:uint = 24;
		
		private var _loc:Loc;
		
		public function GridBlock(loc:Loc) {
			super(loc.x, loc.y);
			_loc = loc;
		}
		
		public function get gameplay():Gameplay {
			return (world != null && world is Gameplay)? world as Gameplay : null;
		}
		
		public function get stage():Stage {
			return gameplay == null ? null : gameplay.stage;
		}
		
		public function get loc():Loc {
			return _loc;
		}
		
		public function set loc(value:Loc):void {
			_loc = value;
			x = value.x;
			y = value.y;
		}
		
	}
}
