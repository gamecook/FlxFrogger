/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 10/14/10
 * Time: 8:04 AM
 * To change this template use File | Settings | File Templates.
 */
package com.flashartofwar.frogger.scores
{
    import com.gamecook.scores.FScoreboard;

    public class FroggerScoreboard extends FScoreboard
    {
        public static const ID:String = "FlxFroggerScoreboard"
        public static const MAX_SCORES:int = 5;

        public function FroggerScoreboard()
        {
            super(ID, MAX_SCORES);

            //TODO need to remove this is just for testing
            clearScoreboard();

            if(total == 0)
            {
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

                scores = defaultScores;
            }

        }
    }
}
