package com.monarch.strat.ui {
	import net.flashpunk.graphics.Graphiclist;

	/**
	 * @author forrest
	 */
	public class Block extends Graphiclist {
		
		private var _minWidth:uint = 0;
		private var _width:uint = 0;

		public function get minWidth():uint { return _minWidth; }
		public function get width():uint { return _width; }

		public function set minWidth(value:uint):void {
			_minWidth = value;
			_width = Math.max(_width, _minWidth);
		}
		
		public function set width(value:uint):void {
			if(value >= _minWidth)
				_width = value;
		}
		
		private var _minHeight:uint = 0;
		private var _height:uint = 0;

		public function get minHeight():uint { return _minHeight; }
		public function get height():uint { return _height; }

		public function set minHeight(value:uint):void {
			_minHeight = value;
			_height = Math.max(_height, _minHeight);
		}
		
		public function set height(value:uint):void {
			if(value >= _minHeight)
				_height = value;
		}
		
	}
}
