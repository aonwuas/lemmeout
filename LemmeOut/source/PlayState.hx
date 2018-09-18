package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.util.FlxCollision;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.*;

class PlayState extends FlxState
{

var _player:Player;
public var _bullet:FlxSprite;

	override public function create():Void
	{
		//setup map
		var _map:TiledMap;
 		var _mWalls:FlxTilemap;
		_map = new TiledMap("assets/data/MapTest1.tmx");
		_mWalls = new FlxTilemap();
		_mWalls.loadMapFromArray(cast(_map.getLayer("walls"), TiledTileLayer).tileArray, _map.width, _map.height, "assets/images/TilesMapTest.png", _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 3);
		_mWalls.follow();
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.ANY);
		add(_mWalls);

		//setup bullet
		_bullet = new FlxSprite(0,0);
		_bullet.loadGraphic("assets/images/GD1_mindblip.png",false,16,16);
		add(_bullet);

		//setup player
		_player = new Player();
 		var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
		for (e in tmpMap.objects)
		{
			placeEntities(e.type, e.xmlData.x);
		}
		Character.addToPlayState(this, _player);
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxCollision.pixelPerfectCheck(_player.flxsprite, _bullet)){ _player.controlled = false; }
		_player.movement();
		super.update(elapsed);
		//FlxG.collide(_player.flxsprite, _mWalls);
	}

	function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player")
		{
			_player.flxsprite.x = x;
			_player.flxsprite.y = y;
		}
	}
}