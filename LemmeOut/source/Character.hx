package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.FlxG;
import flixel.util.FlxPath;
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
	
	public function pathingAnims(){
		if (flxsprite.path != null && flxsprite.path.active){
			var relative:FlxPoint = new FlxPoint(0,0);
			flxsprite.path.nodes[flxsprite.path.nodeIndex].copyTo(relative);
			relative.subtractPoint(flxsprite.getPosition());
			if (Math.abs(relative.x) > Math.abs(relative.y)){//move horizontal
				if (relative.x > 0){
					flxsprite.facing = FlxObject.RIGHT;
					flxsprite.animation.play(AnimationState.SIDE);
					flxsprite.setFacingFlip(flxsprite.facing, true, false);
				}
				else if (relative.x < 0){
					flxsprite.facing = FlxObject.LEFT;
					flxsprite.animation.play(AnimationState.SIDE);
					flxsprite.setFacingFlip(flxsprite.facing, false, false);
				}
				
			}
			else{//move vertical
				if (relative.y > 0){
					flxsprite.facing = FlxObject.DOWN;
					flxsprite.animation.play(AnimationState.FRONT);
				}
				else if (relative.y < 0){
					flxsprite.facing = FlxObject.UP;
					flxsprite.animation.play(AnimationState.BACK);
				}
			}
		}
	}
	public function playAnim(name:String):Void{
		flxsprite.animation.play(name);
	}
	
	public function warp(x:Float, y:Float){
		flxsprite.x = x;
		flxsprite.y = y;
	}
	
	public function move(direction:Int, ?state:MoveState = null):Bool{
		switch(direction){
			case FlxObject.UP:
					flxsprite.facing = FlxObject.UP;
					if (state != MoveState.POSSESSED){
						flxsprite.animation.play(AnimationState.BACK);
					}
					else{
						flxsprite.animation.play(AnimationState.P_BACK);
					}
					flxsprite.velocity.set(0, -speed);
			case FlxObject.DOWN:
					flxsprite.facing = FlxObject.DOWN;
					if (state != MoveState.POSSESSED){
						flxsprite.animation.play(AnimationState.FRONT);
					}
					else{
						flxsprite.animation.play(AnimationState.P_FRONT);
					}
					flxsprite.velocity.set(0, speed);
			case FlxObject.RIGHT:
					flxsprite.facing = FlxObject.RIGHT;
					if (state != MoveState.POSSESSED){
						flxsprite.animation.play(AnimationState.SIDE);
					}
					else{
						flxsprite.animation.play(AnimationState.P_SIDE);
					}
					flxsprite.setFacingFlip(flxsprite.facing, true, false);
					flxsprite.velocity.set(speed, 0);
			case FlxObject.LEFT:
					flxsprite.facing = FlxObject.LEFT;
					if (state != MoveState.POSSESSED){
						flxsprite.animation.play(AnimationState.SIDE);
					}
					else{
						flxsprite.animation.play(AnimationState.P_SIDE);
					}
					flxsprite.setFacingFlip(flxsprite.facing, false, false);
					flxsprite.velocity.set(-speed, 0);
		}
		return FlxG.collide(flxsprite, walls);
	}
	
	public function movement():Void
	{
		//Blank function to be overriden in subclasses
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
	
	public function getName():String{
		return "null";
	}
}

@:enum
abstract MoveState(Int)	{
	var POSSESSED = -1;
	var LOOK      =  0;
	var PATROL       =  1;
	var HUNT  =  2;
	var CHASE = 3;
}

@:enum
abstract AnimationState(String)	to String{
	var FRONT = "front";
	var BACK = "back";
	var SIDE = "side";
	var P_FRONT = "possessed_front";
	var P_BACK = "possessed_back";
	var P_SIDE = "possessed_side";
	var STUNNED = "stunned";
	var FIRING = "firing";
}