package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;

class BasicSwitch extends Switch
{	
	public function new(_sub:String, ?x:Float = 0, ?y:Float = 0)
	{
		super(_sub, x, y);
		solid = false;
		unflipped_sprite = "assets/images/Tiles/ButtonTile.png";
		flipped_sprite = "assets/images/Tiles/PressedButtonTile.png";
		loadGraphic(unflipped_sprite, false, 64, 64);
		flipped = false;
	}

	override public function action():Void
	{
			if(!flipped)
			{
				if(!subject.isOpen())
				{
					subject.changeState();
				}
				loadGraphic(flipped_sprite, false, 32, 32);
				return;
			}
			else
			{
				subject.changeState();
				loadGraphic(unflipped_sprite, false, 32, 32);
			}
	}
	
	override public function pressurize():Void
	{
		pressure = true;
	}

}