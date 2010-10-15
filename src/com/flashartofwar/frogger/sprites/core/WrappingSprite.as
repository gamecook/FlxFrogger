/*
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package
com.flashartofwar.frogger.sprites.core
{
    import com.flashartofwar.frogger.enum.GameStates;
    import com.flashartofwar.frogger.states.PlayState;

    import org.flixel.FlxG;
    import org.flixel.FlxSprite;

    public class WrappingSprite extends FlxSprite
    {

        protected var leftBounds:int;
        protected var rightBounds:int;
        protected var state:PlayState;

        public var speed:int;

        /**
         * This is a base class for any sprite that needs to wrap arround the screen when it goes out of
         * bounds. This kind of sprite watches for when it is off screen the resets it's X position to
         * the opposite site based on it's direction.
         *
         * @param X start X
         * @param Y start Y
         * @param SimpleGraphic Use for sprites with no animations
         * @param dir Direction, supports Right (1) and Left (0)
         * @param speed how many pixel sprite will move each update.
         */
        public function WrappingSprite(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null, dir:uint = RIGHT, speed:int = 1)
        {
            super(X, Y, SimpleGraphic);
            this.leftBounds = 0;
            this.rightBounds = FlxG.width;

            this.speed = speed;

            facing = dir;

            state = FlxG.state as PlayState;
        }

        /**
         * This update methods analyzes the direction and x position of the instance to see if it should
         * be repositioned to the opposite side of the screen. If instance is facing right, it will restart
         * on the left of the screen. The opposite will happen for anything facing left.
         */
        override public function update():void
        {

            // Make sure the game state is Playing. If not exit out of update since we should be paused.
            if (state.gameState != GameStates.PLAYING)
            {
                return;
            } else
            {
                // Add speed to instance's x based on direction
                x += (facing == LEFT) ? -speed : speed;

                // Check to see if instance is out of bounds. If so, put it on the opposite side of the screen
                if (x > (rightBounds))
                {

                    if (facing == RIGHT)
                    {
                        x = leftBounds - frameWidth;
                    }

                } else if (x < (leftBounds - frameWidth))
                {

                    {
                        x = rightBounds + frameWidth;
                    }
                }

            }

            // Call update
            super.update();
        }
    }
}