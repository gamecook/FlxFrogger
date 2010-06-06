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

        public static const TypeA:uint = 0;
        public static const TypeB:uint = 1;
        public static const TypeC:uint = 2;

        public static const TypeAWidth:uint = 47;
        public static const TypeBWidth:uint = 98;
        public static const TypeCWidth:uint = 63;

        public function Log(x:Number, y:Number, type:uint, dir:uint, velocity:uint)
        {

            var graphicClass:Class;

            switch (type)
            {
                case TypeA:
                    graphicClass = SpriteImage1;
                    break;
                case TypeB:
                    graphicClass = SpriteImage2;
                    break;
                case TypeC:
                    graphicClass = SpriteImage3;
                    break;
            }

            super(x, y, graphicClass, dir, velocity);

        }
    }
}