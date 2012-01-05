package com.monarch.strat.ui {
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.TiledImage;
	import com.monarch.strat.Assets;
	import net.flashpunk.Entity;
	/**
	 * @author forrest
	 */
	public class List extends Entity {
		
		public static const PADDING:uint = 2;
		
		private var _items:Vector.<ListItem>;
		private var innerWidth:int = 0;
		private var innerHeight:int = 0;
		private var background:TiledImage;
		private var selection:TiledImage;
		
		public function List(items:Vector.<ListItem>, width:uint) {
			super();
			var item:ListItem;

			_items = items;
			
			this.width = width;
			innerWidth = width - 2 * PADDING;
			
			for each (item in items) {
				item.width = innerWidth;
				innerHeight += item.height;
			}
			
			height = innerHeight + 2 * PADDING;
			
			background = new TiledImage(Assets.backgrounds["menu"], width, height);
			background.alpha = 0.5;
			addGraphic(background);
			
			selection = new TiledImage(Assets.backgrounds["selected"], innerWidth, ListItem.HEIGHT);
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
		
		public function get items():Vector.<ListItem> { return _items; }
		
		private function getSelected(mouseX:int, mouseY:int):ListItem {
			var relMouseX:int = mouseX - x;
			var relMouseY:int = mouseY - y;
			if(relMouseX < PADDING || relMouseY < PADDING || relMouseX >= PADDING + innerWidth) return null;
			for each (var item:ListItem in _items) {
				if(item.isSelectable && relMouseY >= item.y && relMouseY < item.y + item.height) return item;
			}
			return null;
		}
		
		public override function update():void {
			var selected:ListItem = getSelected(FP.world.mouseX, FP.world.mouseY);
			if(selected == null) selection.visible = false;
			else {
				selection.y = selected.y;
				selection.visible = true;
				if(Input.mouseReleased) {
					selected.run();
					world.remove(this);
				}
			}
		}
		
	}
}
