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
class PlayState extends FlxState
{

var _player:Player;
public var playerBullets:FlxTypedGroup<FlxSprite>;
public var walls:FlxObject;
public var exit:FlxSprite;

	override public function create():Void
	{
		/*var tileMap:FlxTilemap = new FlxTilemap();
        var mapData:String = Assets.getText("assets/data/level1.csv");
        var mapTilePath:String = "assets/images/Levels/FloorAndWallTiles.tsx";
        tileMap.loadMap(mapData, mapTilePath, 16, 16);
        add(tileMap);*/
		var _map:TiledMap;
		var _mWalls:FlxTilemap;
		_map = new TiledMap(AssetPaths.test2__tmx);
		_mWalls = new FlxTilemap();
		_mWalls.loadMapFromArray(cast(_map.getLayer("floor"), TiledTileLayer).tileArray, _map.width, _map.height, AssetPaths.background__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 3);
		_mWalls.follow();
		_mWalls.setTileProperties(0, FlxObject.ANY);
		_mWalls.setTileProperties(1, FlxObject.NONE);
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.NONE);
		_mWalls.setTileProperties(4, FlxObject.NONE);
		_mWalls.setTileProperties(5, FlxObject.NONE);
		_mWalls.setTileProperties(6, FlxObject.NONE);
		_mWalls.setTileProperties(7, FlxObject.NONE);
		_mWalls.setTileProperties(8, FlxObject.NONE);
		_mWalls.setTileProperties(9, FlxObject.NONE);
		add(_mWalls);
 
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
		/*
		var tmpMap:TiledObjectLayer = cast _map.getLayer("GameObjects");
		for (e in tmpMap.objects)
		{
			placeEntities(e.type, e.xmlData.x);
		}

*/
		super.create();
	}
	/*
	 function placeEntities(entityName:String, entityData:Xml):Void
	 {
     var x:Int = Std.parseInt(entityData.get("x"));
     var y:Int = Std.parseInt(entityData.get("y"));
     if (entityName == "player")
		{
         _player.x = x;
         _player.y = y;
		}
	 }
	*/
	 
	override public function update(elapsed:Float):Void
	{
		_player.movement();
		super.update(elapsed);
	}
}