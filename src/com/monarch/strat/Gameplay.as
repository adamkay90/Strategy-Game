package com.monarch.strat {
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Image;
	import com.monarch.strat.ui.Item;
	import com.monarch.strat.ui.List;
	import com.monarch.strat.gameplay.*;
	import net.flashpunk.*;
	
	public class Gameplay extends World {
		
		private var _stage:Stage;
		private var updateFun:Function = unitSelectStart;
		
		private var units:Object = new Object;
		private var currentUnit:Unit = null;
		
		private var display:List;
		private var selector:GridBlock;

		private var mouseLoc:Loc;
		private var isNewMouseLoc:Boolean;
		
		public function Gameplay(tag:String){
			_stage = new Stage(XML(new Assets.stages[tag]), this);

			display = new List(Vector.<Item>([new Item("")]), 800);
			display.x = 0;
			display.y = 0;
			add(display);
			
			selector = new GridBlock(Loc.at(0, 0));
			selector.graphic = new Image(Assets.cells["select"]);
			selector.layer = Layers.SELECTOR;
			selector.visible = false;
			add(selector);

			var vincent:UnitDefinition = new UnitDefinition(XML(new Assets.units["vincent"]));
			var vincentUnit:Unit = new Unit(vincent, Loc.at(9, 9));
			units["friend"] = Vector.<Unit>([vincentUnit]);
			add(vincentUnit);
		}
		
		public function get stage():Stage { return _stage; }
		
		override public function update():void {
			super.update();
			var currentMouseLoc:Loc = Loc.at(FP.world.mouseX / GridBlock.SIZE, FP.world.mouseY / GridBlock.SIZE);
			if(currentMouseLoc != mouseLoc) {
				mouseLoc = currentMouseLoc;
				isNewMouseLoc = true;
			}
			else isNewMouseLoc = false;
			if(updateFun != null)
				updateFun.call(this);
			/*
			if (paths == null) {
				paths = unit.paths;
				for (var reachable:Object in paths) {
					var cell:Cell = stage.cellAt(reachable as Loc);
					if(cell != null) {
						(cell.graphic as Image).color = 0x00FF00;
					}
				}
			}
			if (paths != null) {
				var mouseLoc:Loc = Loc.at(FP.world.mouseX / GridBlock.SIZE, FP.world.mouseY / GridBlock.SIZE);
				var newDisplayPath:Path = paths[mouseLoc];
				if(displayPath != newDisplayPath) {
					if(displayPath != null) remove(displayPath);
					displayPath = newDisplayPath;
					if(displayPath != null) add(displayPath);
				}
			}
			*/
		}
		
		private function unitAt(loc:Loc, team:String = null):Unit {
			if(team != null) {
				for each(var unit:Unit in units[team]) {
					if(unit.loc == loc)
						return unit;
				}
			}
			return null;
		}
		
		private function unitSelectStart():void {
			display.items[0].text.text = "Select a unit";

			selector.visible = true;
			selector.loc = mouseLoc;

			updateFun = unitSelect;
			unitSelect();
		}
		
		private function unitSelect():void {
			if(isNewMouseLoc) selector.loc = mouseLoc;
			if(Input.mouseReleased) {
				var selectedUnit:Unit = unitAt(mouseLoc, "friend");
				if(selectedUnit != null) {
					selector.visible = false;
					select(selectedUnit);
				}
			}
		}
		
		private function select(unit:Unit): void {
			display.items[0].text.text = "Choose an action";
			currentUnit = unit;
			var menu:List = new List(Vector.<Item>([
				new Item(unit.definition.nickName + "'s turn"),
				new Item("Move"),
				new Item("Attack"),
				new Item("Cancel", unitSelectStart)
			]), 200);
			menu.x = 800 - 200 - 10;
			menu.y = 24 + 10;
			add(menu);
			updateFun = null;
		}
	
	}

}