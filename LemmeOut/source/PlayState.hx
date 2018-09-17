package;

import flixel.FlxState;
//import flixel.FlxObject;
class PlayState extends FlxState
{

var _player:Player2;

	override public function create():Void
	{
		_player = new Player2();
		Character.addToPlayState(this, _player);
		_player.screenCenter();
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		_player.movement();
		super.update(elapsed);
	}
}