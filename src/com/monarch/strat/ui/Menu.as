package com.monarch.strat.ui {
	import net.flashpunk.FP;
	import net.flashpunk.graphics.TiledImage;
	import com.monarch.strat.Assets;
	import net.flashpunk.Entity;
	/**
	 * @author forrest
	 */
	public class Menu extends Entity {
		
		public static const PADDING:uint = 2;
		
		private var items:Vector.<MenuItem>;
		private var textWidth:int = 0;
		private var background:TiledImage;
		private var selection:TiledImage;
		
		public function Menu(items:Vector.<MenuItem>) {
			super();
			this.items = items;
			var item:MenuItem;
			for each (item in items)
				textWidth = Math.max(textWidth, item.width);

			background = new TiledImage(Assets.backgrounds["menu"],
				textWidth + 2 * (MenuItem.X_PADDING + PADDING), 
				2 * PADDING + items.length * (MenuItem.HEIGHT + 2 * MenuItem.Y_PADDING));
			background.alpha = 0.5;
			addGraphic(background);
			
			selection = new TiledImage(Assets.backgrounds["selected"],
				textWidth + 2 * MenuItem.X_PADDING,
				MenuItem.HEIGHT + 2 * MenuItem.Y_PADDING);
			selection.x = PADDING;
			selection.visible = false;
			addGraphic(selection);
			
			var lastY:int = PADDING;
			for (var i:uint = 0; i < items.length; ++i) {
				item = items[i];
				item.x = PADDING + MenuItem.X_PADDING;
				item.y = lastY + MenuItem.Y_PADDING;
				lastY = item.yEnd;
				addGraphic(item);
			}
		}
		
		private function getSelected(mouseX:int, mouseY:int):int {
			var relMouseX:int = mouseX - x;
			var relMouseY:int = mouseY - y;
			if(relMouseX < PADDING || relMouseX >= PADDING + textWidth + 2 * MenuItem.X_PADDING) return -1;
			if(relMouseY < PADDING) return -1;
			for (var i:uint = 0; i < items.length; ++i) {
				var item:MenuItem = items[i];
				if(item.isSelectable && relMouseY >= item.yStart && relMouseY < item.yEnd) return i;
			}
			return -1;
		}
		
		public override function update():void {
			var selected:int = getSelected(FP.world.mouseX, FP.world.mouseY);
			if(selected == -1) selection.visible = false;
			else {
				trace(selected);
				selection.visible = true;
				selection.y = items[selected].yStart;
			}
		}
		
	}
}
