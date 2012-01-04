package com.monarch.strat {
	import com.monarch.strat.gameplay.updatefun.UnitSelect;
	import com.monarch.strat.ui.*;
	import com.monarch.strat.gameplay.*;
	import net.flashpunk.*;
	
	public class Gameplay extends World {
		
		private var display:List;

		public function Gameplay(tag:String){
			_stage = new Stage(tag, this);

			display = new List(Vector.<Item>([new Item("")]), 800);
			display.x = 0;
			display.y = 0;
			add(display);
			
			_selector = new Selector();
			selector.visible = false;
			add(selector);

			updateFun = new UnitSelect();
		}
		
		public function get stage():Stage { return _stage; }
		private var _stage:Stage;
		
		public function get updateFun():UpdateFun { return _updateFun; }
		public function set updateFun(value:UpdateFun):void {
			if(updateFun != null) updateFun.destroy();
			_updateFun = value;
			updateFun.gp = this;
			updateFun.init();
		}
		private var _updateFun:UpdateFun;
		
		public function get mouseLoc():Loc { return _mouseLoc; }
		private var _mouseLoc:Loc;
		
		public function get isNewMouseLoc():Boolean { return _isNewMouseLoc; }
		private var _isNewMouseLoc:Boolean;

		public function get selector():Selector { return _selector; }		
		private var _selector:Selector;
		
		public function get status():String { return display.items[0].text; }
		public function set status(value:String):void { display.items[0].text = value; }

		override public function update():void {
			var newMouseLoc:Loc = Loc.at(
				FP.world.mouseX / GridBlock.SIZE,
				FP.world.mouseY / GridBlock.SIZE);
			if(!stage.inBounds(newMouseLoc))
				newMouseLoc = null;
			_isNewMouseLoc = (newMouseLoc != mouseLoc);
			_mouseLoc = newMouseLoc;
			
			updateFun.update();
			super.update();
		}
		
	}

}