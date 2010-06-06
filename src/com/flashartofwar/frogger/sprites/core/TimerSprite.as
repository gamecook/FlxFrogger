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

        /**
         * The TimerSprite allows you to change states from active to inactive based on an internal timer.
         * This is useful for sprites that need to hide/show themselves at certain intervals. If you want
         * to disable the internal timer, simply pass in -1 for the start time.
         *
         * @param x start x
         * @param y start y
         * @param SimpleGraphic used for sprites that don't need to show an animation
         * @param delay this represents the delay between switching states
         * @param startTime this is the time in which the timer starts. Use -1 to disable.
         * @param dir This represents the direction the sprite will be facing
         * @param speed This is the speed in pixels the sprite will move on update
         */
        public function TimerSprite(x:Number, y:Number, SimpleGraphic:Class = null, delay:int = DEFAULT_TIME, startTime:int = DEFAULT_TIME, dir:uint = RIGHT, speed:int = 1)
        {

            super(x, y, SimpleGraphic, dir, speed);

            this.hideTimer = delay;
            timer = startTime;
        }

        /**
         * This updates the internal timer and triggers toggle when equal to 0
         */
        override public function update():void
        {

            if (state.gameState == GameStates.PLAYING)
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

        /**
         * Getter returns if the instance is active or not.
         *
         * @return a boolean, true is active and false is inactive
         */
        public function get isActive():Boolean
        {
            return _active;
        }

        /**
         * This is a simple toggle between active and deactivated states.
         */
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

        /**
         *  Toggles the _activate variable signaling that it is no longer active.
         */
        protected function onDeactivate():void
        {
            _active = false;
        }

        /**
         * Toggles the _activate variable signaling that it is now active.
         */
        protected function onActivate():void
        {
            _active = true;
        }
    }
}