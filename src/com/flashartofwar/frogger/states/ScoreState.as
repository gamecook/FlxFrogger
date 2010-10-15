/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 10/13/10
 * Time: 10:29 PM
 * To change this template use File | Settings | File Templates.
 */
package com.flashartofwar.frogger.states
{
    import com.flashartofwar.frogger.scores.FroggerScoreboard;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import org.flixel.FlxG;
    import org.flixel.FlxText;

    public class ScoreState extends BaseState
    {

        private var scores:Array;
        private var highScored:Boolean = false;
        private var newScore:Object;
        private var newScorePosition:Number = -1;

        private var whichInitial:Number = 0;//the index of the initial being input, 0 through 2
        private var whichLetter:Number = 1;//what the current letter is, 0 through 26

        private var leftArrow:FlxText, rightArrow:FlxText, upArrow:FlxText, downArrow:FlxText;

        private var newInitials:Array;
        private var letterPreview:FlxText;
        private var timer:Timer;

        override public function create():void
        {
            super.create();

            //FlxG.mouse.show();

            scores = scoreboard.scores;

            var score:Object;

            newInitials = [];

            highScored = scoreboard.canSubmitScore(playerScore);

            textItem = new FlxText(0, FlxG.height / 6, FlxG.width, "SCORE RANKING");
            textItem.setFormat(null, 15, 0xd8d94a, "center", 0);
            add(textItem);

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
                    break; else if (score.score <= FlxG.score)
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
            if (!highScored && totalScores < 5)
            {
                score = {score:FlxG.score, initials:""};
                scores.push(score);
                newScorePosition = totalScores - 1;
                highScored = true;
                newScore = score;
            }

            var ypos:int = textItem.bottom + 20;

            //second loop lay out the current high scores.
            for (i = 0; i < totalScores; i++)
            {
                var scoreObj:Object = scores[i];
                //display the current score.
                //index

                var color:uint = (i == newScorePosition) ? 0xc83fbb : 0xffffff

                textItem = new FlxText(140, ypos, 25, (i + 1).toString());
                textItem.setFormat(null, 15, color, "left", 0);
                add(textItem);

                xpos = textItem.left + 30;

                //initials - loop to position each separately.
                for (var j:Number = 0; j < 3; j++)
                {

                    textItem = new FlxText(xpos, ypos, 15, scoreObj.initials.charAt(j));
                    //new high score text gets colored red.
                    if (i == newScorePosition)
                    {
                        textItem.setFormat(null, 15, color, "center", 0);
                        newInitials.push(textItem);
                    } else
                        textItem.setFormat(null, 15, color, "center", 0);
                    add(textItem);

                    xpos += 20;
                }

                //score
                textItem = new FlxText(xpos, ypos, 100, scoreObj.score.toString());
                textItem.setFormat(null, 15, color, "right", 0);
                add(textItem);

                ypos += 20;

            }


            if (highScored)
            {
                var textItem:FlxText;


                letterPreview = new FlxText((FlxG.width - 100 ) * .5, 500, 100, "_");
                letterPreview.setFormat(null, 70, 0xc83fbb, "center", 0);
                add(letterPreview);

                //add in arrows for displaying position and possible motions
                leftArrow = new FlxText(letterPreview.left - 50, letterPreview.y + 10, 50, " ");
                leftArrow.setFormat(null, 60, 0xc83fbb, "right", 0);
                add(leftArrow);

                rightArrow = new FlxText(letterPreview.right, letterPreview.y + 10, 200, " ");
                rightArrow.setFormat(null, 60, 0xc83fbb, "left", 0);
                add(rightArrow);

                upArrow = new FlxText(letterPreview.left, letterPreview.top - 60, 100, "+");
                upArrow.setFormat(null, 60, 0xc83fbb, "center", 0);
                add(upArrow);

                downArrow = new FlxText(letterPreview.left, letterPreview.bottom - 30, 100, "-")
                downArrow.setFormat(null, 60, 0xc83fbb, "center", 0);
                add(downArrow);


                textItem = new FlxText(0, upArrow.top - 30, FlxG.width, "ENTER YOUR INITIALS");
                textItem.setFormat(null, 15, 0xc83fbb, "center", 0);
                add(textItem);

                textItem = new FlxText(0, downArrow.bottom, FlxG.width, "USE JOYSTICK TO SELECT LETTER");
                textItem.setFormat(null, 15, 0xc83fbb, "center", 0);
                add(textItem);

            } else
            {
                timer = new Timer(6000, 1);
                timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
                timer.start();
            }
        }

        private function onTimerComplete(event:TimerEvent):void
        {
            FlxG.state = new StartState();
        }

        override public function update():void
        {
            if (highScored)
            {
                var str:String = newScore.initials;

                var clkX:Number = FlxG.mouse.x;
                var clkY:Number = FlxG.mouse.y;

                //figure out what motion needs to be done
                var letterUp:Boolean = FlxG.keys.justPressed("UP") || (FlxG.mouse.justPressed() && clkY < letterPreview.top && clkX > letterPreview.left && clkX < letterPreview.right);

                var letterDown:Boolean = FlxG.keys.justPressed("DOWN") || (FlxG.mouse.justPressed() && clkY > letterPreview.bottom && clkX > letterPreview.left && clkX < letterPreview.right);

                var letterLeft:Boolean = whichInitial > 0 && (FlxG.keys.justPressed("LEFT") || (FlxG.mouse.justPressed() && clkX < letterPreview.left));

                var letterRight:Boolean = whichInitial < 2 && (FlxG.keys.justPressed("RIGHT") || FlxG.keys.justPressed("ENTER") || (FlxG.mouse.justPressed() && clkX > letterPreview.right));

                var doneEdit:Boolean = whichInitial == 2 && (FlxG.keys.justPressed("ENTER") || (FlxG.mouse.justPressed() && clkX > letterPreview.right));

                //perform said motions
                if (letterUp)
                    whichLetter = (whichLetter + 1) % 27; else if (letterDown)
                    whichLetter = (whichLetter + 26) % 27; else if (letterLeft)
                {
                    whichInitial--;
                    whichLetter = str.charCodeAt(whichInitial) - 64;
                    if (whichLetter < 0)
                        whichLetter = 1;
                } else if (letterRight)
                {
                    whichInitial++;
                    whichLetter = str.charCodeAt(whichInitial) - 64;
                    if (whichLetter < 0)
                        whichLetter = 1;
                } else if (doneEdit)
                {
                    scoreboard.scores = scores;
                    FlxG.state = new StartState();
                }

                //update the arrows.
                leftArrow.text = "<";
                rightArrow.text = ">";

                if (whichInitial == 0)
                    leftArrow.text = " "; else if (whichInitial == 2)
                    rightArrow.text = "OK";

                //update the string.
                var arr:Array = new Array();
                for (var i:Number = 0; i < 3; i++)
                {
                    if (i >= str.length)
                        arr[i] = 32; else
                        arr[i] = str.charCodeAt(i);
                }
                if (whichLetter == 0)
                    arr[whichInitial] = 32; //space
                else
                    arr[whichInitial] = 64 + whichLetter; //some uppercase letter

                str = String.fromCharCode(arr[0], arr[1], arr[2]);
                newScore.initials = str; //store the string
                for (i = 0; i < 3; i++)
                {
                    //update the display
                    newInitials[i].text = str.charAt(i);
                }

                //letterPreview.text = String.fromCharCode(arr[whichInitial]);
                letterPreview.text = String.fromCharCode(arr[whichInitial]);
            } else if (FlxG.keys.justPressed("ENTER") || FlxG.mouse.justPressed()) //no new highscore.
            {
                if (timer)
                    timer.stop();

                scoreboard.scores = scores;
                FlxG.state = new StartState();

            }
            super.update();
        }


    }
}
