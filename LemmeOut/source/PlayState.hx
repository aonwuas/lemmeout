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

public var _player:Player;
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
		add(_bullet);

		//setup player
		_player = new Player();
		_player.flxsprite.setPosition(368, 1580);
		var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
		for (e in tmpMap.objects)
		{
			placeEntities(e.type, e.xmlData.x);
		}
		Character.addToPlayState(this, _player);
		FlxG.camera.follow(_player.flxsprite, TOPDOWN, 1);
		_player.flxsprite.setGraphicSize(24, 24);
		_player.flxsprite.updateHitbox();
		_player.flxsprite.width = 20.0;
		_player.flxsprite.height = 20.0;
		_player.flxsprite.offset.set(4, 8);

		super.create();
	}
	
	function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "start")
		{
         _player.flxsprite.x = x;
		 _player.flxsprite.y = y;
		}
	
	}
 
	override public function update(elapsed:Float):Void
	{
		if (FlxCollision.pixelPerfectCheck(_player.flxsprite, _bullet)){ _player.controlled = false; }
		_player.movement();
		super.update(elapsed);
		FlxG.collide(_player.flxsprite, _mWalls);
	}
}