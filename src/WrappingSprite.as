package {
import org.flixel.FlxG;
import org.flixel.FlxSprite;

public class WrappingSprite extends FlxSprite {

    protected var leftBounds:int;
    protected var rightBounds:int;

    public function WrappingSprite(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null, dir:uint = RIGHT, velocity:int = 40) {
        super(X, Y, SimpleGraphic);
        this.leftBounds = 0;
        this.rightBounds = FlxG.width;
        this.velocity.x = dir ? velocity : -velocity;
        facing = dir;
    }

    override public function update():void {
        var state:PlayState = FlxG.state as PlayState;
        if (state.gameState == PlayState.COLLISION_STATE) {
            return;
        }


        //Update the elevator's motion
        super.update();

        //Turn around if necessary
        if (x > (rightBounds)) {

            if (facing == RIGHT) {
                x = leftBounds - frameWidth;
            }

        }
        else if (x < (leftBounds - frameWidth)) {

            {
                x = rightBounds + frameWidth;
            }
        }


    }
}
}