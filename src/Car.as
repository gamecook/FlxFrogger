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
    public class Car extends WrappingSprite
    {

        [Embed(source="../build/assets/car_sprites.png")]
        private var SpriteImage:Class;

        public static const SPRITE_WIDTH:uint = 40;
        public static const SPRITE_HEIGHT:uint = 40;

        public static const TYPE_A:uint = 0;
        public static const TYPE_B:uint = 1;
        public static const TYPE_C:uint = 2;
        public static const TYPE_D:uint = 3;

        public function Car(x:Number, y:Number, type:uint, direction:int, velocity:int)
        {
            super(x, y, null, direction, velocity);

            loadGraphic(SpriteImage, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);

            frame = type;
        }
    }
}