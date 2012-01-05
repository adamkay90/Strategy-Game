package com.monarch.strat.gameplay {
	import com.monarch.strat.gameplay.unit.Team;
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
				asset is XML? asset as XML :
				asset is String? XML(new Assets.stages[asset as String]) :
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
			
			_units = new Vector.<Unit>;
			for each (var xmlUnit:XML in xml["unit"]) {
				var unit:Unit = new Unit(xmlUnit.@name.toString(),
					Loc.at(xmlUnit.@col, xmlUnit.@row));
				units.push(unit);
				world.add(unit);
			}
		}
		
		public function get width():uint { return _width; }
		private var _width:uint;
		
		public function get height():uint { return _height; }
		private var _height:uint;
		
		public function get units():Vector.<Unit> { return _units; }
		private var _units:Vector.<Unit>;

		public function unitAt(loc:Loc, team:int = Team.NONE):Unit {
			for each(var unit:Unit in units) {
				if(loc == unit.loc && (team == Team.NONE || unit.def.team == team))
					return unit;
			}
			return null;
		}
		
		public function unitsOnTeam(team: int): Vector.<Unit> {
			var result: Vector.<Unit> = new Vector.<Unit>;
			for each(var unit:Unit in units) {
				if(unit.def.team == team)
					result.push(unit);
			}
			return result;
		}
		
		private function index(loc:Loc):int {
			return (loc.col < width && loc.row < height)?
				loc.row * width + loc.col : -1;
		}
		
		public function inBounds(loc:Loc):Boolean {
			return index(loc) != -1;
		}
		
		public function cellAt(loc:Loc):Cell {
			var index:int = index(loc);
			return index == -1 ? null : cellMap[index];
		}
		
		public function walkableNeighborsFor(cell:Cell, unwalkable:Vector.<Loc> = null):Vector.<Cell> {
			var result:Vector.<Cell> = new Vector.<Cell>;
			for each (var neighbor:Loc in cell.loc.neighbors){
				var nCell:Cell = cellAt(neighbor);
				if (nCell != null &&
						nCell.def.walkable &&
						(unwalkable == null || unwalkable.indexOf(nCell.loc) == -1))
					result.push(nCell);
			}
			return result;
		}
		
		public function findPaths(start:Loc, distance:uint,
				unwalkable:Vector.<Loc> = null, unreachable:Vector.<Loc> = null):Dictionary {
			
			var startCell:Cell = cellAt(start);
			startCell.visit(null, 0);
			
			var unvisited:Vector.<Cell> = Vector.<Cell>([startCell]);
			var visited:Vector.<Cell> = new Vector.<Cell>;
			
			while (unvisited.length != 0){
				var current:Cell = unvisited.pop();
				visited.push(current);
				for each (var neighbor:Cell in walkableNeighborsFor(current, unwalkable)){
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
				if(unreachable == null || unreachable.indexOf(dest.loc) == -1) {
					var path:Vector.<Loc> = new Vector.<Loc>;
					for (var cur:Cell = dest; cur != null; cur = cur.previous)
						path.unshift(cur.loc);
					result[dest.loc] = new Path(path);
				}
			}
			for each (var c:Cell in visited) c.reset();
			return result;
		}
	
	}

}