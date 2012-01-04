package com.monarch.strat.gameplay.updatefun {
	import com.monarch.strat.gameplay.Unit;
	import net.flashpunk.utils.Input;
	import com.monarch.strat.gameplay.UpdateFun;

	/**
	 * @author forrest
	 */
	public class UnitSelect extends UpdateFun {
		
		public override function init():void {
			gp.status = "Select a unit";
			gp.selector.visible = true;
		}
		
		public override function update():void {
			if(Input.mouseReleased) {
				var selected:Unit = gp.unitAt(gp.mouseLoc, "friend");
				if(selected != null) {
					gp.selector.visible = false;
					gp.updateFun = new UnitMenu(selected);
				}
			}
		}
		
		public override function destroy():void {
			gp.selector.visible = false;
		}
		
	}
}
