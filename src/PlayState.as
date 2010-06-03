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
    import flash.ui.Multitouch;
    import flash.ui.MultitouchInputMode;

    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxText;
    import org.flixel.FlxU;

    public class PlayState extends FlxState
    {

        [Embed(source="../build/assets/background.png")]
        private var LevelSprite:Class;

        [Embed(source="../build/assets/lives.png")]
        private var LivesSprite:Class;

        [Embed(source="../build/assets/frogger_sounds.swf", symbol="FroggerExtraSound")]
        private static var FroggerExtraSound:Class;

        [Embed(source="../build/assets/frogger_sounds.swf", symbol="FroggerPlunkSound")]
        private static var FroggerPlunkSound:Class;

        [Embed(source="../build/assets/frogger_sounds.swf", symbol="FroggerSquashSound")]
        private static var FroggerSquashSound:Class;

        [Embed(source="../build/assets/frogger_sounds.swf", symbol="FroggerTimeSound")]
        private static var FroggerTimeSound:Class;


        public static const WELCOME_STATE:uint = 0;
        public static const PLAYING_STATE:uint = 1;
        public static const COLLISION_STATE:uint = 2;
        public static const RESTART_STATE:uint = 3;
        public static const GAME_OVER_STATE:uint = 4;
        public static const DEATH_OVER:uint = 5;

        public var collision:Boolean;
        public var gameState:uint;

        private const TILE_SIZE:int = 40;

        private var player:Frog;
        private var logGroup:FlxGroup;
        private var carGroup:FlxGroup;
        private var turtleGroup:FlxGroup;
        private var timerBar:FlxSprite;
        private var gameTime:int = 1800;
        private var timer:int;
        private var waterY:int;
        private var lifeSprites:Array = [];
        private const LIFE_X:int = 20;
        private const LIFE_Y:int = 600;
        private var bonusGroup:FlxGroup;
        private var timerBarBackground:FlxSprite;
        private var timeTxt:FlxText;
        private const TIMER_BAR_WIDTH:int = 300;
        private var playerIsFloating:Boolean;
        private var scoreTxt:FlxText;
        private var safeFrogs:int = 0;

        override public function create():void
        {
            //FlxG.showBounds = true;

            Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

            timer = gameTime;

            waterY = TILE_SIZE * 8;
            var bg:FlxSprite = new FlxSprite(0, 0, LevelSprite);
            add(bg);


            var demoTXT:FlxText = add(new FlxText(0, 0, 480, "Flixel Frogger Demo").setFormat(null, 20, 0xffffff, "center", 0x000000)) as FlxText;
            var credits:FlxText = add(new FlxText(0, demoTXT.height, 480, "by Jesse Freeman").setFormat(null, 10, 0xffffff, "center", 0x000000)) as FlxText;
            var scoreLabel:FlxText = add(new FlxText(0, demoTXT.height, 100, "Score").setFormat(null, 10, 0xffffff, "right")) as FlxText;


            scoreTxt = add(new FlxText(0, scoreLabel.height, 100, "").setFormat(null, 14, 0xffe00000, "right")) as FlxText;
            FlxG.score = 0;

            createLives(3);

            // Bonus

            bonusGroup = new FlxGroup();

            bonusGroup.add(new Bonus(calculateColumn(0) + 15, calculateRow(2), 200, 200));
            bonusGroup.add(new Bonus(calculateColumn(3) - 5, calculateRow(2), 200, 200));
            bonusGroup.add(new Bonus(calculateColumn(5) + 20, calculateRow(2), 200, 200));
            bonusGroup.add(new Bonus(calculateColumn(8), calculateRow(2), 200, 200));
            bonusGroup.add(new Bonus(calculateColumn(11) - 15, calculateRow(2), 200, 200));

            add(bonusGroup);

            // Create Logs

            logGroup = new FlxGroup();
            turtleGroup = new FlxGroup();

            logGroup.add(new Log(0, calculateRow(3), Log.TypeC, FlxSprite.RIGHT, 1));
            logGroup.add(new Log(Log.TypeCWidth + 77, calculateRow(3), Log.TypeC, FlxSprite.RIGHT, 1));
            logGroup.add(new Log((Log.TypeCWidth + 77) * 2, calculateRow(3), Log.TypeC, FlxSprite.RIGHT, 1));

            turtleGroup.add(new TurtlesA(0, calculateRow(4), -1, -1, FlxSprite.LEFT, 1));
            turtleGroup.add(new TurtlesA((TurtlesA.SPRITE_WIDTH + 123) * 1, calculateRow(4), TurtlesA.DEFAULT_TIME, 200, FlxSprite.LEFT, 1));
            turtleGroup.add(new TurtlesA((TurtlesA.SPRITE_WIDTH + 123) * 2, calculateRow(4), -1, -1, FlxSprite.LEFT, 1));

            logGroup.add(new Log(0, calculateRow(5), Log.TypeB, FlxSprite.RIGHT, 1));
            logGroup.add(new Log(Log.TypeBWidth + 70, calculateRow(5), Log.TypeB, FlxSprite.RIGHT, 1));

            logGroup.add(new Log(0, calculateRow(6), Log.TypeA, FlxSprite.RIGHT, 1));
            logGroup.add(new Log(Log.TypeAWidth + 77, calculateRow(6), Log.TypeA, FlxSprite.RIGHT, 1));
            logGroup.add(new Log((Log.TypeAWidth + 77) * 2, calculateRow(6), Log.TypeA, FlxSprite.RIGHT, 1));

            turtleGroup.add(new TurtlesB(0, calculateRow(7), TurtlesA.DEFAULT_TIME, 0, FlxSprite.LEFT, 1));
            turtleGroup.add(new TurtlesB((TurtlesB.SPRITE_WIDTH + 95) * 1, calculateRow(7), -1, -1, FlxSprite.LEFT, 1));
            turtleGroup.add(new TurtlesB((TurtlesB.SPRITE_WIDTH + 95) * 2, calculateRow(7), -1, -1, FlxSprite.LEFT, 1));


            add(logGroup);
            add(turtleGroup);

            player = add(new Frog(calculateColumn(6), calculateRow(14) + 2)) as Frog;

            // Cars
            carGroup = new FlxGroup();

            carGroup.add(new Truck(0, calculateRow(9), FlxSprite.LEFT, 1));
            carGroup.add(new Truck(270, calculateRow(9), FlxSprite.LEFT, 1));

            carGroup.add(new Car(0, calculateRow(10), Car.TYPE_C, FlxSprite.RIGHT, 1));
            carGroup.add(new Car(270, calculateRow(10), Car.TYPE_C, FlxSprite.RIGHT, 1));

            carGroup.add(new Car(0, calculateRow(11), Car.TYPE_D, FlxSprite.LEFT, 1));
            carGroup.add(new Car(270, calculateRow(11), Car.TYPE_D, FlxSprite.LEFT, 1));


            carGroup.add(new Car(0, calculateRow(12), Car.TYPE_B, FlxSprite.RIGHT, 1));
            carGroup.add(new Car((Car.SPRITE_WIDTH + 138) * 1, calculateRow(12), Car.TYPE_B, FlxSprite.RIGHT, 1));
            carGroup.add(new Car((Car.SPRITE_WIDTH + 138) * 2, calculateRow(12), Car.TYPE_B, FlxSprite.RIGHT, 1));

            carGroup.add(new Car(0, calculateRow(13), Car.TYPE_A, FlxSprite.LEFT, 1));
            carGroup.add(new Car((Car.SPRITE_WIDTH + 138) * 1, calculateRow(13), Car.TYPE_A, FlxSprite.LEFT, 1));
            carGroup.add(new Car((Car.SPRITE_WIDTH + 138) * 2, calculateRow(13), Car.TYPE_A, FlxSprite.LEFT, 1));

            add(carGroup);


            timeTxt = new FlxText(bg.width - 70, LIFE_Y + 18, 60, "TIME").setFormat(null, 14, 0xffff00, "right");
            add(timeTxt);

            timerBarBackground = new FlxSprite(timeTxt.x - TIMER_BAR_WIDTH + 5, LIFE_Y + 20);
            timerBarBackground.createGraphic(TIMER_BAR_WIDTH, 16, 0xff21de00);
            add(timerBarBackground);

            timerBar = new FlxSprite(timerBarBackground.x, timerBarBackground.y);
            timerBar.createGraphic(1, 16, 0xFF000000);
            timerBar.scrollFactor.x = timerBar.scrollFactor.y = 0;
            timerBar.origin.x = timerBar.origin.y = 0;
            timerBar.scale.x = 0;
            add(timerBar);

            CONFIG::mobile
            var touchControls:TouchControls = new TouchControls(this, 10, calculateRow(16) + 20, 16);


            gameState = PLAYING_STATE;


        }

        public function calculateColumn(value:int):int
        {
            return value * TILE_SIZE;
        }

        public function calculateRow(value:int):int
        {
            return calculateColumn(value);
        }

        override public function update():void
        {
            playerIsFloating = false;
            timer -= FlxG.elapsed;

            timerBar.scale.x = TIMER_BAR_WIDTH - Math.round((timer / gameTime * TIMER_BAR_WIDTH));

            if (timer == 0)
            {
                timeUp();
            }
            //Updates all the objects appropriately

            if (gameState == DEATH_OVER)
            {
                restart();
            }

            else
            {
                FlxU.overlap(carGroup, player, carDeath);
                FlxU.overlap(logGroup, player, float);
                FlxU.overlap(turtleGroup, player, turtleFloat);
                FlxU.overlap(bonusGroup, player, bonus)

                if (player.y < waterY)
                {
                    if (!player.isMoving && !playerIsFloating)
                        waterDeath();

                    if ((player.x > FlxG.width - TILE_SIZE) || (player.x < 0 ))
                    {
                        waterDeath()
                    }
                }
            }

            super.update();

            scoreTxt.text = FlxG.score.toString();
        }

        private function timeUp():void
        {
            if (gameState != COLLISION_STATE)
            {
                killPlayer();
            }
        }

        private function waterDeath():void
        {
            if (gameState != COLLISION_STATE)
            {
                FlxG.play(FroggerPlunkSound);
                killPlayer();
            }
        }

        private function carDeath(Collision:FlxSprite, Player:Frog):void
        {
            if (gameState != COLLISION_STATE)
            {
                FlxG.play(FroggerSquashSound);
                killPlayer();
            }
        }

        private function bonus(collision:Bonus, player:Frog):void
        {

            safeFrogs ++;
            collision.success();

            if (safeFrogs == 5)
                levelComplete();
            else
                restart();

        }

        private function levelComplete():void
        {
            FlxG.score += ScoreValues.FINISH_LEVEL;

            calculateLeftOverTime();
        }

        private function calculateLeftOverTime():void
        {

        }

        private function turtleFloat(collision:TimerSprite, player:Frog):void
        {
            if (collision.isActive)
            {
                float(collision, player);
            }
            else if (!player.isMoving)
            {
                waterDeath();
            }
        }

        private function float(Collision:WrappingSprite, Player:Frog):void
        {
            playerIsFloating = true;

            if (!(FlxG.keys.LEFT || FlxG.keys.RIGHT))
            {
                Player.float(Collision.speed, Collision.facing);
            }
        }

        private function restart():void
        {
            if (totalLives == 0)
            {
                gameOver();
            }
            else
            {
                player.restart();
                timer = gameTime;
                PlayState(FlxG.state).gameState = PlayState.PLAYING_STATE;
            }
        }

        private function killPlayer():void
        {

            gameState = COLLISION_STATE;

            player.death();

            removeLife(1);

        }

        private function gameOver():void
        {
            gameState = COLLISION_STATE;
        }

        private function createLives(value:int):void
        {
            for (var i:int = 0; i < value; i++)
            {
                addLife(1);
            }
        }

        private function addLife(value:int):void
        {
            var flxLife:FlxSprite = new FlxSprite(LIFE_X * totalLives, LIFE_Y, LivesSprite);
            add(flxLife);
            lifeSprites.push(flxLife);
        }

        private function removeLife(value:int):void
        {
            var id:int = totalLives - 1;
            var sprite:FlxSprite = lifeSprites[id];
            sprite.kill();
            lifeSprites.splice(id, 1);
        }

        private function get totalLives():int
        {
            return lifeSprites.length;
        }
    }
}