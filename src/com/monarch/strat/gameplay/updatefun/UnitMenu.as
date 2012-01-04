package com.monarch.strat.gameplay.updatefun {
	import com.monarch.strat.ui.Item;
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
			
			menu = new List(Vector.<Item>([
				new Item(unit.def.nickName + "'s turn"),
				
				new Item("Move", function():void {
					gp.updateFun = new UnitMove(unit); }),
				
				new Item("Attack"),
				
				new Item("Cancel", function():void {
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
