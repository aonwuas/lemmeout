package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;

class Box extends FlxSprite
{
	public function new(?x:Float = 0, ?y:Float = 0)
	{
		super(x, y);
		loadGraphic("assets/images/Tiles/block.png", false, 32, 32);
		//immovable = true;
		this.drag.x = this.drag.y = 1600;
		this.setGraphicSize(20, 20);
		this.updateHitbox();
		immovable = true;
	}
	
	
	public function soften():Void
	{
		immovable = false;
	}
}