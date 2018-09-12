package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;

class PlayState extends FlxState
{
var _playButton: FlxButton;
var _player:Player;

	override public function create():Void
	{
		_player = new Player(20,20);
		add(_player);
		super.create();
        _playButton = new FlxButton(0,0,"Play!",clickPlay);
        _playButton.screenCenter();
        add(_playButton);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

    function clickPlay():Void{
        FlxG.switchState(new PlayState());
    }
}