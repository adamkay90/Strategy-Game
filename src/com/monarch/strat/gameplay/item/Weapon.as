package com.monarch.strat.gameplay.item {
	import com.monarch.strat.gameplay.Item;
	/**
	 * @author Forrest Jacobs
	 */
	public class Weapon extends Item {
		
		public function Weapon(xml: XML) {
			super(xml);
			_power = xml.@power;
			_accuracy = xml.@accuracy;
			_critical = xml.@critical;
		}
		
		public function get power(): uint { return _power; }
		private var _power:uint;
		
		public function get accuracy(): uint { return _accuracy; }
		private var _accuracy:uint;
		
		public function get critical(): uint { return _critical; }
		private var _critical:uint;
		
	}
}
