 package;

 import flixel.system.FlxAssets.FlxGraphicAsset;
 import flixel.FlxG;
 import flixel.input.keyboard.FlxKey;
 import flixel.FlxObject;

 class Player2 extends Character
 {
    public var spd:Float = 200;
	public var controlled:Bool = true;
	private var player_graphic:String = "assets/images/GD1_blobMasterSheet.png";
    private var player_width:Int = 32;
	private var player_height:Int = 32;
    
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super();
		setFlxSprite(player_graphic, true, player_width, player_height);
		setSpeed(spd);
    }
	
	override public function setFlxSprite(image_string:String, is_animated:Bool = false, width:Int, height:Int):Void 
	{
		super.setFlxSprite(image_string, is_animated, width, height);
		addAnim("front", [0,0,1,1,0,0,1,1,0,2,1,3], 7, true);
		addAnim("back", [4,4,5,5], 7, true);
		addAnim("side", [6,6,7,7], 7, true);
		addAnim("front_grey", [8,8,9,9,8,8,9,9,8,10,9,11], 3, true);
		addAnim("back_grey", [12,12,13,13], 3, true);
		addAnim("side_grey", [14,14,15,15], 3, true);
		playAnim("front"); //starting animation
	}

     public function movement():Void
    {
		if (controlled)
		{
			switch (flxsprite.facing){ //turn green when space pressed
                case FlxObject.LEFT, FlxObject.RIGHT:
                    playAnim("side");
                case FlxObject.UP:
                    playAnim("back");
                case FlxObject.DOWN:
                    playAnim("front");
            }

			if (FlxG.keys.justPressed.E) {controlled = false;} //shoot beam

			if (FlxG.keys.anyPressed([UP, DOWN, LEFT, RIGHT, W, A, S, D])){
				var x:Float = 0, y:Float = 0;
				if (FlxG.keys.anyPressed([UP, W])){
					y = Math.max(y--, -1);
				}
				if (FlxG.keys.anyPressed([DOWN, S])){
					y = Math.min(y++, 1);
				}
				if (FlxG.keys.anyPressed([LEFT, A])){
					x = Math.max(x--, -1);
				}
				if (FlxG.keys.anyPressed([RIGHT, D])){
					x = Math.min(x++, 1);
				}
				trace("x: " + Std.string(x) + " y: " + Std.string(y));
				//Diagonal pressing
				if (x != 0 && y != 0){
					
				}
				
				switch(FlxG.keys.firstPressed()){
					case FlxKey.UP, FlxKey.W:
						move(FlxObject.UP);
					case FlxKey.DOWN, FlxKey.S:
						move(FlxObject.DOWN);
					case FlxKey.LEFT, FlxKey.A:
						move(FlxObject.LEFT);
					case FlxKey.RIGHT, FlxKey.D:
						move(FlxObject.RIGHT);
				}
			}
		}
		else
		{
            if (FlxG.keys.justPressed.SPACE) {controlled = true;} //control

            switch (flxsprite.facing){ //not controlled animation
                case FlxObject.LEFT, FlxObject.RIGHT:
                	playAnim("side_grey");
                case FlxObject.UP:
                    playAnim("back_grey");
                case FlxObject.DOWN:
                    playAnim("front_grey");
            }
		}
    }
 }