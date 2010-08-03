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
        /*private var spriteButtons[0]:FlxSprite;
        private var spriteButtons[1]:FlxSprite;
        private var spriteButtons[2]:FlxSprite;
        private var spriteButtons[3]:FlxSprite;*/
		private var spriteButtons:Array;

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
			spriteButtons = new Array(4);

            //spriteButtons[0] = new FlxSprite(x, y)
            spriteButtons[0] = new FlxSprite(0, 0)
            spriteButtons[0].color =0x999999;
            spriteButtons[0].createGraphic(100, 100);
            add(spriteButtons[0]);
            txt = new FlxText(0, 30, 100, "UP").setFormat(null, 20, 0xffffff, "center");
            add(txt);

            spriteButtons[1] = new FlxSprite(spriteButtons[0].right + padding, 0)
            spriteButtons[1].color =0x999999;
            spriteButtons[1].createGraphic(100, 100);
            add(spriteButtons[1]);
            txt = new FlxText(spriteButtons[1].x, 30, 100, "DOWN").setFormat(null, 20, 0xffffff, "center");
            add(txt);

            spriteButtons[2] = new FlxSprite(spriteButtons[1].right + padding, 0)
            spriteButtons[2].color =0x999999;
            spriteButtons[2].createGraphic(100, 100);
            add(spriteButtons[2]);
            txt = new FlxText(spriteButtons[2].x, 30, 100, "LEFT").setFormat(null, 20, 0xffffff, "center");
            add(txt);

            spriteButtons[3] = new FlxSprite(spriteButtons[2].right + padding, 0)
            spriteButtons[3].color =0x999999;
            spriteButtons[3].createGraphic(100, 100);
            add(spriteButtons[3]);
            txt = new FlxText(spriteButtons[3].x, 30, 100, "RIGHT").setFormat(null, 20, 0xffffff, "center");
            add(txt);
        }

		public function justPressed(button:Number):Boolean
		{
			return FlxG.mouse.justPressed() && spriteButtons[button].overlapsPoint(FlxG.mouse.x, FlxG.mouse.y);
		}

		public function justReleased(button:Number):Boolean
		{
			return FlxG.mouse.justReleased() && spriteButtons[button].overlapsPoint(FlxG.mouse.x, FlxG.mouse.y);
		}

        override public function update():void
        {

            if (FlxG.mouse.justPressed())
            {
                if (spriteButtons[0].overlapsPoint(FlxG.mouse.x, FlxG.mouse.y))
                {
                    spriteButtons[0].color = 0xff0000;
                }
                else if (spriteButtons[1].overlapsPoint(FlxG.mouse.x, FlxG.mouse.y))
                {
                    spriteButtons[1].color = 0xff0000;
                }
                else if (spriteButtons[2].overlapsPoint(FlxG.mouse.x, FlxG.mouse.y))
                {
                    spriteButtons[2].color = 0xff0000;
                }
                else if (spriteButtons[3].overlapsPoint(FlxG.mouse.x, FlxG.mouse.y))
                {
                    spriteButtons[3].color = 0xff0000;
                }


            }
            else if (FlxG.mouse.justReleased())
            {
                spriteButtons[0].color = 0x999999;
                spriteButtons[1].color = 0x999999;
                spriteButtons[2].color = 0x999999;
                spriteButtons[3].color = 0x999999;
            }

            super.update(); //uncommenting this breaks it. dont know why.

        }
    }
}
