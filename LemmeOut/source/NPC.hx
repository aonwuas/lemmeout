package;

import flixel.FlxObject;
import haxe.Timer;
import flixel.tile.FlxTilemap;
import flixel.FlxG;
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
	var _justX:Bool = false;
	var _justY:Bool = false;

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
	
	function possessed(){
		//shortcut variables
		var _up:Bool = false;
        var _down:Bool = false;
        var _left:Bool = false;
        var _right:Bool = false;
        _up = FlxG.keys.anyPressed([UP, W]);
        _down = FlxG.keys.anyPressed([DOWN, S]);
        _left = FlxG.keys.anyPressed([LEFT, A]);
        _right = FlxG.keys.anyPressed([RIGHT, D]);

		//movement logic
			if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W || FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.S) {
				_justY = true;
				_justX = false;
			}
			if (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.D || FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A) {
				_justY = false;
				_justX = true;
			}
			if (_up || _down || _left || _right){

				var x:Int = 0;
				var y:Int = 0;

				//determine direction
				if (_up) {y++;}
				if (_down) {y--;}
				if (_right) {x++;}
				if (_left) {x--;}
				//determine priority
				if (x != 0 && y != 0){
					if (_justY) { x = 0; }
					if (_justX) { y = 0; }
				}
				//move
				if (y == 1) { move(FlxObject.UP); }
				if (y == -1) { move(FlxObject.DOWN); }
				if (x == 1) { move(FlxObject.RIGHT); }
				if (x == -1) { move(FlxObject.LEFT); }
			}

			if (FlxG.keys.justPressed.SPACE) { m_state = default_behavior;} //lose control
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
		move(direction);
		
	}
	/*function possessed(blobby:Player){
		
	}*/
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