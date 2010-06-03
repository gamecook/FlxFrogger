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
{
    import org.flixel.FlxG;

    public class Bonus extends TimerSprite
    {

        public static const SPRITE_WIDTH:uint = 40;
        public static const SPRITE_HEIGHT:uint = 40;
        public static const BONUS:uint = 0;
        public static const NO_BONUS:uint = 1;
        public static const SUCCESS:uint = 2;
        public static const EMPTY:uint = 3;


        [Embed(source="../build/assets/bonus_sprites.png")]
        private var SpriteImage:Class;

        public var mode:uint;
        public var odds:uint;

        public function Bonus(x:int, y:int, hideTimer:int = TimerSprite.DEFAULT_TIME, startTime:int = TimerSprite.DEFAULT_TIME, odds:uint = 10)
        {
            super(x, y, null, hideTimer, startTime, 0, 0);

            this.odds = odds;

            loadGraphic(SpriteImage, false, false, SPRITE_WIDTH, SPRITE_HEIGHT);
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

        private function showEmpty():void
        {
            play("empty");
        }

        private function showNoBonus():void
        {
            play("noBonus");
        }

        private function showBonus():void
        {
            play("bonus");
        }

        public function success():void
        {

            play("success");
            FlxG.score += ScoreValues.REACH_HOME;
            hideTimer = timer = -1;
        }

        protected function setMode(mode:uint, animationSet:String):void
        {
            this.mode = mode;
            play(animationSet);
        }

    }
}