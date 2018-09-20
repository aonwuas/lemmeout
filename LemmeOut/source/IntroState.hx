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
        _comic.loadGraphic("assets/images/background.png",true,32,32);
        _comic.animation.add("comic", [0,1,2,3,4,5,6,7,8,9], 255, true);
        _comic.animation.play("comic");
        _comic.screenCenter();
        add(_comic);

		super.create();
	}
	override public function update(elapsed:Float):Void
	{
        if (_comic.animation.frameIndex == 9) { FlxG.switchState(new PlayState()); }
		super.update(elapsed);
	}
}