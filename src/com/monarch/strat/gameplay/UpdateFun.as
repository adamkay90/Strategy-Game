package com.monarch.strat.gameplay {
	import com.monarch.strat.Gameplay;

	public class UpdateFun {
		
		public function get gp(): Gameplay { return _gameplay; }
		public function set gp(value: Gameplay): void { _gameplay = value; }
		private var _gameplay:Gameplay;
		
		public function init():void {}
		public function update():void { }
		public function destroy():void { }
		
	}
}
