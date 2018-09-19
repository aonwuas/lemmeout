package;
import flixel.tile.FlxTilemap;
/**
 * ...
 * @author Anthony Ben Jerry Rachel Steven
 */
class JanitorJerry extends NPC 
{
	static var graphic:String = "assets/images/GD1_JerrySheet.png";
	static var width:Int = 32;
	static var height:Int = 32;
	static var spd:Float = 200;
	
	public function new(colliders:FlxTilemap, ?x:Float=0, ?y:Float=0) 
	{
		super(colliders, x,y);
		setFlxSprite(JanitorJerry.graphic, true, JanitorJerry.width, JanitorJerry.height);
		setSpeed(JanitorJerry.spd);
		addAnim("front", [0, 1], 2, true);
		addAnim("back", [2, 3], 2, true);
		addAnim("side", [3, 4], 2, true);
	}
	
}