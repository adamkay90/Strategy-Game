package com.monarch.strat.ui {
	import net.flashpunk.graphics.Text;
	/**
	 * @author forrest
	 */
	public class Item extends Block {
		
		public static const X_PADDING:uint = 16;
		public static const Y_PADDING:uint = 3;
		public static const TEXT_HEIGHT:uint = 18;
		public static const HEIGHT:uint = TEXT_HEIGHT + 2 * Y_PADDING;
		
		private var action:Function;
		private var textGraphic:Text;
		
		public function Item(text:String, action:Function = null) {
			super();
			this.action = action;

			textGraphic = new Text(text);
			textGraphic.x = X_PADDING;
			textGraphic.y = Y_PADDING;
			add(textGraphic);
			this.minWidth = textGraphic.textWidth + 2 * X_PADDING;
			this.minHeight = TEXT_HEIGHT + 2 * Y_PADDING;
		}
		
		public function get isSelectable():Boolean { return action != null; }
		
		public function get text():String { return textGraphic.text; }
		public function set text(value: String):void { textGraphic.text = value; }
		
		public override function update():void {
			this.minWidth = textGraphic.textWidth + 2 * X_PADDING;
		}
		
		internal function run(): void {
			if(action != null) {
				action.call(null);
				
			}
		}
		
	}
}
