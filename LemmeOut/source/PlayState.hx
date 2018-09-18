package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.util.FlxCollision;
class PlayState extends FlxState
{

var _player:Player;
public var _bullet:FlxSprite;

	override public function create():Void
	{
		//setup bullet
		_bullet = new FlxSprite(0,0);
		_bullet.loadGraphic("assets/images/GD1_mindblip.png",false,16,16);
		add(_bullet);

		//setup player
		_player = new Player();
		Character.addToPlayState(this, _player);
		_player.screenCenter();
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxCollision.pixelPerfectCheck(_player.flxsprite, _bullet)){ _player.controlled = false; }
		_player.movement();
		super.update(elapsed);
	}
}