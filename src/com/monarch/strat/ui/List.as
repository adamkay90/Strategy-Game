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
		
		private var _items:Vector.<Item>;
		private var innerWidth:int = 0;
		private var innerHeight:int = 0;
		private var background:TiledImage;
		private var selection:TiledImage;
		
		public function List(items:Vector.<Item>) {
			super();
			_items = items;
			
			resize();

			background = new TiledImage(Assets.backgrounds["menu"], width, height);
			background.alpha = 0.5;
			addGraphic(background);
			
			selection = new TiledImage(Assets.backgrounds["selected"], innerWidth, Item.HEIGHT);
			selection.x = PADDING;
			selection.visible = false;
			selection.alpha = 0.8;
			addGraphic(selection);
			
			var currentY:int = PADDING;
			for (var i:uint = 0; i < items.length; ++i) {
				var item:Item = items[i];
				item.x = PADDING;
				item.y = currentY;
				addGraphic(item);
				currentY += item.height;
			}
		}
		
		public function resize():void {
			var item:Item;
			innerHeight = 0;
			for each (item in items) {
				item.update();
				innerWidth = Math.max(innerWidth, item.width);
				innerHeight += item.height;
			}
			
			for each (item in items) {
				item.width = innerWidth;
			}
			
			width = innerWidth + 2 * PADDING;
			height = innerHeight + 2 * PADDING;
			
			if(background != null) {
				background.width = width;
				background.height = height;
			}
			
			if(selection != null) {
				selection.width = innerWidth;
			}
		}
		
		public function get items():Vector.<Item> { return _items; }
		
		private function getSelected(mouseX:int, mouseY:int):Item {
			var relMouseX:int = mouseX - x;
			var relMouseY:int = mouseY - y;
			if(relMouseX < PADDING || relMouseY < PADDING || relMouseX >= PADDING + innerWidth) return null;
			for each (var item:Item in _items) {
				if(item.isSelectable && relMouseY >= item.y && relMouseY < item.y + item.height) return item;
			}
			return null;
		}
		
		public override function update():void {
			var selected:Item = getSelected(FP.world.mouseX, FP.world.mouseY);
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
