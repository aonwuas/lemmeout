package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;

//Superclass for all types of switches
class Switch extends FlxSprite
{
	private var flipped:Bool;							//Whether or not the switch is currently flipped
	private var unflipped_sprite:String;				//Sprites for both versions of the switch
	private var flipped_sprite:String;
	private var subject:Door;						//Other object subject to the switch
	private var subject_name:String;					//ID of the intended subject for setting the switch
	private var pressure:Bool;

	public function new(name:String, ?x:Float = 0, ?y:Float = 0){
		super(x, y);
		flipped = false;
		immovable = true;
		pressure = false;
		subject_name = name;
	}

	public function action():Void
	{
	}
	
	public function unaction():Void
	{
	}
	
	public function pressurize():Void
	{
	}

	public function getSubjectName():String
	{
		return subject_name;
	}
	
	public function getPressure():Bool{
		return pressure;
	}

	public function setSubject(_sub:Door):Void
	{
		subject = _sub;
	}
}