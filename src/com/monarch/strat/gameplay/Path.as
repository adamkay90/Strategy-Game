package com.monarch.strat.gameplay {
	import com.monarch.strat.*;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	
	/**
	 * ...
	 * @author Forrest Jacobs
	 */
	
	public class Path {
		
		public static const PATH_COLOR:uint = 0x33FF00;
		public static const PATH_OUTLINE:uint = 0xFFFFFF;
		
		public static const GRAPHICS:Vector.<Image> = Vector.<Image>([
			new Image(Assets.directions["south"]),
			new Image(Assets.directions["west"]),
			new Image(Assets.directions["north"]),
			new Image(Assets.directions["east"])
		]);
		
		GRAPHICS.forEach(function(e: Image, i:uint, a:Vector.<Image>):void {
			e.color = PATH_COLOR;
		} );
		
		public static const BG_GRAPHICS:Vector.<Image> = Vector.<Image>([
			new Image(Assets.directions["bgsouth"]),
			new Image(Assets.directions["bgwest"]),
			new Image(Assets.directions["bgnorth"]),
			new Image(Assets.directions["bgeast"])
		]);
		
		BG_GRAPHICS.forEach(function(e: Image, i:uint, a:Vector.<Image>):void {
			e.color = PATH_OUTLINE;
		} );
		
		private var _start: Loc;
		private var _path: Vector.<Loc>;
		
		private var bgEntities:Vector.<Entity> = new Vector.<Entity>;
		private var entities:Vector.<Entity> = new Vector.<Entity>;
		
		public function Path(start:Loc, path:Vector.<Loc>){
			_start = start;
			_path = path;
		}
		
		public function get start(): Loc { return _start; }
		public function get path(): Vector.<Loc> { return _path; }
		
		public function display(target: Gameplay):void {
			if(entities.length == 0) {
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
			for each (var entity:Entity in bgEntities)
				target.add(entity);
			for each (entity in entities)
				target.add(entity);
		}
		
		private function add(start:Loc, end:Loc):void {
			var direction:uint = start.directionTo(end);
			if (direction != Direction.NONE){
				var entity:Entity = new Entity(start.x, start.y, GRAPHICS[direction]);
				var bgEntity:Entity = new Entity(start.x, start.y, BG_GRAPHICS[direction]);
				entity.layer = 1;
				bgEntity.layer = 1;
				entities.push(entity);
				bgEntities.push(bgEntity);
			}
		}
		
		public function hide(target: Gameplay):void {
			for each (var entity:Entity in bgEntities)
				target.remove(entity);
			for each (entity in entities)
				target.remove(entity);
		}
	
	}

}