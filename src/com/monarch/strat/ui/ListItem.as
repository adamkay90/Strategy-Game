package com.monarch.strat.ui {
	import net.flashpunk.graphics.Text;
	/**
	 * @author forrest
	 */
	public class ListItem extends Block {
		
		public static const X_PADDING:uint = 8;
		public static const FUNCTION_X_PADDING:uint = 16;
		public static const Y_PADDING:uint = 3;
		public static const TEXT_HEIGHT:uint = 18;
		public static const HEIGHT:uint = TEXT_HEIGHT + 2 * Y_PADDING;
		
		private var action:Function;
		private var textGraphic:Text;
		private var enabled:Boolean;
		
		public function ListItem(text:String, action:Function = null, enabled:Boolean = true) {
			super();
			this.action = action;
			
			this.enabled = enabled;

			textGraphic = new Text(text);
			textGraphic.x = action == null? X_PADDING : FUNCTION_X_PADDING;
			textGraphic.y = Y_PADDING;
			if(!enabled) textGraphic.color = 0x999999;
			add(textGraphic);
			
			this.minWidth = textGraphic.textWidth + 2 * textGraphic.x;
			this.minHeight = TEXT_HEIGHT + 2 * Y_PADDING;
		}
		
		public function get isSelectable():Boolean { return enabled && action != null; }
		
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
