 package;

 import flixel.system.FlxAssets.FlxGraphicAsset;
 import flixel.FlxG;
 import flixel.input.keyboard.FlxKey;
 import flixel.FlxObject;
 import flixel.FlxSprite;

 class Player extends Character
 {
	//initial variables
    public var spd:Float = 200;
	public var controlled:Bool = true;
	private var player_graphic:String = "assets/images/GD1_blobMasterSheet.png";
    private var player_width:Int = 32;
	private var player_height:Int = 32;

	//for movement logic
	var _justX:Bool = false;
	var _justY:Bool = false;
    
	//constructor
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super();
		setFlxSprite(player_graphic, true, player_width, player_height);
		setSpeed(spd);
    }
	
	//turn image into FlxSprite
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
		flxsprite.facing = FlxObject.DOWN;
	}

	//movement logic
    public function movement():Void
    {
		//shortcut variables
		var _up:Bool = false;
        var _down:Bool = false;
        var _left:Bool = false;
        var _right:Bool = false;
        _up = FlxG.keys.anyPressed([UP, W]);
        _down = FlxG.keys.anyPressed([DOWN, S]);
        _left = FlxG.keys.anyPressed([LEFT, A]);
        _right = FlxG.keys.anyPressed([RIGHT, D]);

		//shoot beam
		if (controlled && FlxG.keys.justPressed.R)
		{	
			//make new bullet
			var playState:PlayState = cast FlxG.state;
			var bullet:FlxSprite = playState.playerBullets.recycle();
			bullet.reset(flxsprite.x + flxsprite.width/2 - bullet.width/2, flxsprite.y + flxsprite.height/2 - bullet.height/2);

			//determine velocity and rotation of bullet
			switch (flxsprite.facing){
				case FlxObject.UP:
					bullet.angle = 0;
					bullet.velocity.y = -400;
				case FlxObject.DOWN:
					bullet.angle = 180;
					bullet.velocity.y = 400;
				case FlxObject.RIGHT:
					bullet.angle = 90;
					bullet.velocity.x = 400;
				case FlxObject.LEFT:
					bullet.angle = 270;
					bullet.velocity.x = -400;
			}
		}

		//controlling player
		if (controlled)
		{
			//turn green when space pressed
			switch (flxsprite.facing){
				case FlxObject.UP:
                    playAnim("back");
                case FlxObject.DOWN:
                    playAnim("front");
                case FlxObject.LEFT, FlxObject.RIGHT:
                    playAnim("side");
            }

			//lose control
			if (FlxG.keys.justPressed.E) {controlled = false;}

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
		}
		else //not controlling player
		{
            if (FlxG.keys.justPressed.SPACE) {controlled = true;} //regain control

			//not controlled animation
            switch (flxsprite.facing){
				case FlxObject.UP:
                    playAnim("back_grey");
                case FlxObject.DOWN:
                    playAnim("front_grey");
                case FlxObject.LEFT, FlxObject.RIGHT:
                	playAnim("side_grey");
            }
		}
    }
 }