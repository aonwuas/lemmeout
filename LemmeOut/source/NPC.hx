package;

import flixel.FlxObject;
import haxe.Timer;
/**
 * ...
 * @author Anthony Ben Jerry Rachel Steven
 */
class NPC extends Character
{

	var a_state:AnimationState;
	var m_state:MoveState;
	var direction:Int;
	var delay:Float = 2	;
	var last_timestamp:Float = 0;
	public function new(?x:Float=0, ?y:Float=0) 
	{
		super(x,y);
		m_state = MoveState.LOOK;
		direction = FlxObject.DOWN;
		
	}
	
	public function movement(){
		switch(m_state){
			case MoveState.PATROL:
				patrol();
			case MoveState.HUNT:
				hunt();
			case MoveState.LOOK:
				look();
			case MoveState.CHASE:
				chase;
		}
	}
	
	
	function chase(target:Character){
		
	}
	
	function look(){
		if (Timer.stamp() >= last_timestamp + delay){
			move(direction);
			switch(direction){
				case FlxObject.UP:
					direction = FlxObject.LEFT;
				case FlxObject.DOWN:
					direction = FlxObject.RIGHT;
				case FlxObject.LEFT:
					direction = FlxObject.UP;
				case FlxObject.RIGHT:
					direction = FlxObject.DOWN;
			/*	case FlxObject.LEFT:
						flxsprite.facing = FlxObject.UP;
						flxsprite.animation.play("back");
						direction = FlxObject.UP;
				case FlxObject.RIGHT:
						flxsprite.facing = FlxObject.DOWN;
						flxsprite.animation.play("front");
						direction = FlxObject.DOWN;
				case FlxObject.UP:
						flxsprite.facing = FlxObject.RIGHT;
						flxsprite.animation.play("side");
						direction = FlxObject.RIGHT;
						flxsprite.setFacingFlip(flxsprite.facing, true, false);
				case FlxObject.DOWN:
						flxsprite.facing = FlxObject.LEFT;
						flxsprite.animation.play("side");
						direction = FlxObject.LEFT;
						flxsprite.setFacingFlip(flxsprite.facing, false, false);*/
			}
			last_timestamp = Timer.stamp();
			trace(last_timestamp);
		}
		
	}
	
	function hunt(){
		
	}
	
	function patrol(){
		move(direction);
		
	}
	/*function possessed(blobby:Player){
		
	}*/
}

@:enum
abstract MoveState(Int)	{
	//var POSSESSED = -1;
	var LOOK      =  0;
	var PATROL       =  1;
	var HUNT  =  2;
	var CHASE = 3;
}

@:enum
abstract AnimationState(String)	{
	var FRONT = "front";
	var BACK = "back";
	var SIDE = "side";
	var P_FRONT = "possessed_front";
	var P_BACK = "possessed_back";
	var P_SIDE = "possessed_side";
	var STUNNED = "stunned";
	var FIRING = "firing";
}