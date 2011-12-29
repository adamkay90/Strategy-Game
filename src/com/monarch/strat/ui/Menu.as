package com.monarch.strat.ui {
	import net.flashpunk.utils.Input;
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
		private var innerWidth:int = 0;
		private var innerHeight:int = 0;
		private var background:TiledImage;
		private var selection:TiledImage;
		
		public function Menu(items:Vector.<MenuItem>) {
			super();
			this.items = items;
			var item:MenuItem;
			for each (item in items) {
				innerWidth = Math.max(innerWidth, item.width);
				innerHeight += item.height;
			}
			
			for each (item in items) {
				item.width = innerWidth;
			}
			
			this.width = innerWidth + 2 * PADDING;
			this.height = innerHeight + 2 * PADDING;

			background = new TiledImage(Assets.backgrounds["menu"], width, height);
			background.alpha = 0.5;
			addGraphic(background);
			
			selection = new TiledImage(Assets.backgrounds["selected"], innerWidth, MenuItem.HEIGHT);
			selection.x = PADDING;
			selection.visible = false;
			selection.alpha = 0.8;
			addGraphic(selection);
			
			var currentY:int = PADDING;
			for (var i:uint = 0; i < items.length; ++i) {
				item = items[i];
				item.x = PADDING;
				item.y = currentY;
				addGraphic(item);
				currentY += item.height;
			}
		}
		
		private function getSelected(mouseX:int, mouseY:int):MenuItem {
			var relMouseX:int = mouseX - x;
			var relMouseY:int = mouseY - y;
			if(relMouseX < PADDING || relMouseY < PADDING || relMouseX >= PADDING + innerWidth) return null;
			for each (var item:MenuItem in items) {
				if(item.isSelectable && relMouseY >= item.y && relMouseY < item.y + item.height) return item;
			}
			return null;
		}
		
		public override function update():void {
			var selected:MenuItem = getSelected(FP.world.mouseX, FP.world.mouseY);
			if(selected == null) selection.visible = false;
			else {
				selection.y = selected.y;
				selection.visible = true;
				if(Input.mouseReleased)
					selected.run();
			}
		}
		
	}
}
