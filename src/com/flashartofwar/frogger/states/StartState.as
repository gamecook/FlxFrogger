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
com.flashartofwar.frogger.states
{
    import com.flashartofwar.frogger.sprites.GameAssets;
    import com.gamecook.scores.FScoreboard;

    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxText;

    public class StartState extends BaseState
    {
        private var scoreBoard:FScoreboard;

        /**
         * This is the first game state the player sees. Simply lets them click anywhere to start.
         */
        public function StartState()
        {
            super();
        }

        /**
         * Goes through and creates the graphics needed to display the start message
         */
        override public function create():void
        {
            super.create();

            var timer:Timer = new Timer(500, 1);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
            timer.start();

            var title:FlxSprite = new FlxSprite(0, 100, GameAssets.TitleSprite);
            title.x = (FlxG.width * .5) - (title.width * .5);
            add(title);

        }

        private function onTimerComplete(event:TimerEvent):void
        {
            event.target.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);

            stage.addEventListener(MouseEvent.CLICK, onClick);
            add(new FlxText(0, 200, FlxG.width, "START").setFormat(null, 18, 0xffffffff, "center"));

            var activateText:FlxText = add(new FlxText(0, 400, FlxG.width, "PRESS ENTER TO START").setFormat(null, 18, 0xd33bd1, "center")) as FlxText;
            CONFIG::mobile
            {
                activateText.text = "PRESS ANYWHERE TO START";
            }
        }

        /**
         * Handles when the user clicks and changes to the PlayState.
         * @param event MouseEvent
         */
        private function onClick(event:MouseEvent):void
        {

            FlxG.state = new PlayState();

            // Sound is played after the state switch to keep it from being destroyed
            FlxG.play(GameAssets.FroggerThemeSound);

        }

        /**
         * This removed the click listener.
         */
        override public function destroy():void
        {
            stage.removeEventListener(MouseEvent.CLICK, onClick);
            super.destroy();
        }

        override public function render():void
        {
            if (FlxG.keys.justPressed("ENTER"))
                onClick(new MouseEvent(MouseEvent.CLICK));

            super.render();
        }


    }
}