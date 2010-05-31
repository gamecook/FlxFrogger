package {
import flash.geom.Point;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

public class Frog extends FlxSprite {

    [Embed(source="data/frog_sprites.png")]
    private var SpriteImage:Class;
    private var startPosition:Point;
    private var moveX:int;
    private var maxMoveX:int;
    private var maxMoveY:int;
    private var targetX:Number;
    private var targetY:Number;
    private var animationFrames:int = 8;
    private var moveY:Number;

    public function Frog(X:Number, Y:Number) {
        super(X, Y);

        startPosition = new Point(X, Y);
        loadGraphic(SpriteImage, true, false, 40, 40);

        moveX = 5;
        moveY = 5;
        maxMoveX = moveX * animationFrames;
        maxMoveY = moveY * animationFrames;

        targetX = X;
        targetY = Y;
        width = 35;
        height = 35;

        addAnimation("idle" + UP, [0], 0, false);
        addAnimation("idle" + RIGHT, [2], 0, false);
        addAnimation("idle" + DOWN, [4], 0, false);
        addAnimation("idle" + LEFT, [6], 0, false);
        addAnimation("walk" + UP, [0,1], 10, true);
        addAnimation("walk" + RIGHT, [2,3], 10, true);
        addAnimation("walk" + DOWN, [4,5], 10, true);
        addAnimation("walk" + LEFT, [6,7], 10, true);
        addAnimation("die", [8, 9, 10, 11], 2, false);

        facing = FlxSprite.UP;

    }

    override public function update():void {
        var state:PlayState = FlxG.state as PlayState;

        if (state.gameState == PlayState.COLLISION_STATE) {
            if (frame == 11) {
                state.gameState = PlayState.DEATH_OVER;
            }
        }
        else {

            if (x == targetX && y == targetY) {
                play("idle" + facing);

                if (FlxG.keys.LEFT) {
                    targetX = x - maxMoveX;
                    facing = LEFT;
                } else if (FlxG.keys.RIGHT) {
                    targetX = x + maxMoveX;
                    facing = RIGHT;
                }
                else if (FlxG.keys.UP) {
                    targetY = y - maxMoveY;
                    facing = UP;
                }
                else if (FlxG.keys.DOWN) {
                    targetY = y + maxMoveY;
                    facing = DOWN;
                }
            }
            else {
                if (facing == LEFT) {
                    x -= moveX;
                } else if (facing == RIGHT) {
                    x += moveX;
                } else if (facing == UP) {
                    y -= moveY;
                } else if (facing == DOWN) {
                    y += moveY;
                }
                play("walk" + facing);
            }

        }

        //Default object physics update
        super.update();
    }

    public function death():void {
        acceleration.x = 0;
        acceleration.y = 0;

        play("die");
    }

    public function restart():void {
        x = startPosition.x;
        y = startPosition.y;
        targetX = startPosition.x;
        targetY = startPosition.y;
        facing = UP;
        play("idle" + facing);
    }
}
}