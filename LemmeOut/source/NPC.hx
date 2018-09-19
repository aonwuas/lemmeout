package;

import flixel.FlxObject;
import haxe.Timer;
import flixel.tile.FlxTilemap;
import Character.AnimationState;
import Character.MoveState;
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
	var player:Player = null;
	var default_behavior:MoveState;
	public function new(colliders:FlxTilemap, ?x:Float=0, ?y:Float=0, ?start_behavior:MoveState = MoveState.PATROL) 
	{
		super(colliders, x, y);
		default_behavior = start_behavior;
		m_state = MoveState.PATROL;
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
				chase(player);
			case MoveState.POSSESSED:
				possessed();
		}
	}
	
	
	function chase(target:Character){
		if (player == null){
			m_state = default_behavior;
		}
		else{
			
		}
	}
	
	public function getPossessed(){
		m_state = MoveState.POSSESSED;
		
	}
	
	public function release(){
		m_state = default_behavior;
		
	}
	
	function possessed(){
		
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
						flxsprite.animat qion.play("side");
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
		if (move(direction)){
			switch(direction){
				case FlxObject.UP:
					direction = FlxObject.DOWN;
				case FlxObject.DOWN:
					direction = FlxObject.UP;
				case FlxObject.LEFT:
					direction = FlxObject.RIGHT;
				case FlxObject.RIGHT:
					direction = FlxObject.LEFT;
			}
		}
		
	}
	/*function possessed(blobby:Player){
		
	}*/
}



