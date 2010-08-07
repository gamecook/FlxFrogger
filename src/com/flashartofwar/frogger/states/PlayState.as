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
com.flashartofwar.frogger.states {
	import com.flashartofwar.frogger.sprites.GameAssets;
	import com.flashartofwar.frogger.controls.TouchControls;
    import com.flashartofwar.frogger.enum.GameStates;
    import com.flashartofwar.frogger.enum.ScoreValues;
    import com.flashartofwar.frogger.sprites.Car;
    import com.flashartofwar.frogger.sprites.Frog;
    import com.flashartofwar.frogger.sprites.Home;
    import com.flashartofwar.frogger.sprites.Log;
    import com.flashartofwar.frogger.sprites.Truck;
    import com.flashartofwar.frogger.sprites.TurtlesA;
    import com.flashartofwar.frogger.sprites.TurtlesB;
    import com.flashartofwar.frogger.sprites.core.TimerSprite;
    import com.flashartofwar.frogger.sprites.core.WrappingSprite;

    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxText;
    import org.flixel.FlxU;

    public class PlayState extends FlxState
    {

        private const LIFE_X:int = 20;
        private const LIFE_Y:int = 600;
        private const TIMER_BAR_WIDTH:int = 300;
        private const TILE_SIZE:int = 40;
		public var gameState:uint;

        private var player:Frog;
        private var logGroup:FlxGroup;
        private var carGroup:FlxGroup;
        private var turtleGroup:FlxGroup;
        private var timerBar:FlxSprite;
        private var gameTime:int;
        private var timer:int;
        private var waterY:int;
        private var lifeSprites:Array = [];
        private var homeBaseGroup:FlxGroup;
        private var timerBarBackground:FlxSprite;
        private var timeTxt:FlxText;
        private var playerIsFloating:Boolean;
        private var scoreTxt:FlxText;
        private var safeFrogs:int = 0;
        private var messageText:FlxText;
        private var gameMessageGroup:FlxGroup;
        private var hideGameMessageDelay:int = -1;
        private var timeAlmostOverFlag:Boolean = false;
        private var timeAlmostOverWarning:int;
        private var bases:Array;

        /**
         * This is the main method responsible for creating all of the game pieces and layout out the level.
         */
        override public function create():void
        {
            // Create the BG sprite
            var bg:FlxSprite = new FlxSprite(0, 0, GameAssets.LevelSprite);
            add(bg);

            // Set up main variable properties
            gameTime = 60 * FlxG.framerate;
            timer = gameTime;
            timeAlmostOverWarning = TIMER_BAR_WIDTH * .7;
            waterY = TILE_SIZE * 8;
            FlxG.score = 0;
            createLives(3);


            // Create Text for title, credits, and score
            var demoTXT:FlxText = add(new FlxText(0, 0, 480, "Flixel Frogger Demo").setFormat(null, 20, 0xffffff, "center", 0x000000)) as FlxText;
            var scoreLabel:FlxText = add(new FlxText(0, demoTXT.height, 100, "Score").setFormat(null, 10, 0xffffff, "right")) as FlxText;
            scoreTxt = add(new FlxText(0, scoreLabel.height, 100, "").setFormat(null, 14, 0xffe00000, "right")) as FlxText;


            // Create game message, this handles game over, time, and start message for player
            gameMessageGroup = new FlxGroup();
            gameMessageGroup.x = (480 * .5) - (150 * .5);
            gameMessageGroup.y = calculateRow(8) + 5;
            add(gameMessageGroup);

            // Black background for message
            var messageBG:FlxSprite = new FlxSprite(0, 0);
            messageBG.createGraphic(150, 30, 0xff000000);
            gameMessageGroup.add(messageBG);

            // Message text
            messageText = new FlxText(0, 4, 150, "TIME 99").setFormat(null, 18, 0xffff00000, "center");
            gameMessageGroup.visible = false;
            gameMessageGroup.add(messageText);

            // Create home bases sprites and an array to store references to them
            bases = new Array();
            homeBaseGroup = new FlxGroup();
            add(homeBaseGroup);
            bases.push(homeBaseGroup.add(new Home(calculateColumn(0) + 15, calculateRow(2), 200, 200)));
            bases.push(homeBaseGroup.add(new Home(calculateColumn(3) - 5, calculateRow(2), 200, 200)));
            bases.push(homeBaseGroup.add(new Home(calculateColumn(5) + 20, calculateRow(2), 200, 200)));
            bases.push(homeBaseGroup.add(new Home(calculateColumn(8), calculateRow(2), 200, 200)));
            bases.push(homeBaseGroup.add(new Home(calculateColumn(11) - 15, calculateRow(2), 200, 200)));

            // Create logs and turtles
            logGroup = add(new FlxGroup()) as FlxGroup;
            turtleGroup = add(new FlxGroup()) as FlxGroup;

            logGroup.add(new Log(0, calculateRow(3), Log.TYPE_C, FlxSprite.RIGHT, 1));
            logGroup.add(new Log(Log.TYPE_C_WIDTH + 77, calculateRow(3), Log.TYPE_C, FlxSprite.RIGHT, 1));
            logGroup.add(new Log((Log.TYPE_C_WIDTH + 77) * 2, calculateRow(3), Log.TYPE_C, FlxSprite.RIGHT, 1));

            turtleGroup.add(new TurtlesA(0, calculateRow(4), -1, -1, FlxSprite.LEFT, 1));
            turtleGroup.add(new TurtlesA((TurtlesA.SPRITE_WIDTH + 123) * 1, calculateRow(4), TurtlesA.DEFAULT_TIME, 200, FlxSprite.LEFT, 1));
            turtleGroup.add(new TurtlesA((TurtlesA.SPRITE_WIDTH + 123) * 2, calculateRow(4), -1, -1, FlxSprite.LEFT, 1));

            logGroup.add(new Log(0, calculateRow(5), Log.TYPE_B, FlxSprite.RIGHT, 1));
            logGroup.add(new Log(Log.TYPE_B_WIDTH + 70, calculateRow(5), Log.TYPE_B, FlxSprite.RIGHT, 1));

            logGroup.add(new Log(0, calculateRow(6), Log.TYPE_A, FlxSprite.RIGHT, 1));
            logGroup.add(new Log(Log.TYPE_A_WIDTH + 77, calculateRow(6), Log.TYPE_A, FlxSprite.RIGHT, 1));
            logGroup.add(new Log((Log.TYPE_A_WIDTH + 77) * 2, calculateRow(6), Log.TYPE_A, FlxSprite.RIGHT, 1));

            turtleGroup.add(new TurtlesB(0, calculateRow(7), TurtlesA.DEFAULT_TIME, 0, FlxSprite.LEFT, 1));
            turtleGroup.add(new TurtlesB((TurtlesB.SPRITE_WIDTH + 95) * 1, calculateRow(7), -1, -1, FlxSprite.LEFT, 1));
            turtleGroup.add(new TurtlesB((TurtlesB.SPRITE_WIDTH + 95) * 2, calculateRow(7), -1, -1, FlxSprite.LEFT, 1));

            // Create Player
            player = add(new Frog(calculateColumn(6), calculateRow(14) + 6)) as Frog;

            // Create Cars
            carGroup = add(new FlxGroup()) as FlxGroup;

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

            // Create Time text
            timeTxt = new FlxText(bg.width - 70, LIFE_Y + 18, 60, "TIME").setFormat(null, 14, 0xffff00, "right");
            add(timeTxt);

            // Create timer graphic
            //TODO this is hacky and needs to be cleaned up
            timerBarBackground = new FlxSprite(timeTxt.x - TIMER_BAR_WIDTH + 5, LIFE_Y + 20);
            timerBarBackground.createGraphic(TIMER_BAR_WIDTH, 16, 0xff21de00);
            add(timerBarBackground);

            timerBar = new FlxSprite(timerBarBackground.x, timerBarBackground.y);
            timerBar.createGraphic(1, 16, 0xFF000000);
            timerBar.scrollFactor.x = timerBar.scrollFactor.y = 0;
            timerBar.origin.x = timerBar.origin.y = 0;
            timerBar.scale.x = 0;
            add(timerBar);

            // Mobile specific code goes here
            /*FDT_IGNORE*/
            CONFIG::mobile
            {
            /*FDT_IGNORE*/
                var touchControls:TouchControls = new TouchControls(this, 10, calculateRow(16) + 20, 16);
                add(touchControls);
            /*FDT_IGNORE*/    
            }
			/*FDT_IGNORE*/
			
            // Activate game by setting the correct state
            gameState = GameStates.PLAYING;

        }

        /**
         * Helper function to find the X position of a column on the game's grid
         * @param value column number
         * @return returns number based on the value * TILE_SIZE
         */
        public function calculateColumn(value:int):int
        {
            return value * TILE_SIZE;
        }

        /**
         * Helper function to find the Y position of a row on the game's grid
         * @param value row number
         * @return returns number based on the value * TILE_SIZE
         */
        public function calculateRow(value:int):int
        {
            return calculateColumn(value);
        }

        /**
         * This is the main game loop. It goes through, analyzes the game state and performs collision detection.
         */
        override public function update():void
        {

            //TODO these first two condition based on hideGameMessageDelay can be cleaned up.
            if (gameState == GameStates.GAME_OVER)
            {
                if (hideGameMessageDelay == 0)
                {
                    FlxG.state = new StartState();
                }
                else
                {
                    hideGameMessageDelay -= FlxG.elapsed;
                }
            }
            else if (gameState == GameStates.LEVEL_OVER)
            {
                if (hideGameMessageDelay == 0)
                {
                    restart();
                }
                else
                {
                    hideGameMessageDelay -= FlxG.elapsed;
                }
            }
            else if (gameState == GameStates.PLAYING)
            {
                // Reset floating flag for the player.
                playerIsFloating = false;

                // Do collision detections
                FlxU.overlap(carGroup, player, carCollision);
                FlxU.overlap(logGroup, player, float);
                FlxU.overlap(turtleGroup, player, turtleFloat);
                FlxU.overlap(homeBaseGroup, player, baseCollision);

                // If nothing has collided with the player, test to see if they are out of bounds when in the water zone
                if (player.y < waterY)
                {
                    //TODO this can be cleaned up better
                    if (!player.isMoving && !playerIsFloating)
                        waterCollision();

                    if ((player.x > FlxG.width) || (player.x < -TILE_SIZE ))
                    {
                        waterCollision();
                    }

                }

                // This checks to see if time has run out. If not we decrease time based on what has elapsed
                // sine the last update. 
                if (timer == 0 && gameState == GameStates.PLAYING)
                {
                    timeUp();
                }
                else
                {
                    timer -= FlxG.elapsed;
                    timerBar.scale.x = TIMER_BAR_WIDTH - Math.round((timer / gameTime * TIMER_BAR_WIDTH));

                    if (timerBar.scale.x == timeAlmostOverWarning && !timeAlmostOverFlag)
                    {
                        FlxG.play(GameAssets.FroggerTimeSound);
                        timeAlmostOverFlag = true;
                    }
                }

                // Manage hiding gameMessage based on timer
                if (hideGameMessageDelay > 0)
                {
                    hideGameMessageDelay -= FlxG.elapsed;
                    if (hideGameMessageDelay < 0) hideGameMessageDelay = 0;
                }
                else if (hideGameMessageDelay == 0)
                {
                    hideGameMessageDelay = -1;
                    gameMessageGroup.visible = false;
                }

                // Update the score text
                scoreTxt.text = FlxG.score.toString();
            }
            else if (gameState == GameStates.DEATH_OVER)
            {
                restart();
            }

            // Update the entire game
            super.update();
        }

        /**
         * This is called when time runs out.
         */
        private function timeUp():void
        {
            if (gameState != GameStates.COLLISION)
            {
                FlxG.play(GameAssets.FroggerSquashSound);
                killPlayer();
            }
        }

        /**
         * This is called when the player dies in water.
         */
        private function waterCollision():void
        {
            if (gameState != GameStates.COLLISION)
            {
                FlxG.play(GameAssets.FroggerPlunkSound);
                killPlayer();
            }
        }

        /**
         * This handles collision with a car.
         * @param target this instance that has collided with the player
         * @param player a reference to the player
         */
        private function carCollision(target:FlxSprite, player:Frog):void
        {
            if (gameState != GameStates.COLLISION)
            {
                FlxG.play(GameAssets.FroggerSquashSound);
                killPlayer();
            }
        }

        /**
         * This handles collision with a home base.
         * @param target this instance that has collided with the player
         * @param player a reference to the player
         */
        private function baseCollision(target:Home, player:Frog):void
        {
            // Check to make sure that we have not landed in a occupied base
            if (target.mode != Home.SUCCESS)
            {
                // Increment number of frogs saved
                safeFrogs ++;

                // Flag the target as success to show it is occupied now
                target.success();

                var timeLeftOver:int = Math.round(timer / FlxG.framerate);

                //TODO This needs some kind of animation
                // Increment the score based on the time left
                FlxG.score += timeLeftOver * ScoreValues.TIME_BONUS;

            }
            else
            {
                //TODO need to add something to indicate that a base was occupied
            }

            // Reguardless if the base was empty or occupied we still display the time it took to get there
            messageText.text = "TIME " + String(gameTime / FlxG.framerate - timeLeftOver);
            gameMessageGroup.visible = true;
            hideGameMessageDelay = 200;

            // Test to see if we have all the frogs, if so then level has been completed. If not restart.
            if (safeFrogs == bases.length)
            {
                levelComplete();
            }
            else
            {
                restart();
            }

        }

        /**
         * This is called when a level is completed
         */
        private function levelComplete():void
        {

            //Increment the score based on
            FlxG.score += ScoreValues.FINISH_LEVEL;

            // Change game state to let system know a level has been completed
            gameState = GameStates.LEVEL_OVER;

            // Hide the player since the level is over and wait for the game to restart itself
            player.visible = false;
        }

        /**
         * This is called when a player is on a log to indicate the frog needs to float
         * @param target this is the instance that collided with the player
         * @param player an instance of the player
         */
        private function turtleFloat(target:TimerSprite, player:Frog):void
        {
            // Test to see if the target is active. If it is active the player can float. If not the player
            // is in the water 
            if (target.isActive)
            {
                float(target, player);
            }
            else if (!player.isMoving)
            {
                waterCollision();
            }
        }

        /**
         * This handles floating the player sprite with the target it is on.
         * @param target this is the instance that collided with the player
         * @param player an instance of the player
         */
        private function float(target:WrappingSprite, player:Frog):void
        {
            playerIsFloating = true;

            if (!(FlxG.keys.LEFT || FlxG.keys.RIGHT))
            {
                player.float(target.speed, target.facing);
            }
        }

        /**
         * This handles resetting game values when a frog dies, or a level is completed.
         */
        private function restart():void
        {
            // Make sure the player still has lives to restart
            if (totalLives == 0 && gameState != GameStates.GAME_OVER)
            {
                gameOver();
            }
            else
            {
                // Test to see if Level is over, if so reset all the bases.
                if (gameState == GameStates.LEVEL_OVER)
                    resetBases();

                // Change game state to Playing so animation can continue.
                gameState = GameStates.PLAYING;
                timer = gameTime;
                player.restart();
                timeAlmostOverFlag = false;
            }
        }

        /**
         * This loops through the bases and makes sure they are set to empty.
         */
        private function resetBases():void
        {
            // Loop though bases and empty them
            for each (var base:Home in bases)
            {
                trace("base", base);
                base.empty();
            }

            // Reset safe frogs
            safeFrogs = 0;

            // Set message to tell player they can restart
            messageText.text = "START";
            gameMessageGroup.visible = true;
            hideGameMessageDelay = 200;
        }

        /**
         * This kills the player. Game state is set to collision so everything knows to pause and a life is removed.
         */
        private function killPlayer():void
        {
            gameState = GameStates.COLLISION;
            removeLife();
            player.death();
        }

        /**
         * This is called when a game is over. A message is shown and the game locks down until it is ready to go
         * back to the start screen
         */
        private function gameOver():void
        {
            gameState = GameStates.GAME_OVER;

            gameMessageGroup.visible = true;

            messageText.text = "GAME OVER";

            hideGameMessageDelay = 100;

            //TODO there is a Game Over sound I need to play here
        }

        /**
         * This loop creates X number of lives.
         * @param value number of lives to create
         */
        private function createLives(value:int):void
        {
            var i:int;

            for (i = 0; i < value; i++)
            {
                addLife();
            }
        }

        /**
         * This adds a life sprite to the display and pushes it to teh lifeSprites array.
         * @param value
         */
        private function addLife():void
        {
            var flxLife:FlxSprite = new FlxSprite(LIFE_X * totalLives, LIFE_Y, GameAssets.LivesSprite);
            add(flxLife);
            lifeSprites.push(flxLife);
        }

        /**
         * This removes the life sprite from the display and from the lifeSprites array as well.
         * @param value
         */
        private function removeLife():void
        {
            var id:int = totalLives - 1;
            var sprite:FlxSprite = lifeSprites[id];
            sprite.kill();
            lifeSprites.splice(id, 1);
        }

        /**
         * A simple getter for Total Lives based on life sprite instances in lifeSprites array.
         * @return
         */
        private function get totalLives():int
        {
            return lifeSprites.length;
        }
    }
}
