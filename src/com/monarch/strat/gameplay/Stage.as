package com.monarch.strat.gameplay {
	import com.monarch.strat.Assets;
	import flash.utils.*;
	import net.flashpunk.World;
	
	/**
	 * Represents a stage. 
	 * @author Forrest Jacobs
	 */
	public class Stage {
		
		/** Grid of cells that create the stage. */
		private var cellMap:Vector.<Cell>;
		
		public function Stage(asset: *, world: World){
			var xml:XML =
				(asset is XML) ? asset as XML :
				(asset is String) ? XML(new Assets.stages[asset as String]) :
				null;
			
			var defs:Object = new Object;
			for each (var xmlDef:XML in xml["define"])
				defs[xmlDef.@char] = new CellDef(xmlDef);
			
			var charMap:Array = xml.child("charmap").toString().split("\n");
			_height = charMap.length;
			_width = (charMap[0] as String).length - 1;
			
			cellMap = new Vector.<Cell>(width * height);
			for (var y:uint = 0; y < height; ++y){
				for (var x:uint = 0; x < width; ++x){
					var loc:Loc = Loc.at(x, y);
					var def:CellDef = defs[(charMap[y] as String).charAt(x)];
					var cell:Cell = new Cell(loc, def);
					world.add(cell);
					cellMap[index(loc)] = cell;
				}
			}
		}
		
		public function get width():uint { return _width; }
		private var _width:uint;
		
		public function get height():uint { return _height; }
		private var _height:uint;
		
		private function index(loc:Loc):int {
			return (loc.col < width && loc.row < height)?
				loc.row * width + loc.col : -1;
		}
		
		public function cellAt(loc:Loc):Cell {
			var index:int = index(loc);
			return index == -1 ? null : cellMap[index];
		}
		
		public function walkableNeighborsFor(cell:Cell):Vector.<Cell> {
			var result:Vector.<Cell> = new Vector.<Cell>;
			for each (var neighbor:Loc in cell.loc.neighbors){
				var nCell:Cell = cellAt(neighbor);
				if (nCell != null && nCell.def.walkable)
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
				var current:Cell = unvisited.pop();
				visited.push(current);
				for each (var neighbor:Cell in walkableNeighborsFor(current)){
					var neighborDist:uint = current.distance + neighbor.def.cost;
					if (neighborDist <= distance && neighborDist < neighbor.distance) {
						neighbor.visit(current, neighborDist);
						unvisited.push(neighbor);
					}
				}
				unvisited.sort(Cell.SortReverse);
			}
			var result:Dictionary = new Dictionary;
			for each (var dest:Cell in visited){
				var path:Vector.<Loc> = new Vector.<Loc>;
				for (var cur:Cell = dest; cur != null; cur = cur.previous)
					path.unshift(cur.loc);
				result[dest.loc] = new Path(path);
			}
			for each (var c:Cell in visited) c.reset();
			return result;
		}
	
	}

}