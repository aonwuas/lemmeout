package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.util.FlxCollision;
class PlayState extends FlxState
{

var _map:TiledMap;
var _mWalls:FlxTilemap;
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
		//setup map
		_map = new TiledMap(AssetPaths.room_001__tmx);
		_mWalls = new FlxTilemap();
		_mWalls.loadMapFromArray(cast(_map.getLayer("walls"), TiledTileLayer).tileArray, _map.width, _map.height, AssetPaths.tiles__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 3);
		_mWalls.follow();
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.ANY);
		add(_mWalls);

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