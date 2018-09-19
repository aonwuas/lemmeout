package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;

//Superclass for doors as a changeable unpathable/pathable tile
class Door extends FlxSprite
{
	private var name:String;				//ID for setting switches
	private var open:Bool;				//Determines whether or not the door is open

	public function new(_name:String, ?x:Float = 0, ?y:Float = 0)
	{
		super(x, y);
		open = false;
		immovable = true;
		name = _name;
	}

	public function getName():String
	{
		return name;
	}

	public function isOpen():Bool
	{
		return open;
	}

	public function changeState():Void
	{
		switch(open){
			case false:
					solid = false;
					open = true;
					alpha = 0.0;
			case true:
					solid = true;
					open = false;
					alpha = 1.0;
		}
	}
}