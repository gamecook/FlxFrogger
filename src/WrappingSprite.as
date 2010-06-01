package
{
    import org.flixel.FlxG;
    import org.flixel.FlxSprite;

    public class WrappingSprite extends FlxSprite
    {

        protected var leftBounds:int;
        protected var rightBounds:int;
        private var state:PlayState;

        public var speed:int;

        public function WrappingSprite(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null, dir:uint = RIGHT, speed:int = 1)
        {
            super(X, Y, SimpleGraphic);
            this.leftBounds = 0;
            this.rightBounds = FlxG.width;
            
            this.speed = speed;

            facing = dir;

            state = FlxG.state as PlayState;
        }

        override public function update():void
        {

            if (state.gameState == PlayState.COLLISION_STATE)
            {
                return;
            }

            //Update the elevator's motion
            super.update();

            if (facing == LEFT)
            {
                x -= speed;
            } else if (facing == RIGHT)
            {
                x += speed;
            }

            //Turn around if necessary
            if (x > (rightBounds))
            {

                if (facing == RIGHT)
                {
                    x = leftBounds - frameWidth;
                }

            }
            else if (x < (leftBounds - frameWidth))
            {

                {
                    x = rightBounds + frameWidth;
                }
            }


        }
    }
}