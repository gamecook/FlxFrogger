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

            if (state.gameState != GameStates.PLAYING_STATE)
            {
                return;
            }
            else
            {

                if (facing == LEFT)
                {
                    x -= speed;
                } else if (facing == RIGHT)
                {
                    x += speed;
                }

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

            super.update();
        }
    }
}