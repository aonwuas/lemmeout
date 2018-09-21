package;
import flixel.tile.FlxTilemap;
import Character.AnimationState;
import flixel.FlxG;
/**
 * ...
 * @author Anthony Ben Jerry Rachel Steven
 */
class ScienceSteve extends NPC 
{
	static var graphic:String = "assets/images/GD1_SteveSheet_walks.png";
	static var width:Int = 32;
	static var height:Int = 32;
	static var spd:Float = 200;
	
	public function new(colliders:FlxTilemap, ?x:Float=0, ?y:Float=0) 
	{
		super(colliders, x,y);
		setFlxSprite(ScienceSteve.graphic, true, ScienceSteve.width, ScienceSteve.height);
		setSpeed(ScienceSteve.spd);
		//addAnim("front", [0, 1], 2, true);
		addAnim(AnimationState.FRONT, [2, 3], 4, true);
		addAnim(AnimationState.BACK, [4, 5], 4, true);
		addAnim(AnimationState.SIDE, [6, 7], 4, true);
		addAnim(AnimationState.P_FRONT, [8, 9], 4, true);
		addAnim(AnimationState.P_BACK, [10, 11], 4, true);
		addAnim(AnimationState.P_SIDE, [12, 13], 4, true);
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