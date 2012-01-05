package com.monarch.strat {
	import com.monarch.strat.gameplay.item.Weapon;
	/**
	 * @author Forrest Jacobs
	 */
	public class Resources {
		
		public static const weapons: Object = new Object;
		
		private static var alreadyInit: Boolean = false;
		public static function init(): void {
			if(alreadyInit) return;
			alreadyInit = true;
			
			// Items:
			for(var tag:String in Assets.items) {
				var xml:XML = XML(new Assets.items[tag]);
				// Add weapons
				for each (var weaponXML:XML in xml["weapon"]) {
					var weapon:Weapon = new Weapon(weaponXML);
					weapons[weapon.name] = weapon;
				}
			}
			
		}
		
		
	}
}
