package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;

class IntroState extends FlxState
{
    var _comic:FlxSprite;

	override public function create():Void
	{
		FlxG.mouse.visible = false;

        _comic = new FlxSprite(0,0);
        _comic.loadGraphic("assets/images/GD1_IntroSheet.png",true,900,900);
        _comic.animation.add("comic", [0,0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,5,6], 1, true); //set fps to 1 for regular speed
        _comic.animation.play("comic");
        _comic.screenCenter();
        add(_comic);

		super.create();
	}
	override public function update(elapsed:Float):Void
	{
        if (_comic.animation.frameIndex == 6) { FlxG.switchState(new PlayState()); }
		else super.update(elapsed);
	}
}