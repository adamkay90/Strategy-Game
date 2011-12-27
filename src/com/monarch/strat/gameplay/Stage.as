package com.monarch.strat.gameplay {
	import net.flashpunk.Entity;
	import com.monarch.strat.Assets;
	import flash.utils.*;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Forrest Jacobs
	 */
	public class Stage {
		
		private var cellMap:Vector.<Cell>;
		
		public function Stage(xml:XML, world: World){
			var backdrop:Entity = new Entity(0, 0, new Backdrop(Assets.backgrounds[xml.@background]));
			backdrop.layer = 3;
			world.add(backdrop);
			
			var definitions:Object = new Object;
			for each (var definition:XML in xml.define){
				definitions[definition.@char] = CellDefinition.fromXML(definition);
			}
			
			var charMap:Array = xml.child("charmap").toString().split("\n");
			_height = charMap.length;
			_width = (charMap[0] as String).length;
			cellMap = new Vector.<Cell>(width * height);
			for (var y:uint = 0; y < height; ++y){
				for (var x:uint = 0; x < width; ++x){
					var loc:Loc = Loc.at(x, y);
					var cell:Cell = new Cell(loc, definitions[(charMap[y] as String).charAt(x)]);
					world.add(cell);
					cellMap[index(loc)] = cell;
				}
			}
		}
		
		private var _width:uint;
		
		public function get width():uint {
			return _width;
		}
		
		private var _height:uint;
		
		public function get height():uint {
			return _height;
		}
		
		private function index(loc:Loc):int {
			if (loc.col >= width || loc.row >= height)
				return -1;
			return loc.row * width + loc.col;
		}
		
		public function cellAt(loc:Loc):Cell {
			var index:int = index(loc);
			return index == -1 ? null : cellMap[index];
		}
		
		public function neighborsFor(cell:Cell):Vector.<Cell> {
			var result:Vector.<Cell> = new Vector.<Cell>;
			for each (var neighbor:Loc in cell.loc.neighbors){
				var nCell:Cell = cellAt(neighbor);
				if (nCell != null)
					result.push(nCell);
			}
			return result;
		}
		
		public function findPaths(start:Loc, distance:uint):Dictionary {
			var startCell:Cell = cellAt(start);
			startCell.visit(null, 0);
			
			var unvisited:Vector.<Cell> = Vector.<Cell>([startCell]);
			var visited:Vector.<Cell> = new Vector.<Cell>;
			
			while (unvisited.length != 0){
				var current:Cell = unvisited[0];
				for (var i:uint = 1; i < unvisited.length; ++i){
					var cell:Cell = unvisited[i];
					if (cell.distance < current.distance)
						current = cell;
				}
				var neighborDists:uint = current.distance + current.cost;
				unvisited.splice(unvisited.indexOf(current), 1);
				visited.push(current);
				if (neighborDists <= distance){
					for each (var neighbor:Cell in neighborsFor(current)){
						if (neighbor.walkable && neighborDists < neighbor.distance && visited.indexOf(neighbor) == -1){
							neighbor.visit(current, neighborDists);
							unvisited.push(neighbor);
						}
					}
				}
			}
			var result:Dictionary = new Dictionary;
			for each (var dest:Cell in visited){
				var path:Vector.<Loc> = new Vector.<Loc>;
				for (var cur:Cell = dest; cur != startCell; cur = cur.previous)
					path.unshift(cur.loc);
				result[dest.loc] = new Path(start, path);
			}
			for each (var c:Cell in visited)
				c.reset();
			return result;
		}
	
	}

}