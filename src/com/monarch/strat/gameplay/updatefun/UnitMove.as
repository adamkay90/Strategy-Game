package com.monarch.strat.gameplay.updatefun {
	import net.flashpunk.utils.Input;
	import com.monarch.strat.gameplay.Loc;
	import com.monarch.strat.gameplay.Path;
	import flash.utils.Dictionary;
	import net.flashpunk.graphics.Image;
	import com.monarch.strat.gameplay.Cell;
	import com.monarch.strat.gameplay.Unit;
	import com.monarch.strat.gameplay.UpdateFun;

	/**
	 * @author forrest
	 */
	public class UnitMove extends UpdateFun {

		private var unit: Unit;
		private var paths: Dictionary;
		private var displayPath: Path;
		
		public function UnitMove(unit: Unit) {
			this.unit = unit;
		}
		
		public override function init(): void {
			gp.status = "Choose a location";
			paths = unit.paths;
			for (var reachable:Object in paths) {
				var cell:Cell = gp.stage.cellAt(reachable as Loc);
				if(cell != null)
					(cell.graphic as Image).color = 0x00FF00;
			}
			gp.selector.visible = true;
		}
		
		public override function update(): void {
			if(gp.isNewMouseLoc) {
				if(displayPath != null) gp.remove(displayPath);
				displayPath = paths[gp.mouseLoc];
				gp.selector.invalid = (displayPath == null);
				if(displayPath != null) gp.add(displayPath);
			}
			if(displayPath != null && Input.mouseReleased) {
				unit.loc = displayPath.end;
				gp.updateFun = new UnitSelect();
			}
		}
		
		public override function destroy(): void {
			for (var reachable:Object in paths) {
				var cell:Cell = gp.stage.cellAt(reachable as Loc);
				if(cell != null) {
					(cell.graphic as Image).color = 0xFFFFFF;
				}
			}
			gp.remove(displayPath);
			displayPath = null;
			gp.selector.visible = false;
		}
		
	}
}
