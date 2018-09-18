package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
//import flixel.FlxObject;
class PlayState extends FlxState
{

var _player:Player;
var _jerry:JanitorJerry;
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
		_jerry = new JanitorJerry(30,30);
		Character.addToPlayState(this, _player);
		Character.addToPlayState(this, _jerry);
		_player.screenCenter();
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		_player.movement();
		_jerry.movement();
		super.update(elapsed);
	}
}