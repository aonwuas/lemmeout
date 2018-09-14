package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.animation.FlxAnimation;
import flixel.animation.FlxAnimationController;
//import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Anthony Ben Jerry Rachel Steven
 */

 
 
class Character {

	private var flxsprite:FlxSprite;
	//private var animations:Map<AState:FlxAnimation>;

	
	public function new() {
		//Create Character's empty FlxSprite object
		flxsprite = new FlxSprite(0, 0);
		//flxsprite.animation.p
	}	
	//After creating a new Character object, call setFlxSprite to set image information
	public function setFlxSprite(image_string:String, is_animated:Bool = false, width:Int, height:Int):Void {
		flxsprite.loadGraphic(image_string, is_animated, width, height);
		//TODO Add animations;
		//Set drag (stop moving after move key is released)
		flxsprite.drag.x = flxsprite.drag.y = 1600;
	}

	public function setAnim(name:String, frames:Array<Int>, fps:Int, looped:Bool = false):Void{
		flxsprite.animation.add(name, frames, fps, looped);
	}
	
	public function updateDirection(direction:Int):Void {
		if (direction == flxsprite.facing){
			//do nothing
		}
		else{
			flxsprite.facing = direction;
			//Update animation;
			
		}
		
	}
	
}