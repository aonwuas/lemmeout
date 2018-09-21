package;

import flixel.FlxObject;
import haxe.Timer;
import flixel.tile.FlxTilemap;
import Character.AnimationState;
import Character.MoveState;
import flixel.FlxG;
import flixel.FlxSprite;
/**
 * ...
 * @author Anthony Ben Jerry Rachel Steven
 */
class NPC extends Character
{

	var a_state:AnimationState;
	public var m_state:MoveState;
	var direction:Int;
	var delay:Float = 2	;
	var last_timestamp:Float = 0;
	var player:Player = null;
	var default_behavior:MoveState;
	var _justX:Bool = false;
	var _justY:Bool = false;
	var name:String;
		
	public function new(colliders:FlxTilemap, ?x:Float=0, ?y:Float=0, ?start_behavior:MoveState = MoveState.PATROL) 
	{
		super(colliders, x, y);
		default_behavior = start_behavior;
		m_state = MoveState.PATROL;
		direction = FlxObject.DOWN;
		
	}
	
	override public function movement(){
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
		switch(direction){
			case FlxObject.UP:
				flxsprite.animation.play(AnimationState.P_BACK);
			case FlxObject.DOWN:
				flxsprite.animation.play(AnimationState.P_FRONT);
			case FlxObject.LEFT, FlxObject.RIGHT:
				flxsprite.animation.play(AnimationState.P_SIDE);
		}
		
	}
	
	
	function possessed(){

		//shoot taser
		if (FlxG.keys.justPressed.E)
		{	
			//make new taser
			var playState:PlayState = cast FlxG.state;
			var taser:FlxSprite = playState._taser;
			taser.reset(flxsprite.x + flxsprite.width/2 - taser.width/2, flxsprite.y + flxsprite.height/2 - taser.height/2);

			//determine velocity and rotation of taser
			switch (flxsprite.facing){
				case FlxObject.UP:
					taser.angle = 0;
					taser.velocity.y = -400;
				case FlxObject.DOWN:
					taser.angle = 180;
					taser.velocity.y = 400;
				case FlxObject.RIGHT:
					taser.angle = 90;
					taser.velocity.x = 400;
				case FlxObject.LEFT:
					taser.angle = 270;
					taser.velocity.x = -400;
			}
		}

		//shortcut variables
		var _up:Bool = false;
        var _down:Bool = false;
        var _left:Bool = false;
        var _right:Bool = false;
        _up = FlxG.keys.anyPressed([UP, W]);
        _down = FlxG.keys.anyPressed([DOWN, S]);
        _left = FlxG.keys.anyPressed([LEFT, A]);
        _right = FlxG.keys.anyPressed([RIGHT, D]);
		FlxG.collide(flxsprite, walls);
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
				if (y == 1) { move(FlxObject.UP, m_state); }
				if (y == -1) { move(FlxObject.DOWN, m_state); }
				if (x == 1) { move(FlxObject.RIGHT, m_state); }
				if (x == -1) { move(FlxObject.LEFT, m_state); }
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
}



