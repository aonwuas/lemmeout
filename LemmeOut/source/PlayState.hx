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

class Door extends FlxSprite{
	var name:String;
	public function new(X:Float=0, Y:Float=0, myName:String="null") 
	{
		super(X, Y);
		loadGraphic(AssetPaths.ElectricalDoor__png, false, 8, 8);
		immovable = true;
		name = myName;
	}
	public function getName():String{
		return name;
	}
}

class BDoor extends FlxSprite{
	var name:String;
	public function new(X:Float=0, Y:Float=0, myName:String="null") 
	{
		super(X, Y);
		loadGraphic(AssetPaths.ButtonDoor__png, false, 8, 8);
		immovable = true;
		name = myName;
	}
	public function getName():String{
		return name;
	}
}

class Switch extends FlxSprite{
	var name:String;
	public function new(X:Float=0, Y:Float=0, myName:String="null") 
	{
		super(X, Y);
		loadGraphic(AssetPaths.ElectricalSwitch__png, false, 8, 8);
		immovable = true;
		name = myName;
	}
	
	public function getName():String{
		return name;
	}
}

class BSwitch extends FlxSprite{
	var name:String;
	public function new(X:Float=0, Y:Float=0, myName:String="null") 
	{
		super(X, Y);
		loadGraphic(AssetPaths.ButtonTile__png, false, 8, 8);
		immovable = true;
		name = myName;
	}
	public function getName():String{
		return name;
	}
}

class PlayState extends FlxState
{

public var _player:Player;
public var _bullet:FlxSprite;
public var walls:FlxObject;
public var exit:FlxSprite;
public var _mWalls:FlxTilemap;
public var _grpDoors:FlxTypedGroup<Door>;
public var _grpSwitches:FlxTypedGroup<Switch>;
public var _grpBDoors:FlxTypedGroup<BDoor>;
public var _grpBSwitches:FlxTypedGroup<BSwitch>;
public var doorsAndSwitches = new Map<>


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
		_grpDoors = new FlxTypedGroup<Door>();
		add(_grpDoors);
		_grpSwitches = new FlxTypedGroup<Switch>();
		add(_grpSwitches);
		_grpBDoors = new FlxTypedGroup<BDoor>();
		add(_grpBDoors);
		_grpBSwitches = new FlxTypedGroup<BSwitch>();
		add(_grpBSwitches);
		
		//setup bullet
		_bullet = new FlxSprite(0,0);
		_bullet.loadGraphic("assets/images/GD1_mindblip.png",false,16,16);
		add(_bullet);

		//setup player
		_player = new Player();
		//_player.flxsprite.setPosition(368, 1580);
		var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
		for (e in tmpMap.objects)
		{
			placeEntities(e.type, e.xmlData.x, e.name);
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
	
	function placeEntities(entityType:String, entityData:Xml, entityName:String):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityType == "start")
		{
         _player.flxsprite.x = x;
		 _player.flxsprite.y = y;
		}
		else if (entityType == "door"){
			_grpDoors.add(new Door(x, y, entityName));
		}
		else if (entityType == "switch"){
			_grpSwitches.add(new Switch(x, y, entityName));
		}
		else if (entityType == "bdoor"){
			_grpBDoors.add(new BDoor(x, y, entityName));
		}
		else if (entityType == "bswitch"){
			_grpBSwitches.add(new BSwitch(x, y, entityName));
		}
	
	}
	
	function pairDoorToSwitch{
		
	}
 
	override public function update(elapsed:Float):Void
	{
		if (FlxCollision.pixelPerfectCheck(_player.flxsprite, _bullet)){ _player.controlled = false; }
		_player.movement();
		super.update(elapsed);
		FlxG.collide(_player.flxsprite, _mWalls);
		FlxG.collide(_player.flxsprite, _grpDoors);
		FlxG.collide(_player.flxsprite, _grpBDoors);
	}
}