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

    public class Alligator extends WrappingSprite
    {

        
        public static const SPRITE_WIDTH:int = 102;
        public static const SPRITE_HEIGHT:int = 40;
        public static const VELOCITY:int = 40;

        /**
         * This is a simple sprite which represents the Alligator.
         *
         * @param X start X
         * @param Y start Y
         * @param dir direction the sprite will move in
         * @param speed speed in pixels the sprite will move on update
         */
        public function Alligator(X:Number, Y:Number, dir:uint, speed:int)
        {
            //TODO need to add in logic to for frog hit test since landing on the head counts as a kill

            super(X, Y, null, dir, speed);

            loadGraphic(GameAssets.AlligatorSprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);

            addAnimation("idle", [0,1], 1, true);

            play("idle");
        }


    }
}