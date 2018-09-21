package;

import flixel.tile.FlxBaseTilemap;
import flixel.FlxObject;
import flixel.math.FlxVector;
import haxe.Timer;
import flixel.tile.FlxTilemap;
import Character.AnimationState;
import Character.MoveState;
import flixel.FlxG;
import flixel.util.FlxPath;
import flixel.math.FlxPoint;
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
	var player:Player;
	var default_behavior:MoveState;
	var _justX:Bool = false;
	var _justY:Bool = false;
	var sees_player:Bool = false;
	var last_seen:FlxPoint = null;
	var start_pos:FlxPoint;
	var relative:FlxVector;
	var is_chasing:Bool = false;
	var is_returning:Bool = false;
	var start_direction:Int;
		
	public function new(colliders:FlxTilemap, ?x:Float=0, ?y:Float=0, ?start_behavior:MoveState = MoveState.PATROL, ?target:Player=null) 
	{
		super(colliders, x, y);
		default_behavior = start_behavior;
		m_state = MoveState.PATROL;
		direction = FlxObject.DOWN;
		start_direction = direction;
		player = target;
		flxsprite.path = new FlxPath();
		start_pos = flxsprite.getMidpoint().add(16, 16);
		trace(start_pos);
	}
	
	public function movement(){
		if (los() && m_state != MoveState.POSSESSED){
			m_state = MoveState.CHASE;
		}
		switch(m_state){
			case MoveState.PATROL:
				patrol();
			case MoveState.HUNT:
				hunt();
			case MoveState.LOOK:
				look();
			case MoveState.CHASE:
				chase();
			case MoveState.POSSESSED:
				possessed();
		}
	}
	
	
	function chase(){
		if (los()){//can see target
			var points:Array<FlxPoint> = walls.findPath(flxsprite.getMidpoint(), player.flxsprite.getMidpoint(), true, false, FlxTilemapDiagonalPolicy.NONE);
			flxsprite.path.start(points, 200, FlxPath.FORWARD);
			is_chasing = true;
			is_returning = false;
		}
		else{ //cannot see target
			if (is_returning){//and I'm returning to start
				if (flxsprite.path.finished){//finished returning to start, switch states
					trace("return to start finished, I'm at " + flxsprite.getMidpoint());
					direction = start_direction;
					is_returning = false;
					is_chasing = false;
					m_state = default_behavior;
					FlxG.collide(flxsprite, walls);
					trace("Behavior is now " + m_state);
				}
			}
			if (flxsprite.path.finished && !is_returning && is_chasing){//and finished not yet returning and still chasing
				var points:Array<FlxPoint> = walls.findPath(flxsprite.getMidpoint(), start_pos, true, false, FlxTilemapDiagonalPolicy.NONE);
				flxsprite.path.start(points, 200, FlxPath.FORWARD);
				is_returning = true;
				is_chasing = false;
				trace("Nothing here, returning to " + start_pos);
			}
		}
		
	}
	
	function los():Bool{
		return walls.ray(flxsprite.getMidpoint(), player.flxsprite.getMidpoint());
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

			if (FlxG.keys.justPressed.SPACE) {
				var points:Array<FlxPoint> = walls.findPath(flxsprite.getMidpoint(), start_pos, true, false, FlxTilemapDiagonalPolicy.NONE);
				flxsprite.path.start(points, 200, FlxPath.FORWARD);
				is_returning = true;
				is_chasing = false;
				m_state = default_behavior;} //lose control
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



