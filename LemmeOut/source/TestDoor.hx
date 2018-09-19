package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;

class TestDoor extends Door{

	public function new(_name:String, ?x:Float = 0, ?y:Float = 0)
	{
		super(_name, x, y);
		loadGraphic("assets/images/Tiles/door.png", false, 32, 32);
	}
}