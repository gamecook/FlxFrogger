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
    import com.flashartofwar.frogger.sprites.core.WrappingSprite;

    public class Log extends WrappingSprite
    {

        [Embed(source="../../../../../build/assets/tree_1.png")]
        private var SpriteImage1:Class;
        [Embed(source="../../../../../build/assets/tree_2.png")]
        private var SpriteImage2:Class;
        [Embed(source="../../../../../build/assets/tree_3.png")]
        private var SpriteImage3:Class;

        public static const TYPE_A:int = 0;
        public static const TYPE_B:int = 1;
        public static const TYPE_C:int = 2;

        public static const TYPE_A_WIDTH:int = 95;
        public static const TYPE_B_WIDTH:int = 196;
        public static const TYPE_C_WIDTH:int = 127;

        /**
         * Simple sprite to represent a log. There are 3 types of logs, represented by TYPE_A, _B, and
         * _C constant.
         *
         * @param x start X
         * @param y start Y
         * @param type type of car to use. Type_A, _b, _c, and _d are referenced as constants on the class
         * @param direction the direction the sprite will move in
         * @param speed the speed in pixels in which the sprite will move on update
         */
        public function Log(x:Number, y:Number, type:int, dir:int, velocity:int)
        {

            var graphicClass:Class;

            switch (type)
            {
                case TYPE_A:
                    graphicClass = SpriteImage1;
                    break;
                case TYPE_B:
                    graphicClass = SpriteImage2;
                    break;
                case TYPE_C:
                    graphicClass = SpriteImage3;
                    break;
            }

            super(x, y, graphicClass, dir, velocity);

        }
    }
}