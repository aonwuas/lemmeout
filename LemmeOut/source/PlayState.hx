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
	public var doors_group:FlxTypedGroup<Door>;
	public var switches_group:FlxTypedGroup<Switch>;
	public var _map:TiledMap;

	override public function create():Void
	{
		FlxG.mouse.visible = false;
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

		//create doors and obstacles
		doors_group = new FlxTypedGroup<Door>();
		add(doors_group);
		switches_group = new FlxTypedGroup<Switch>();
		add(switches_group);

		var tmp_map:TiledObjectLayer = cast _map.getLayer("obstacles");
		placeObjects(tmp_map.objects);
		setSwitches();
		
		//setup bullet
		_bullet = new FlxSprite(0,0);
		_bullet.loadGraphic("assets/images/GD1_mindblip.png",false,16,16);

		//setup player
		_player = new Player(_mWalls);
		_jerry = new JanitorJerry(_mWalls, 0, 100);
		Character.addToPlayState(this, _jerry);
		Character.addToPlayState(this, _player);
		_player.screenCenter();
		FlxG.camera.follow(_player.flxsprite, TOPDOWN, 1);
		_player.flxsprite.setPosition(368, 1580);

		_player.flxsprite.setGraphicSize(24,24);
		_player.flxsprite.updateHitbox();
		_player.flxsprite.width = 20.0;
		_player.flxsprite.height = 20.0;
		_player.flxsprite.offset.set(4,8);

		_jerry.flxsprite.setGraphicSize(24,24);
		_jerry.flxsprite.updateHitbox();
		_jerry.flxsprite.width = 20.0;
		_jerry.flxsprite.height = 20.0;
		_jerry.flxsprite.offset.set(4,8);

		super.create();
	}

	//function to place all interactable objects in the level
	public function placeObjects(objects:Array<TiledObject>):Void
	{
		for(object in objects)
		{
			var type:String = object.type;
			var data:Xml = object.xmlData.x;

			var x:Int = Std.parseInt(data.get("x"));
			var y:Int = Std.parseInt(data.get("y"));
			switch(type)
			{
				case "TestDoor":
					var name:String = object.name;
					doors_group.add(new TestDoor(name, x, y));
				case "TestSwitch":
					var subject_name:String = object.properties.get("Subject");
					var _switch:Switch = new TestSwitch(subject_name, x, y);
					switches_group.add(_switch);
					//trace("name: " + object.name + " x: " + object.x + ", y : " + object.y + ", height: " + object.height + ", width: " + object.width);
					//trace("sprite: x: " + _switch.x + ", y: " + _switch.y + ", height: " + _switch.height + ", width: " + _switch.width);
			}
		}
	}

	public function setSwitches():Void
	{
		for(_switch in switches_group.members)
		{
			var target_name:String = _switch.getSubjectName();
			var target:Door;
			for(door in doors_group)
			{
				if(door.getName() == target_name)
				{
					_switch.setSubject(door);
					break;
				}
			}
		}
	}
/*
	public function triggerSwitch(sprite1:FlxSprite, _switch:Switch)
	{
		trace("Triggered switch for " + _switch.getSubjectName());
		_switch.action();
	}
*/
	override public function update(elapsed:Float):Void
	{
		//testing purposes: END GAME
		if (_player.end_game){ FlxG.switchState(new EndState()); }

		//shoot bullet
		if (FlxG.keys.justPressed.E){ add(_bullet); }
		if (FlxCollision.pixelPerfectCheck(_jerry.flxsprite, _bullet)){ //bullet hits jerry
			_player.controlled = false;
			_jerry.getPossessed();
			_bullet.reset(0, 0);
			_bullet.kill();
		}

		//jerry touches blob: reset level
		if (FlxCollision.pixelPerfectCheck(_jerry.flxsprite, _player.flxsprite)){
			FlxG.switchState(new PlayState());
		}

		//update
		_player.movement();
		_jerry.movement();
		super.update(elapsed);
		FlxG.collide(_player.flxsprite, _mWalls);
		FlxG.collide(_player.flxsprite, doors_group);
		for(_switch in switches_group.members){
			if (FlxG.pixelPerfectOverlap(_player.flxsprite, _switch))
			{
				_switch.action();
			}
			else{
				_switch.unaction();
			}
		}
		//trace(FlxG.overlap(_player.flxsprite, switches_group, triggerSwitch) + ", hitbox offset: " + _player.flxsprite.offset);
	}
}