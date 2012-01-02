package com.monarch.strat.gameplay {
	import com.monarch.strat.Assets;
	import net.flashpunk.graphics.Image;
	/**
	 * @author forrest
	 */
	public class Selector extends GridBlock {
		
		public function Selector() {
			super(Loc.at(0, 0));
			layer = Layers.SELECTOR;
			graphic = new Image(Assets.cells["select"]);
		}
		
		public function get invalid():Boolean {
			return image.color == 0xFF0000;
		}
		public function set invalid(value:Boolean):void {
			image.color = value? 0xFF0000 : 0xFFFFFF;
		}
		
	}
}
