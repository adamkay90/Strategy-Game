package com.monarch.strat.gameplay.updatefun {
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import com.monarch.strat.gameplay.item.Weapon;
	import com.monarch.strat.ui.ListItem;
	import com.monarch.strat.ui.List;
	import com.monarch.strat.gameplay.Unit;
	import com.monarch.strat.gameplay.UpdateFun;

	/**
	 * @author forrest
	 */
	public class UnitMenu extends UpdateFun {
		
		private var unit:Unit;
		private var menu:List;
		
		public function UnitMenu(unit: Unit) {
			this.unit = unit;
		}
		
		public override function init(): void {
			gp.status = "Choose an action";
			
			menu = new List(Vector.<ListItem>([
				new ListItem(unit.def.nickName + "'s turn"),
				
				new ListItem("Move", function():void {
					gp.updateFun = new UnitMove(unit); }),
				
				new ListItem("Attack", function():void {
					var weapon:Weapon = unit.def.weapon;
					gp.status = weapon.name + "   power: " + weapon.power;
					gp.addTween(new Alarm(2, function():void {
						gp.updateFun = new UnitSelect();
					}, Tween.ONESHOT), true);
				}, unit.def.weapon != null),
				
				new ListItem("Cancel", function():void {
					gp.updateFun = new UnitSelect(); })
			]), 200);
			
			menu.x = 590;
			menu.y = 34;
			
			gp.add(menu);
		}
		
		public override function destroy(): void {
			gp.remove(menu);
		}
		
		
		
	}
}
