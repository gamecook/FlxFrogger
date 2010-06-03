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
    public class TurtlesB extends TurtlesA
    {

        [Embed(source="../build/assets/turtle_3_sprites.png")]
        private var SpriteImage:Class;

        public static const SPRITE_WIDTH:int = 99;
        public static const SPRITE_HEIGHT:int = 40;
        public static const DEFAULT_TIME:int = 300;

        public function TurtlesB(x:Number, y:Number, hideTimer:int = DEFAULT_TIME, startTime:int = DEFAULT_TIME, dir:uint = RIGHT, velocity:int = 40)
        {
            super(x, y, hideTimer, startTime, dir, velocity);

            loadGraphic(SpriteImage, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);

        }

    }
}