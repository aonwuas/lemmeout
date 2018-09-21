package;
import Character.MoveState;
import flixel.tile.FlxTilemap;
import Character.AnimationState;
import flixel.FlxG;
/**
 * ...
 * @author Anthony Ben Jerry Rachel Steven
 */

class ScienceSteve extends NPC 
{
	static var graphic:String = "assets/images/GD1_SteveSheet.png";
	static var width:Int = 32;
	static var height:Int = 32;
	static var spd:Float = 300;
	
	public function new(colliders:FlxTilemap, ?x:Float=0, ?y:Float=0, ?s_bev:String="PATROL", ?s_dir:String="DOWN", ?player:Player=null)
	{
		super(colliders, x,y, s_bev, s_dir, player);
		setFlxSprite(ScienceSteve.graphic, true, ScienceSteve.width, ScienceSteve.height);
		setSpeed(ScienceSteve.spd);
		//addAnim("front", [0, 1], 2, true);
		addAnim(AnimationState.FRONT, [0, 1], 4, true);
		addAnim(AnimationState.BACK, [2, 3], 4, true);
		addAnim(AnimationState.SIDE, [4, 5], 4, true);
		addAnim(AnimationState.P_FRONT, [6, 7], 4, true);
		addAnim(AnimationState.P_BACK, [8, 9], 4, true);
		addAnim(AnimationState.P_SIDE, [10, 11], 4, true);
	}
	
	override public function getPossessed() 
	{
		super.getPossessed();
		FlxG.camera.follow(this.flxsprite, TOPDOWN, 1);
	}
	
	override public function getName():String{
		return "steve";
	}
	
}