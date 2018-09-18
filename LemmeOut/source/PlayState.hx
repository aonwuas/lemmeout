package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
//import flixel.FlxObject;
class PlayState extends FlxState
{

var _player:Player;
public var playerBullets:FlxTypedGroup<FlxSprite>;

	override public function create():Void
	{
		//setup bullets
		var numPlayerBullets:Int = 10;
		playerBullets = new FlxTypedGroup(numPlayerBullets);
		var sprite:FlxSprite;
		for (i in 0...numPlayerBullets) //recycle bullets
		{
			//instantiate a new sprite offscreen
			sprite = new FlxSprite(0,0);
			sprite.loadGraphic("assets/images/GD1_mindblip.png",false,16,16);
			sprite.exists = false;
			playerBullets.add(sprite);
		}
		add(playerBullets);

		//setup player
		_player = new Player();
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