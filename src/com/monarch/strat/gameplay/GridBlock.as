package com.monarch.strat.gameplay {
	import net.flashpunk.graphics.Image;
	import com.monarch.strat.Gameplay;
	import net.flashpunk.Entity;

	public class GridBlock extends Entity {
		
		public static const SIZE:uint = 24;
		
		public function GridBlock(loc:Loc) {
			super(loc.x, loc.y);
			_loc = loc;
		}
		
		public function get gameplay():Gameplay { return world as Gameplay; }
		public function get stage():Stage { return gameplay.stage; }
		public function get image():Image { return graphic as Image; }
		
		public function get loc():Loc {return _loc;}
		public function set loc(value:Loc):void {
			_loc = value;
			x = value.x;
			y = value.y;
		}
		private var _loc:Loc;
		
	}
}
