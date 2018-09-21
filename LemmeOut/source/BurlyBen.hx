package;
import flixel.tile.FlxTilemap;
import Character.AnimationState;
import flixel.FlxG;
/**
 * ...
 * @author Anthony Ben Jerry Rachel Steven
 */
class BurlyBen extends NPC 
{
	static var graphic:String = "assets/images/GD1_BenSheet.png";
	static var width:Int = 32;
	static var height:Int = 32;
	static var spd:Float = 100;
	
	public function new(colliders:FlxTilemap, ?x:Float=0, ?y:Float=0) 
	{
		super(colliders, x,y);
		setFlxSprite(BurlyBen.graphic, true, BurlyBen.width, BurlyBen.height);
		setSpeed(BurlyBen.spd);
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
		return "ben";
	}
	
}