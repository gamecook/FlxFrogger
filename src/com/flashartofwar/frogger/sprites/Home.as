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
com.flashartofwar.frogger.sprites
{
    import com.flashartofwar.frogger.enum.ScoreValues;
    import com.flashartofwar.frogger.sprites.core.TimerSprite;

    import org.flixel.FlxG;

    public class Home extends TimerSprite
    {

        public static const SPRITE_WIDTH:int = 40;
        public static const SPRITE_HEIGHT:int = 40;
        public static const BONUS:int = 0;
        public static const NO_BONUS:int = 1;
        public static const SUCCESS:int = 2;
        public static const EMPTY:int = 3;
		public var mode:uint;
        public var odds:uint;

        /**
         * Home represents the sprite the player lands on to score points and help complete a level.
         * The home has 4 states Empty, Success, No Bonus, and Bonus
         *
         * @param x start X
         * @param y start Y
         * @param delay This represents the amount of time before toggling active/deactivate
         * @param startTime where the timer should start. Pass in -1 to disable the timer.
         * @param odds the randomness that one of the 3 states will be reached (empty, bonus, or no bonus)
         */
        public function Home(x:Number, y:Number, delay:int = TimerSprite.DEFAULT_TIME, startTime:int = TimerSprite.DEFAULT_TIME, odds:int = 10)
        {
            super(x, y, null, delay, startTime, 0, 0);

            this.odds = odds;

            loadGraphic(GameAssets.HomeSpriteImage, false, false, SPRITE_WIDTH, SPRITE_HEIGHT);
            addAnimation("empty", [EMPTY], 0, false);
            addAnimation("bonus", [BONUS], 0, false);
            addAnimation("noBonus", [NO_BONUS], 0, false);
            addAnimation("success", [SUCCESS], 0, false);

            play("empty");

        }

        override protected function onDeactivate():void
        {
            super.onDeactivate();
            showEmpty();
        }

        /**
         * On active draw a random number based on the odds and see what state should be shown.
         */
        override protected function onActivate():void
        {
            super.onActivate();

            var id:uint = Math.random() * odds;

            switch (id)
            {
                case(BONUS):
                    showBonus();
                    break;
                case(NO_BONUS):
                    showNoBonus();
                    break;
                default:
                    showEmpty();
                    break;
            }
        }

        /**
         * Shows empty state
         */
        private function showEmpty():void
        {
            play("empty");
        }

        /**
         * Shows no bonus state
         */
        private function showNoBonus():void
        {
            play("noBonus");
        }

        /**
         * Show bonus state
         */
        private function showBonus():void
        {
            play("bonus");
        }

        /**
         * Show success state
         */
        public function success():void
        {
            play("success");
            FlxG.score += ScoreValues.REACH_HOME;
            timer = -1;
        }

        /**
         * Reset the sprite to the empty state and restart the timer.
         */
        public function empty():void
        {
            setMode(EMPTY, "empty");
            timer = hideTimer;
        }

        /**
         * private method to set the state of the sprite.
         *
         * @param mode what mode should the sprite be in Empty, Bonus, No Bonus or Success
         * @param animationSet What animation set should it use to display the state
         */
        protected function setMode(mode:int, animationSet:String):void
        {
            //TODO This should be consolidated to use the same mode int
            this.mode = mode;
            play(animationSet);
        }

    }
}