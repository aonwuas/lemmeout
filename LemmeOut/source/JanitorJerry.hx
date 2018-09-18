package;

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
	
	public function new(?x:Float=0, ?y:Float=0) 
	{
		super(x,y);
		setFlxSprite(JanitorJerry.graphic, true, JanitorJerry.width, JanitorJerry.height);
		setSpeed(JanitorJerry.spd);
	}
	
}