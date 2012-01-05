package com.monarch.strat.gameplay {
	/**
	 * @author Forrest Jacobs
	 */
	public class Item {
		
		public function Item(xml: XML) {
			_name = xml.@name;
			_weight = xml.@weight;
		}
		
		public function get name(): String { return _name; }
		private var _name:String;
		
		public function get weight(): uint { return _weight; }
		private var _weight:uint;
		
	}
}
