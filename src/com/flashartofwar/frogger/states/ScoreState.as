/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 10/13/10
 * Time: 10:29 PM
 * To change this template use File | Settings | File Templates.
 */
package com.flashartofwar.frogger.states
{
    import com.flashartofwar.frogger.enum.FroggerScoreboard;

    import com.gamecook.scores.FScoreboard;

    import org.flixel.FlxG;
    import org.flixel.FlxSave;
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class ScoreState extends FlxState
    {
       // public var cfg:Class = MeasuresConfig;

        private var over:FlxText;
        private var saved:FlxSave;
        private var scores:Array;
        private var highScored:Boolean = false;
        private var newScore:Object;
        private var newScorePosition:Number = -1;

        private var whichInitial:Number=0;//the index of the initial being input, 0 through 2
        private var whichLetter:Number=0;//what the current letter is, 0 through 26

        private var leftArrow:FlxText, rightArrow:FlxText, upArrow:FlxText, downArrow:FlxText;

        //private var newScoreInitials:FlxText;
        private var newInitials:Array;
        private var scoreBoard:FScoreboard;


        override public function create():void
        {
            FlxG.mouse.show();


            scoreBoard = new FScoreboard(FroggerScoreboard.ID, FroggerScoreboard.MAX_SCORES);

            //TODO need to remove this is just for testing
            //scoreBoard.clearScoreboard();


            var defaultScores:Array = [
                /*{initials:"GLC", score: 860630},
                {initials:"FLA", score: 10000},
                {initials:"SWF", score: 5000},
                {initials:"AS3", score: 1500},
                {initials:"AIR", score: 1000},
                {initials:"APK", score: 880}*/
                    {initials:"GLC", score: 1000},
                {initials:"FLA", score: 100},
                {initials:"SWF", score: 50},
                {initials:"AS3", score: 30},
                {initials:"AIR", score: 20},
                {initials:"APK", score: 10}
                ];

            if(scoreBoard.total == 0)
                scoreBoard.scores = defaultScores;



            scores = scoreBoard.scores;

            var score:Object;

             newInitials = [];

            highScored = scoreBoard.canSubmitScore(playerScore);

            var playerScore:int = FlxG.score;
            var xpos:Number;
            var i:int;
            var totalScores:int = FroggerScoreboard.MAX_SCORES;

            //find out if score can be inserted at the beginning
            if (!scores[0])
            {
                score = {score:FlxG.score, initials:""};
                scores.push(score);
                newScore = score;
                highScored = true;
                newScorePosition = 0;
            }
            //first loop: find out if score can be inserted in middle
            for (i = 0; i < totalScores; i++)
            {
                score = scores[i];
                if (highScored)
                    break;
                else if (score.score <= FlxG.score)
                {
                    score = {score:FlxG.score, initials:""};
                    newScorePosition = i;
                    scores.splice(i, 0, score);
                    if (totalScores > 10)
                        scores.pop();
                    highScored = true;
                    newScore = score;
                    break;
                }
            }

            //find out if score can be inserted at end
            if (!highScored && totalScores < 10)
            {
                score = {score:FlxG.score, initials:""};
                scores.push(score);
                newScorePosition = totalScores -1;
                highScored = true;
                newScore = score;
            }



            //second loop lay out the current high scores.
            for (i=0; i < totalScores; i++)
            {
                var scoreObj:Object = scores[i];
                //display the current score.
                ypos = 50 +i*15;
                //index
                textItem = new FlxText(100, ypos, 25, (i+1).toString());
                textItem.setFormat(null, 15, 0x2492ff,"left",0);
                add(textItem);

                //initials - loop to position each separately.
                for (var j:Number = 0; j < 3; j++)
                {
                    xpos = 125 + j * 15;
                    textItem = new FlxText(xpos, ypos, 15, scoreObj.initials.charAt(j));
                    //new high score text gets colored red.
                    if (i == newScorePosition)
                    {
                        textItem.setFormat(null, 15, 0xFF0000,"center",0);
                        newInitials.push(textItem);
                    }
                    else
                        textItem.setFormat(null, 15, 0x2492ff,"center",0);
                    add(textItem);
                }

                //score
                textItem = new FlxText(200, ypos, 100, scoreObj.score.toString());
                textItem.setFormat(null, 15, 0x2492ff,"right",0);
                add(textItem);
            }


            if(scoreBoard.canSubmitScore(playerScore))
            {
                var textItem:FlxText;
                var ypos:Number;


                textItem = new FlxText(0, FlxG.height / 20, FlxG.width, "SCORE RANKING");
                textItem.setFormat(null, 15, 0xFF0000, "center",0);
                add(textItem);

                //positioning line for the two lower pieces of text
                var bottomLine:Number = 15 * 9 + 50 + 15;
                var hLowLine:Number = Math.round(bottomLine + (FlxG.height - bottomLine) / 2);

                textItem = new FlxText(0, hLowLine - 15, FlxG.width, "ENTER YOUR INITIALS");
                textItem.setFormat(null, 15, 0xFF0000, "center",0);
                add(textItem);

                textItem = new FlxText(0, hLowLine + 1, FlxG.width, "USE JOYSTICK TO SELECT LETTER");
                textItem.setFormat(null, 15, 0xFF0000, "center",0);
                add(textItem);

                var newItemPos:Number = 50 + newScorePosition* 15;


                //add in arrows for displaying position and possible motions
                leftArrow = new FlxText(newInitials[0].left - 15, newInitials[0].y, 15, " ");
                leftArrow.setFormat(null, 15, 0xFF0000, "left", 0);
                add(leftArrow);

                rightArrow = new FlxText(newInitials[2].right, newInitials[0].y, 15, " ");
                rightArrow.setFormat(null, 15, 0xFF0000, "right", 0);
                add(rightArrow);

                upArrow = new FlxText(newInitials[0].left, newInitials[0].y - 15, 15, "+");
                upArrow.setFormat(null, 15, 0xFF0000, "center", 0);
                add(upArrow);

                downArrow = new FlxText(newInitials[0].left, newInitials[0].y + 15, 15, "-")
                downArrow.setFormat(null, 15, 0xFF0000, "center", 0);
                add(downArrow);

            }
        }

        override public function update():void
        {
            if (highScored)
            {
                var str:String = newScore.initials;

                var clkX:Number = FlxG.mouse.x;
                var clkY:Number = FlxG.mouse.y;

                //figure out what motion needs to be done
                var letterUp:Boolean = FlxG.keys.justPressed("UP") ||
                    (FlxG.mouse.justPressed() && clkY < newInitials[0].top && clkX > newInitials[0].left && clkX < newInitials[2].right);

                var letterDown:Boolean = FlxG.keys.justPressed("DOWN") ||
                    (FlxG.mouse.justPressed() && clkY > newInitials[0].bottom && clkX > newInitials[0].left && clkX < newInitials[2].right);

                var letterLeft:Boolean = whichInitial > 0 && (FlxG.keys.justPressed("LEFT") ||
                        (FlxG.mouse.justPressed() && clkX < newInitials[0].left));

                var letterRight:Boolean = whichInitial < 2 && (FlxG.keys.justPressed("RIGHT") || FlxG.keys.justPressed("SPACE") ||
                        (FlxG.mouse.justPressed() && clkX > newInitials[2].right));

                var doneEdit:Boolean = whichInitial == 2 && (FlxG.keys.justPressed("SPACE") ||
                        (FlxG.mouse.justPressed() && clkX > newInitials[2].right));

                //perform said motions
                if (letterUp)
                    whichLetter = (whichLetter + 26) % 27;
                else if (letterDown)
                    whichLetter = (whichLetter + 1) % 27;
                else if (letterLeft)
                {
                    whichInitial--;
                    whichLetter = str.charCodeAt(whichInitial) - 64;
                    if (whichLetter < 0)
                        whichLetter = 0;
                }
                else if (letterRight)
                {
                    whichInitial++;
                    whichLetter = str.charCodeAt(whichInitial) - 64;
                    if (whichLetter < 0)
                        whichLetter = 0;
                }
                else if (doneEdit)
                {
                    scoreBoard.scores = scores;
                    FlxG.state = new StartState();
                }

                //update the arrows.
                leftArrow.text = "<";
                rightArrow.text = ">";

                if (whichInitial == 0)
                    leftArrow.text = " ";
                else if (whichInitial == 2)
                    rightArrow.text = "/";

                upArrow.x = newInitials[whichInitial].left;
                downArrow.x = upArrow.x;


                //update the string.
                var arr:Array = new Array();
                for (var i:Number = 0; i < 3; i++)
                {
                    if (i >= str.length)
                        arr[i] = 32;
                    else
                        arr[i] = str.charCodeAt(i);
                }
                if (whichLetter == 0)
                    arr[whichInitial] = 32; //space
                else
                    arr[whichInitial] = 64+whichLetter; //some uppercase letter

                str = String.fromCharCode(arr[0], arr[1], arr[2]);
                newScore.initials = str; //store the string
                for (i = 0; i < 3; i++) //update the display
                    newInitials[i].text = str.charAt(i);

            }
            else if (FlxG.keys.justPressed("SPACE") || FlxG.mouse.justPressed()) //no new highscore.
            {
                scoreBoard.scores = scores;
                FlxG.state = new StartState();

            }
            super.update();
        }


    }
}
