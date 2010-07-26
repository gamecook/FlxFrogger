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
com.flashartofwar.frogger.controls
{
    import flash.events.KeyboardEvent;

    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxState;
    import org.flixel.FlxText;
    import org.flixel.FlxSprite;

    public class TouchControls extends FlxGroup
    {
        private var spriteButton1:FlxSprite;
        private var spriteButton2:FlxSprite;
        private var spriteButton3:FlxSprite;
        private var spriteButton4:FlxSprite;

        /**
         * Touch controls are special buttons that allow virtual input for the game on devices without a keyboard.
         *
         * @param target Where should the controls be added onto
         * @param x x position to display the controls
         * @param y y position to display the controls
         * @param padding space between each button
         */
        public function TouchControls(target:FlxState, x:int, y:int, padding:int)
        {

            this.x = x;
            this.y = y;
            
            var txt:FlxText;

            //spriteButton1 = new FlxSprite(x, y)
            spriteButton1 = new FlxSprite(0, 0)
            spriteButton1.color =0x999999;
            spriteButton1.createGraphic(100, 100);
            add(spriteButton1);
            txt = new FlxText(0, 30, 100, "UP").setFormat(null, 20, 0xffffff, "center");
            add(txt);

            spriteButton2 = new FlxSprite(spriteButton1.right + padding, 0)
            spriteButton2.color =0x999999;
            spriteButton2.createGraphic(100, 100);
            add(spriteButton2);
            txt = new FlxText(spriteButton2.x, 30, 100, "DOWN").setFormat(null, 20, 0xffffff, "center");
            add(txt);

            spriteButton3 = new FlxSprite(spriteButton2.right + padding, 0)
            spriteButton3.color =0x999999;
            spriteButton3.createGraphic(100, 100);
            add(spriteButton3);
            txt = new FlxText(spriteButton3.x, 30, 100, "LEFT").setFormat(null, 20, 0xffffff, "center");
            add(txt);

            spriteButton4 = new FlxSprite(spriteButton3.right + padding, 0)
            spriteButton4.color =0x999999;
            spriteButton4.createGraphic(100, 100);
            add(spriteButton4);
            txt = new FlxText(spriteButton4.x, 30, 100, "RIGHT").setFormat(null, 20, 0xffffff, "center");
            add(txt);
        }

        override public function update():void
        {

            if (FlxG.mouse.justPressed())
            {
                if (spriteButton1.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y))
                {
                    spriteButton1.color = 0xff0000;
                    FlxG.keys.handleKeyDown(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, 38, 0, false, false, false));
                }
                else if (spriteButton2.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y))
                {
                    spriteButton2.color = 0xff0000;
                    FlxG.keys.handleKeyDown(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, 40, 0, false, false, false));
                }
                else if (spriteButton3.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y))
                {
                    spriteButton3.color = 0xff0000;
                    FlxG.keys.handleKeyDown(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, 37, 0, false, false, false));
                }
                else if (spriteButton4.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y))
                {
                    spriteButton4.color = 0xff0000;
                    FlxG.keys.handleKeyDown(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, 39, 0, false, false, false));
                }


            }
            else if (FlxG.mouse.justReleased())
            {
                spriteButton1.color = 0x999999;
                spriteButton2.color = 0x999999;
                spriteButton3.color = 0x999999;
                spriteButton4.color = 0x999999;
                if (spriteButton1.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y))
                    FlxG.keys.handleKeyUp(new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 0, 38, 0, false, false, false));
                else if (spriteButton2.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y))
                    FlxG.keys.handleKeyUp(new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 0, 40, 0, false, false, false));
                else if (spriteButton3.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y))
                    FlxG.keys.handleKeyUp(new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 0, 37, 0, false, false, false));
                else if (spriteButton4.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y))
                    FlxG.keys.handleKeyUp(new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 0, 39, 0, false, false, false));
            }

            super.update(); //uncommenting this breaks it. dont know why.

        }
    }
}
