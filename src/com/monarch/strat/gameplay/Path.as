package com.monarch.strat.gameplay {
	import com.monarch.strat.*;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	
	/**
	 * ...
	 * @author Forrest Jacobs
	 */
	public class Path extends Entity {
		
		public static const GRAPHICS:Vector.<Class> = Vector.<Class>([
			Assets.directions["south"],
			Assets.directions["west"],
			Assets.directions["north"],
			Assets.directions["east"]
		]);
		
		
		public function Path(path:Vector.<Loc>){
			super();
			_path = path;
			this.layer = Layers.PATH;
			
			for (var i:uint = 0; i < path.length; ++i){
				if (i < path.length - 1) add(path[i], path[i + 1]);
				if (i != 0) add(path[i], path[i - 1]);
			}
		}
		
		public function get path(): Vector.<Loc> { return _path; }
		private var _path: Vector.<Loc>;
		
		public function get length(): uint { return path.length; }

		public function get start(): Loc { return path[0]; }
		public function get end(): Loc { return path[length - 1]; }
		
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