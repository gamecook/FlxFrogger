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
    import com.flashartofwar.frogger.enum.GameStates;
    import com.flashartofwar.frogger.enum.ScoreValues;
    import com.flashartofwar.frogger.states.PlayState;

    import flash.geom.Point;

    import org.flixel.FlxG;
    import org.flixel.FlxSprite;

    public class Frog extends FlxSprite
    {

        [Embed(source="../../../../../build/assets/frog_sprites.png")]
        private var SpriteImage:Class;

        [Embed(source="../../../../../build/assets/frogger_sounds.swf", symbol="FroggerHopSound")]
        private static var FroggerHopSound:Class;


        private var startPosition:Point;
        private var moveX:int;
        private var maxMoveX:int;
        private var maxMoveY:int;
        private var targetX:Number;
        private var targetY:Number;
        private var animationFrames:int = 8;
        private var moveY:Number;
        private var state:PlayState;
        public var isMoving:Boolean;

        public function Frog(X:Number, Y:Number)
        {
            super(X, Y);

            startPosition = new Point(X, Y);
            loadGraphic(SpriteImage, true, false, 40, 40);

            moveX = 5;
            moveY = 5;
            maxMoveX = moveX * animationFrames;
            maxMoveY = moveY * animationFrames;

            targetX = X;
            targetY = Y;


            addAnimation("idle" + UP, [0], 0, false);
            addAnimation("idle" + RIGHT, [2], 0, false);
            addAnimation("idle" + DOWN, [4], 0, false);
            addAnimation("idle" + LEFT, [6], 0, false);
            addAnimation("walk" + UP, [0,1], 15, true);
            addAnimation("walk" + RIGHT, [2,3], 15, true);
            addAnimation("walk" + DOWN, [4,5], 15, true);
            addAnimation("walk" + LEFT, [6,7], 15, true);
            addAnimation("die", [8, 9, 10, 11], 2, false);

            facing = FlxSprite.UP;

            state = FlxG.state as PlayState;
        }

        override public function set facing(value:uint):void
        {
            super.facing = value;

            if (value == UP || value == DOWN)
            {
                width = 32;
                height = 25;
                offset.x = 4;
                offset.y = 6;
            }
            else
            {
                width = 25;
                height = 32;
                offset.x = 6;
                offset.y = 4;
            }
        }

        override public function update():void
        {

            if (state.gameState == GameStates.COLLISION_STATE && (frame == 11))
            {
                state.gameState = GameStates.DEATH_OVER;
            }
            else if (state.gameState == GameStates.PLAYING_STATE)
            {

                if (x == targetX && y == targetY)
                {
                    // Handle Moving Right and Left
                    if (FlxG.keys.justPressed("LEFT") && x > 0)
                    {
                        targetX = x - maxMoveX;
                        facing = LEFT;
                    }
                    else if (FlxG.keys.justPressed("RIGHT") && x < FlxG.width - frameWidth)
                    {
                        targetX = x + maxMoveX;
                        facing = RIGHT;
                    }
                    else if (FlxG.keys.justPressed("UP") && y > frameHeight)
                    {
                        targetY = y - maxMoveY;
                        facing = UP;
                    }
                    else if (FlxG.keys.justPressed("DOWN") && y < 560)
                    {
                        targetY = y + maxMoveY;
                        facing = DOWN;
                    }

                    // See if we are moving
                    if (x != targetX || y != targetY)
                    {
                        //Looks like we are moving so play sound, flag isMoving and add to score.
                        FlxG.play(FroggerHopSound);
                        isMoving = true;
                        FlxG.score += ScoreValues.STEP;
                    }
                    else
                    {
                        // Nope, we are not moving so flag isMoving and show Idle.
                        isMoving = false;

                    }

                }

                // If isMoving is true we are going to update the actual position.
                if (isMoving == true)
                {
                    if (facing == LEFT)
                    {
                        x -= moveX;
                    } else if (facing == RIGHT)
                    {
                        x += moveX;
                    } else if (facing == UP)
                    {
                        y -= moveY;
                    } else if (facing == DOWN)
                    {
                        y += moveY;
                    }

                    play("walk" + facing);

                }
                else
                {
                    play("idle" + facing);
                }

            }

            //Default object physics update
            super.update();
        }

        public function death():void
        {
            play("die");
        }

        public function restart():void
        {
            isMoving = false;
            x = startPosition.x;
            y = startPosition.y;
            targetX = startPosition.x;
            targetY = startPosition.y;
            facing = UP;
            play("idle" + facing);
            if (!visible) visible = true;

        }

        public function float(speed:int, facing:uint):void
        {
            if (isMoving != true)
            {
                x += (facing == RIGHT) ? speed : -speed;
                targetX = x;
                isMoving = true;
            }
        }
    }
}