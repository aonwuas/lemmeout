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

class PlayState2 extends FlxState
{
	
	var _player:Player;
	var _jerry:JanitorJerry;
	var _steve:ScienceSteve;
	var _ben:BurlyBen;
	public var _bullet:FlxSprite;
	public var _taser:FlxSprite;
	public var walls:FlxObject;
	public var exit:FlxSprite;
	public var _mWalls:FlxTilemap;
	public var doors_group:FlxTypedGroup<Door>;
	public var switches_group:FlxTypedGroup<Switch>;
	public var box_group:FlxTypedGroup<Box>;
	public var _map:TiledMap;
	public var characters:Array<Character>;
	public var NPCS:Array<NPC>;

	public var times_run:Int = 0;

	override public function create():Void
	{
		trace("Times create has been run: " + (times_run += 1));
		FlxG.mouse.visible = false;
		_map = new TiledMap(AssetPaths.level2__tmx);
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
		box_group = new FlxTypedGroup<Box>();
		add(box_group);
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
					var _pressure:String = object.properties.get("Pressure");
					var _switch:Switch = new BasicSwitch(subject_name, x, y);
					if (_pressure == "true"){
						_switch.pressurize();
					}
					switches_group.add(_switch);
					//trace("Added Switch at position (" + x + ", " + y +")");
				case "Spawn":
					var character:String = object.properties.get("Character");
					//trace("Added Character at position (" + x + ", " + y +")");
					spawnCharacter(character, x, y, mWalls);
				case "Box":
					box_group.add(new Box(x, y));
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
			case "Steve":
				_steve = new ScienceSteve(mWalls, x, y);
				Character.addToPlayState(this, _steve);
				characters.push(_steve);
				NPCS.push(_steve);
				_steve.flxsprite.setGraphicSize(24,24);
				_steve.flxsprite.updateHitbox();
				_steve.flxsprite.width = 20.0;
				_steve.flxsprite.height = 20.0;
				_steve.flxsprite.offset.set(4,8);
				//trace("Added Steve at position (" + x + ", " + y +")");
			case "Ben":
				_ben = new BurlyBen(mWalls, x, y);
				Character.addToPlayState(this, _ben);
				characters.push(_ben);
				NPCS.push(_ben);
				_ben.flxsprite.setGraphicSize(24,24);
				_ben.flxsprite.updateHitbox();
				_ben.flxsprite.width = 20.0;
				_ben.flxsprite.height = 20.0;
				_ben.flxsprite.offset.set(4,8);
				//trace("Added Steve at position (" + x + ", " + y +")");
		}
	}

	override public function update(elapsed:Float):Void
	{
		//shoot bullet
		if (_player.controlled && FlxG.keys.justPressed.E){ add(_bullet); }
		FlxG.collide(_bullet, doors_group);
		FlxG.collide(_bullet, _mWalls);
		FlxG.collide(_bullet, box_group);
		
		for(_npc in NPCS)
		{
			if (FlxCollision.pixelPerfectCheck(_npc.flxsprite, _bullet))
				{ //bullet hits npc
					_player.controlled = false;
					_npc.getPossessed();
					_bullet.reset(0, 0);
					_bullet.kill();
				}
				FlxG.collide(_npc.flxsprite, doors_group);
				FlxG.collide(_npc.flxsprite, box_group);
				if (FlxCollision.pixelPerfectCheck(_npc.flxsprite, _player.flxsprite)){
					FlxG.switchState(new PlayState());
				}
			//shoot taser
			if (_npc.m_state == MoveState.POSSESSED && FlxG.keys.justPressed.E && _npc.getName() == "jerry") {add(_taser); }
			for (box in box_group){
				if (FlxG.collide(_npc.flxsprite, box) && _npc.getName() == "ben")
				{ //Ben moves box
					box.soften();
					trace("yeet");
				}
			}
		}


		if (FlxG.collide(_taser, _mWalls) || FlxG.collide(_taser, doors_group)){ //taser collision
			_taser.reset(0, 0);
			_taser.kill();
		}

		//jerry or taser touches blob: reset level
		if (FlxCollision.pixelPerfectCheck(_player.flxsprite, _taser)){
			FlxG.switchState(new PlayState());
		}
		
		//update
		for(_char in characters) _char.movement();
		super.update(elapsed);
		if (FlxG.collide(_bullet, _mWalls) || FlxG.collide(_bullet, doors_group) || FlxG.collide(_bullet, box_group)){ //taser collision
			_bullet.reset(0, 0);
			_bullet.kill();
		}
		FlxG.collide(_player.flxsprite, _mWalls);
		FlxG.collide(_player.flxsprite, doors_group);
		FlxG.collide(_player.flxsprite, box_group);
		FlxG.collide(box_group, _mWalls);
		FlxG.collide(box_group, doors_group);
		for (_char in characters){
			for (_box in box_group.members){
				if (FlxG.collide(_char.flxsprite, _box) && _char.getName() == "ben"){
					_box.soften();
				}
			}
		}
		for(_switch in switches_group.members){
			if ((FlxG.pixelPerfectOverlap(_taser, _switch)) && !_switch.getPressure())
			{
				_switch.action();
				continue;
			}
			for (_box in box_group.members){
				if ((FlxG.pixelPerfectOverlap(_box, _switch)) && _switch.getPressure()){
					_switch.action();
				}
			}
		}
	}
}