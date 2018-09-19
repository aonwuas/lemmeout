package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.FlxG;
//import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Anthony Ben Jerry Rachel Steven
 */

 
class Character{

	public var flxsprite:FlxSprite;
	public var speed:Float;// = 200;
	private var walls:FlxTilemap;
	
	
	
	public static function addToPlayState(state:FlxState, char:Character){
		state.add(char.flxsprite);
	}
	public function new(colliders:FlxTilemap, ?x:Float=0, ?y:Float=0) {
		//Create Character's empty FlxSprite object
		flxsprite = new FlxSprite(x, y);
		walls = colliders;
		FlxG.collide(flxsprite, walls);
	}
	//After creating a new Character object, call setFlxSprite to set image information
	public function setFlxSprite(image_string:String, is_animated:Bool = false, width:Int, height:Int):Void {
		flxsprite.loadGraphic(image_string, is_animated, width, height);
		flxsprite.drag.x = flxsprite.drag.y = 1600;
	}
	public function setSpeed(spd:Float){
		speed = spd;
	}
	public function screenCenter():Void{
		flxsprite.screenCenter();
	}
	
	public function addAnim(name:String, frames:Array<Int>, fps:Int, looped:Bool = false):Void{
		flxsprite.animation.add(name, frames, fps, looped);
	}
	
	public function playAnim(name:String):Void{
		flxsprite.animation.play(name);
	}
	
	public function warp(x:Float, y:Float){
		flxsprite.x = x;
		flxsprite.y = y;
	}
	
	public function move(direction:Int){
		FlxG.collide(flxsprite, walls);
		switch(direction){
			case FlxObject.UP:
					flxsprite.facing = FlxObject.UP;
					flxsprite.animation.play("back");
					flxsprite.velocity.set(0, -speed);
			case FlxObject.DOWN:
					flxsprite.facing = FlxObject.DOWN;
					flxsprite.animation.play("front");
					flxsprite.velocity.set(0, speed);
			case FlxObject.RIGHT:
					flxsprite.facing = FlxObject.RIGHT;
					flxsprite.animation.play("side");
					flxsprite.setFacingFlip(flxsprite.facing, true, false);
					flxsprite.velocity.set(speed, 0);
			case FlxObject.LEFT:
					flxsprite.facing = FlxObject.LEFT;
					flxsprite.animation.play("side");
					flxsprite.setFacingFlip(flxsprite.facing, false, false);
					flxsprite.velocity.set(-speed, 0);
		}
	}
	
	public function turn(direction:Int){
		switch(direction){
			case FlxObject.UP:
					flxsprite.facing = FlxObject.UP;
					flxsprite.animation.play("back");
			case FlxObject.DOWN:
					flxsprite.facing = FlxObject.DOWN;
					flxsprite.animation.play("front");
			case FlxObject.RIGHT:
					flxsprite.facing = FlxObject.RIGHT;
					flxsprite.animation.play("side");
					flxsprite.setFacingFlip(flxsprite.facing, true, false);
			case FlxObject.LEFT:
					flxsprite.facing = FlxObject.LEFT;
					flxsprite.animation.play("side");
					flxsprite.setFacingFlip(flxsprite.facing, false, false);
		}
	}
}