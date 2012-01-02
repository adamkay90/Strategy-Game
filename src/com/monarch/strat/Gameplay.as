package com.monarch.strat {
	import flash.utils.Dictionary;
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
		private var selector:Selector;

		public function Gameplay(tag:String){
			_stage = new Stage(XML(new Assets.stages[tag]), this);

			display = new List(Vector.<Item>([new Item("")]), 800);
			display.x = 0;
			display.y = 0;
			add(display);
			
			selector = new Selector();
			selector.visible = false;
			add(selector);

			var vincent:UnitDefinition = new UnitDefinition("vincent");
			var vincentUnit:Unit = new Unit(vincent, Loc.at(9, 9));
			units["friend"] = Vector.<Unit>([vincentUnit]);

			add(vincentUnit);
		}
		
		public function get stage():Stage { return _stage; }
		
		public function get mouseLoc():Loc { return _mouseLoc; }
		private var _mouseLoc:Loc;
		
		public function get isNewMouseLoc():Boolean { return _isNewMouseLoc; }
		private var _isNewMouseLoc:Boolean;
		
		override public function update():void {
			var newMouseLoc:Loc = Loc.at(FP.world.mouseX / GridBlock.SIZE, FP.world.mouseY / GridBlock.SIZE);
			_isNewMouseLoc = (newMouseLoc != mouseLoc);
			_mouseLoc = newMouseLoc;
			
			if(updateFun != null) updateFun.call(this);
			super.update();
		}
		
		// TODO: Implement team
		private function unitAt(loc:Loc, team:String = null):Unit {
			for each(var unit:Unit in units[team]) {
				if(unit.loc == loc)
					return unit;
			}
			return null;
		}
		
		private function unitSelectStart():void {
			display.items[0].text.text = "Select a unit";
			selector.visible = true;
			updateFun = unitSelect;
		}
		
		private function unitSelect():void {
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
				new Item("Move", moveStart),
				new Item("Attack"),
				new Item("Cancel", unitSelectStart)
			]), 200);
			menu.x = 800 - 200 - 10;
			menu.y = 24 + 10;
			add(menu);
			updateFun = null;
		}
		
		private var paths: Dictionary;
		private function moveStart(): void {
			display.items[0].text.text = "Choose a location";
			paths = currentUnit.paths;
			for (var reachable:Object in paths) {
				var cell:Cell = stage.cellAt(reachable as Loc);
				if(cell != null) {
					(cell.graphic as Image).color = 0x00FF00;
				}
			}
			selector.visible = true;
			updateFun = moveStage;
		}
		
		private var displayPath: Path;
		private function moveStage(): void {
			if(isNewMouseLoc) {
				if(displayPath != null) remove(displayPath);
				displayPath = paths[mouseLoc];
				selector.invalid = (displayPath == null);
				if(displayPath != null) add(displayPath);
			}
			if(displayPath != null && Input.mouseReleased) {
				for (var reachable:Object in paths) {
					var cell:Cell = stage.cellAt(reachable as Loc);
					if(cell != null) {
						(cell.graphic as Image).color = 0xFFFFFF;
					}
				}
				currentUnit.loc = displayPath.end;
				remove(displayPath);
				displayPath = null;
				selector.visible = false;
				unitSelectStart();
			}
		}
	
	}

}