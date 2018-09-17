 package;

 import flixel.system.FlxAssets.FlxGraphicAsset;
 import flixel.FlxG;
 import flixel.input.keyboard.FlxKey;
 import flixel.FlxObject;

 class Player2 extends Character
 {
    public var spd:Float = 200;
	private var player_graphic:String = "assets/images/GD1_BlobSpriteSheetx100.png";
    private var player_width:Int = 100;
	private var player_height:Int = 100;
    
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super();
		setFlxSprite(player_graphic, true, player_width, player_height);
		setSpeed(spd);
    }
	
	override public function setFlxSprite(image_string:String, is_animated:Bool = false, width:Int, height:Int):Void 
	{
		super.setFlxSprite(image_string, is_animated, width, height);
		addAnim("front", [0, 0, 1, 1, 0, 2, 1, 3], 5, true);
		addAnim("back", [4,4,5,5], 5, true);
		addAnim("side", [6,6,7,7], 5, true);
		playAnim("front");
	}

     public function movement():Void
    {
        if (FlxG.keys.anyPressed([UP, DOWN, LEFT, RIGHT, W, A, S, D])){
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
 }