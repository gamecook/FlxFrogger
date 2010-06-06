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

    import org.flixel.FlxG;

    public class TimerSprite extends WrappingSprite
    {

        public static const DEFAULT_TIME:int = 400;

        protected var timer:int;
        protected var hideTimer:int;
        protected var _active:Boolean = true;

        public function TimerSprite(x:Number, y:Number, SimpleGraphic:Class = null, hideTimer:int = DEFAULT_TIME, startTime:int = DEFAULT_TIME, dir:uint = RIGHT, speed:int = 1)
        {

            super(x, y, SimpleGraphic, dir, speed);

            this.hideTimer = hideTimer;
            timer = startTime;
        }

        override public function update():void
        {

            if (state.gameState == GameStates.PLAYING_STATE)
            {
                if (timer > 0)
                    timer -= FlxG.elapsed;

                if (timer == 0)
                {
                    toggle()
                }
            }

            super.update();

        }

        public function get isActive():Boolean
        {
            return _active;
        }

        protected function toggle():void
        {
            if (!isActive)
            {
                onActivate();
            }
            else
            {
                onDeactivate();
            }

            timer = hideTimer;
        }

        protected function onDeactivate():void
        {
            _active = false;
        }

        protected function onActivate():void
        {
            _active = true;
        }
    }
}