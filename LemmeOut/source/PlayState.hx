package;

import flixel.FlxObject;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.addons.editors.tiled.*;
import flixel.group.FlxGroup;
import flixel.system.debug.interaction.tools.Tool;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap;
import openfl.Assets;
import flixel.FlxObject;
import flixel.util.FlxCollision;
import flixel.FlxG;

class PlayState extends FlxState
{
	var _player:Player;
	var _jerry:JanitorJerry;
	public var _bullet:FlxSprite;
	public var walls:FlxObject;
	public var exit:FlxSprite;
	public var _mWalls:FlxTilemap;

	override public function create():Void
	{
		FlxG.mouse.visible = false;
		var _map:TiledMap;
		_map = new TiledMap(AssetPaths.test2__tmx);
		_mWalls = new FlxTilemap();
		_mWalls.loadMapFromArray(cast(_map.getLayer("floor"), TiledTileLayer).tileArray, _map.width, _map.height, AssetPaths.background__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 3);
		_mWalls.follow();
		_mWalls.setTileProperties(1, FlxObject.ANY);
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.NONE);
		_mWalls.setTileProperties(4, FlxObject.NONE);
		_mWalls.setTileProperties(5, FlxObject.NONE);
		_mWalls.setTileProperties(6, FlxObject.NONE);
		_mWalls.setTileProperties(7, FlxObject.NONE);
		_mWalls.setTileProperties(8, FlxObject.NONE);
		_mWalls.setTileProperties(9, FlxObject.NONE);
		_mWalls.setTileProperties(10, FlxObject.NONE);
		add(_mWalls);
		
		//setup bullet
		_bullet = new FlxSprite(0,0);
		_bullet.loadGraphic("assets/images/GD1_mindblip.png",false,16,16);

		//setup player
		_player = new Player(_mWalls);
		_jerry = new JanitorJerry(_mWalls, 0, 100);
		Character.addToPlayState(this, _jerry);
		Character.addToPlayState(this, _player);
		_player.screenCenter();

		_player.flxsprite.setGraphicSize(24,24);
		_player.flxsprite.updateHitbox();
		_player.flxsprite.width = 20.0;
		_player.flxsprite.height = 20.0;
		_player.flxsprite.offset.set(4,8);

		super.create();
	}
	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.E){ add(_bullet); }
		if (FlxCollision.pixelPerfectCheck(_jerry.flxsprite, _bullet)){
			_player.controlled = false;
			_jerry.getPossessed();
			_bullet.reset(0, 0);
			_bullet.kill();
		}
		_player.movement();
		_jerry.movement();
		super.update(elapsed);
	}
}