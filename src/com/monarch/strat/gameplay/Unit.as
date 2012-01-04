package com.monarch.strat.gameplay {
	import net.flashpunk.tweens.motion.LinearPath;
	import flash.utils.Dictionary;

	import com.monarch.strat.Assets;
	import com.monarch.strat.gameplay.unit.*;
	import net.flashpunk.graphics.Image;

	public class Unit extends GridBlock {
		
		private static const BLOCKS_PER_SECOND:uint = 20;
		
		public function Unit(def: *, loc: Loc) {
			super(loc);
			_def = def is UnitDef? def : new UnitDef(def);
			layer = Layers.UNIT;
			graphic = new Image(Assets.cells["placeholder"]);
			image.color = this.def.team == Team.FRIEND? 0x00FF00 : 0xFF00FF;
		}
		
		public function get def(): UnitDef { return _def; }
		private var _def: UnitDef;
		
		public static function locsFrom(units: Vector.<Unit>): Vector.<Loc> {
			var result: Vector.<Loc> = new Vector.<Loc>(units.length);
			for(var i:uint = 0; i < units.length; ++i) {
				result[i] = units[i].loc;
			}
			return result;
		}
		
		public function get paths(): Dictionary {
			return stage.findPaths(loc, def.stats[StatType.MOVEMENT].value,
				locsFrom(stage.unitsOnTeam(def.team == Team.FRIEND? Team.FOE : Team.FRIEND)),
				locsFrom(stage.units));
		}
		
		public function move(path: Path):void {
			if(moveTween != null) removeTween(moveTween);

			loc = null;
			
			moveTween = new LinearPath(function():void {
				loc = path.end;
				moveTween = null;
			}, ONESHOT);
			
			for each(var point: Loc in path.path)
				moveTween.addPoint(point.x, point.y);
			
			addTween(moveTween);
			moveTween.setMotionSpeed(GridBlock.SIZE * BLOCKS_PER_SECOND);
		}
		private var moveTween: LinearPath = null;
		
		public override function update():void {
			if(moveTween != null) {
				x = moveTween.x;
				y = moveTween.y;
			}
			super.update();
		}
		
	}
}
