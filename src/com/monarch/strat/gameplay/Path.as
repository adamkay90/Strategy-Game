package com.monarch.strat.gameplay {
	import com.monarch.strat.*;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	
	/**
	 * ...
	 * @author Forrest Jacobs
	 */
	public class Path extends Entity {
		
		public static const PATH_COLOR:uint = 0x33FF00;
		public static const PATH_OUTLINE:uint = 0xFFFFFF;
		
		public static const GRAPHICS:Vector.<Class> = Vector.<Class>([
			Assets.directions["south"],
			Assets.directions["west"],
			Assets.directions["north"],
			Assets.directions["east"]
		]);
		
		private var _start: Loc;
		private var _path: Vector.<Loc>;
		
		public function Path(start:Loc, path:Vector.<Loc>){
			super();
			this.layer = Layers.PATH;

			_start = start;
			_path = path;
			
			if (path.length > 0){
				add(start, path[0]);
				add(path[0], start);
			}
			for (var i:uint = 0; i < path.length; ++i){
				if (i < path.length - 1)
					add(path[i], path[i + 1]);
				if (i != 0)
					add(path[i], path[i - 1]);
			}
		}
		
		public function get start(): Loc { return _start; }
		public function get path(): Vector.<Loc> { return _path; }
		public function get end(): Loc {
			return path.length > 0 ? path[path.length - 1] : start;
		}
		
		private function add(start:Loc, end:Loc):void {
			var direction:uint = start.directionTo(end);
			if (direction != Direction.NONE){
				var entity:Image = new Image(GRAPHICS[direction]);
				entity.x = start.x;
				entity.y = start.y;
				addGraphic(entity);
			}
		}
		
	}

}