package;

import flixel.FlxObject;
/**
 * ...
 * @author Anthony Ben Jerry Rachel Steven
 */
class NPC extends Character
{

	var a_state:AnimationState;
	var m_state:MoveState;
	var direction:Int;
	public function new(?x:Float=0, ?y:Float=0) 
	{
		super(x,y);
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
				chase;
		}
	}
	
	
	function chase(target:Character){
		
		
	}
	
	function look(){
		
		
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