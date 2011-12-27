package com.monarch.strat {
	import com.monarch.strat.ui.MenuItem;
	import com.monarch.strat.ui.Menu;
	import com.monarch.strat.gameplay.*;
	import net.flashpunk.*;
	
	/**
	 * ...
	 * @author Forrest Jacobs
	 */
	public class Gameplay extends World {
		private var stage:Stage;
		
		public function Gameplay(tag:String){
			stage = new Stage(XML(new Assets.stages[tag]), this);
			var menu:Menu = new Menu(Vector.<MenuItem>([
				new MenuItem("Vincent's turn"),
				new MenuItem("Move", function():void {}),
				new MenuItem("Attack", function():void {}),
				new MenuItem("End Turn", function():void {})
			]));
			menu.x = 50;
			menu.y = 50;
			add(menu);
		}
		
		override public function update():void {
			super.update();
			var mouseLoc:Loc = Loc.at(FP.world.mouseX / Cell.SIZE, FP.world.mouseY / Cell.SIZE);
		}
	
	}

}