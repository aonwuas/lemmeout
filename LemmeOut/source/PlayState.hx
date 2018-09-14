package;

import flixel.FlxState;

class PlayState extends FlxState
{

var _player:Player;

	override public function create():Void
	{
		_player = new Player();
		add(_player);
		_player.screenCenter();
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		_player.movement();
		super.update(elapsed);
	}
}