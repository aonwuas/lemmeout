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
import Character.MoveState;

class PlayState extends FlxState
{
	
	var _player:Player;
	var _jerry:JanitorJerry;
	public var _bullet:FlxSprite;
	public var _taser:FlxSprite;
	public var walls:FlxObject;
	public var exit:FlxSprite;
	public var _mWalls:FlxTilemap;
	public var doors_group:FlxTypedGroup<Door>;
	public var switches_group:FlxTypedGroup<Switch>;
	public var _map:TiledMap;
	public var characters:Array<Character>;
	public var NPCS:Array<NPC>;

	public var times_run:Int = 0;

	override public function create():Void
	{
		trace("Times create has been run: " + (times_run += 1));
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
		characters = new Array<Character>();
		NPCS = new Array<NPC>();

		var tmp_map:TiledObjectLayer = cast _map.getLayer("obstacles");
		//trace("Number of objects: " + tmp_map.objects.length);
		placeObjects(tmp_map.objects, _mWalls);
		setSwitches();

		//setup bullet
		_bullet = new FlxSprite(0,0);
		_bullet.loadGraphic("assets/images/GD1_mindblip.png",false,16,16);

		//setup taser
		_taser = new FlxSprite(0,0);
		_taser.loadGraphic("assets/images/GD1_taser.png",false,16,16);
	}

	//function to place all interactable objects in the level
	public function placeObjects(objects:Array<TiledObject>, mWalls:FlxTilemap):Void
	{
		var count:Int = 0;
		for(object in objects)
		{
			//trace("Count: " + (count += 1));
			var type:String = object.type;
			var data:Xml = object.xmlData.x;

			var x:Float = Std.parseFloat(data.get("x"));
			var y:Float = Std.parseFloat(data.get("y"));
			switch(type)
			{
				case "BasicDoor":
					var name:String = object.name;
					doors_group.add(new BasicDoor(name, x, y));
					//trace("Added Door at position (" + x + ", " + y +")");
				case "BasicSwitch":
					var subject_name:String = object.properties.get("Subject");
					var _switch:Switch = new BasicSwitch(subject_name, x, y);
					switches_group.add(_switch);
					//trace("Added Switch at position (" + x + ", " + y +")");
				case "Spawn":
					var character:String = object.properties.get("Character");
					//trace("Added Character at position (" + x + ", " + y +")");
					spawnCharacter(character, x, y, mWalls);
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

	public function spawnCharacter(character:String, x:Float, y:Float, mWalls:FlxTilemap)
	{
		switch(character)
		{
			case "Bobby":
				_player = new Player(mWalls, x, y);
				Character.addToPlayState(this, _player);
				characters.push(_player);
				FlxG.camera.follow(_player.flxsprite, TOPDOWN, 1);
				_player.flxsprite.setGraphicSize(24,24);
				_player.flxsprite.updateHitbox();
				_player.flxsprite.width = 20.0;
				_player.flxsprite.height = 20.0;
				_player.flxsprite.offset.set(4,8);
				//trace("Added Bobby at position (" + x + ", " + y +")");
			case "Jerry":
				_jerry = new JanitorJerry(mWalls, x, y);
				Character.addToPlayState(this, _jerry);
				characters.push(_jerry);
				NPCS.push(_jerry);
				_jerry.flxsprite.setGraphicSize(24,24);
				_jerry.flxsprite.updateHitbox();
				_jerry.flxsprite.width = 20.0;
				_jerry.flxsprite.height = 20.0;
				_jerry.flxsprite.offset.set(4,8);
				//trace("Added Jerry at position (" + x + ", " + y +")");
		}
	}

	override public function update(elapsed:Float):Void
	{
		//testing purposes: END GAME
		if (_player.end_game){ FlxG.switchState(new EndState()); }

		//shoot bullet
		if (_player.controlled && FlxG.keys.justPressed.E){ add(_bullet); }
		
		for(_npc in NPCS)
		{
			if (FlxCollision.pixelPerfectCheck(_npc.flxsprite, _bullet))
				{ //bullet hits jerry
					_player.controlled = false;
					_npc.getPossessed();
					_bullet.reset(0, 0);
					_bullet.kill();
				}
		}


		//shoot taser
		if (_jerry.m_state == MoveState.POSSESSED && FlxG.keys.justPressed.E) {add(_taser); }
		if (FlxG.collide(_taser, _mWalls) || FlxG.collide(_taser, doors_group)){ //taser collision
			_taser.reset(0, 0);
			_taser.kill();
		}

		//jerry or taser touches blob: reset level
		if (FlxCollision.pixelPerfectCheck(_jerry.flxsprite, _player.flxsprite) || FlxCollision.pixelPerfectCheck(_player.flxsprite, _taser)){
			FlxG.switchState(new PlayState());
		}
		
		//update
		for(_char in characters) _char.movement();
		super.update(elapsed);
		FlxG.collide(_player.flxsprite, _mWalls);
		FlxG.collide(_player.flxsprite, doors_group);
		for(_char in characters){
			for(_switch in switches_group.members){
				if (FlxG.pixelPerfectOverlap(_char.flxsprite, _switch))
				{
					_switch.action();
				}
				else{
					_switch.unaction();
				}
			}
		}
	}
}