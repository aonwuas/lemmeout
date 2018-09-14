 package;

 import flixel.FlxSprite;
 import flixel.system.FlxAssets.FlxGraphicAsset;
 import flixel.FlxG;
 import flixel.math.FlxPoint;
 import flixel.FlxObject;

 class Player extends FlxSprite
 {
    public var speed:Float = 200;
    public var controlled:Bool = true; //hardcoded for testing
    
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        loadGraphic("assets/images/GD1_BlobSpriteSheetx100.png", true, 100, 100);
        animation.add("front", [0,0,1,1,0,2,1,3], 5, true);
        animation.add("back", [4,4,5,5], 5, true);
        animation.add("side", [6,6,7,7], 5, true);
        animation.play("front"); //starting position
        drag.x = drag.y = 1600;

        setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);
    }

      public function movement():Void
    {
        var _up:Bool = false;
        var _down:Bool = false;
        var _left:Bool = false;
        var _right:Bool = false;
        _up = FlxG.keys.anyPressed([UP, W]);
        _down = FlxG.keys.anyPressed([DOWN, S]);
        _left = FlxG.keys.anyPressed([LEFT, A]);
        _right = FlxG.keys.anyPressed([RIGHT, D]);

        if (controlled){ //controlled
            //if player press up+down or left+right, dont move
            if (_up && _down)
                _up = _down = false;
            if (_left && _right)
                _left = _right = false;
            
            if (_up || _down || _left || _right){
                
                //diagonal velocity
                var mA:Float = 0;
                if (_up)
                {
                    mA = -90;
                    if (_left)
                    {
                        mA -= 45;
                        facing = FlxObject.RIGHT; //reversed for backwards sprite
                    }
                    else if (_right)
                    {
                        mA += 45;
                        facing = FlxObject.LEFT; //reversed for backwards sprites
                    }
                    facing = FlxObject.UP;
                }
                else if (_down)
                {
                    mA = 90;
                    if (_left)
                    {
                        mA += 45;
                        facing = FlxObject.LEFT;
                    }
                    else if (_right)
                    {
                        mA -= 45;
                        facing = FlxObject.RIGHT;
                    }
                    facing = FlxObject.DOWN;
                }
                else if (_left)
                {
                    mA = 180;
                    facing = FlxObject.LEFT;
                }
                else if (_right)
                {
                    mA = 0;
                    facing = FlxObject.RIGHT;
                }
                
                velocity.set(speed, 0);
                velocity.rotate(FlxPoint.weak(0, 0), mA);

                //which animation to use
                if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
                {
                    switch (facing)
                    {
                        case FlxObject.LEFT, FlxObject.RIGHT:
                            animation.play("side");
                        case FlxObject.UP:
                            animation.play("back");
                        case FlxObject.DOWN:
                            animation.play("front");
                    }
                }
            }
            else{ //not controlled

                /*NPC/AI movement code or idle blobby*/

            }
        }
    }
 }