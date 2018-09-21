package;

import Character.MoveState;

/**
 * ...
 * @author Anthony Ben Jerry Rachel Steven
 */
class ScienceSteve extends NPC
{

	public function new(walls:FlxTileMap, ?x:Float = 0; ?y:Float = 0, start_behavior:MoveState, player:Player) 
	{
		super(walls, x, y, default, player);
	}
	
}