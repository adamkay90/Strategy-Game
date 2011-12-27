package com.monarch.strat.ui {
	import net.flashpunk.graphics.Text;
	/**
	 * @author forrest
	 */
	public class MenuItem extends Text {
		
		public static const X_PADDING:uint = 16;
		public static const Y_PADDING:uint = 3;
		public static const HEIGHT:uint = 18;
		
		private var action:Function;
		
		public function MenuItem(text:String, action:Function = null) {
			super(text);
			width = this.textWidth;

			this.action = action;
		}
		
		public function get isSelectable():Boolean { return action != null; }
		
		internal function run(): void {
			if(action != null) action.call(null, this);
		}
		
		public function get yStart():int { return y - Y_PADDING; }
		public function get yEnd():int { return y + HEIGHT + Y_PADDING; }
		
	}
}
