package com.monarch.strat {
	import flash.utils.Dictionary;
	import com.monarch.strat.ui.MenuItem;
	import com.monarch.strat.ui.Menu;
	import com.monarch.strat.gameplay.*;
	import net.flashpunk.*;
	
	/**
	 * ...
	 * @author Forrest Jacobs
	 */
	public class Gameplay extends World {
		private var _stage:Stage;
		private var paths:Dictionary;
		private var displayPath:Path = null;
		private var unit:Unit;
		
		public function Gameplay(tag:String){
			_stage = new Stage(XML(new Assets.stages[tag]), this);
			
			var menu:Menu = new Menu(Vector.<MenuItem>([
				new MenuItem("Vincent's turn"),
				new MenuItem("Move", function():void {}),
				new MenuItem("Attack", function():void {}),
				new MenuItem("End Turn", function():void {})
			]));
			menu.x = 50;
			menu.y = 50;
			add(menu);
			
			unit = new Unit(Loc.at(9, 9));
			add(unit);
		}
		
		public function get stage():Stage { return _stage; }
	
		override public function update():void {
			super.update();
			if (paths == null) {
				paths = unit.paths;
			}
			if (paths != null) {
				var mouseLoc:Loc = Loc.at(FP.world.mouseX / Cell.SIZE, FP.world.mouseY / Cell.SIZE);
				var newDisplayPath:Path = paths[mouseLoc];
				if(displayPath != newDisplayPath) {
					if(displayPath != null) remove(displayPath);
					displayPath = newDisplayPath;
					if(displayPath != null) add(displayPath);
				}
			}
		}
		
	}

}