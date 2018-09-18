package;

/**
 * ...
 * @author Anthony Ben Jerry Rachel Steven
 */
class NPC extends Character
{

	var a_state:AnimationState;
	var p_state:MoveState;
	public function new() 
	{
		super();
		
	}
	
	public function movement(){
		
		
	}
	
	public 
	
	class Behavior{
		//PATROL, LOOK, HUNT, CHASE, POSSESSED
		//PATROL follow set path repeatedly
		//LOOK stand in place and scan left to right
		//HUNT walk around trying to find blobby
		//CHASE blobby found, follow it while running
		//POSSESSED controlled by blobby
		
		function Chase(var target:Character){
			
			
		}
		
		function Look(){
			
			
		}
		
		var Hunt(){
			
		}
		
		var Patrol(){
			
		}
		function Possessed(var blobby:Player){
			
		}
	}
	
}

@:enum
abstract MoveState(Int)	{
	var POSSESSED = -1;
	var LOOK      =  0;
	var PATROL       =  1;
	var HUNT  =  2;
	var chase = 3;
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