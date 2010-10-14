/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 10/14/10
 * Time: 8:03 AM
 * To change this template use File | Settings | File Templates.
 */
package com.flashartofwar.frogger.states
{
    import com.flashartofwar.frogger.scores.FroggerScoreboard;

    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class BaseState extends FlxState
    {
        protected var scoreboard:FroggerScoreboard;
        protected var scoreTxt:FlxText;

        public function BaseState()
        {
            super();
        }

        override public function create():void
        {
            super.create();

            scoreboard = new FroggerScoreboard();

            var sprite:FlxSprite = new FlxSprite();
            sprite.createGraphic(FlxG.width, 350, 0xff000047);
            add(sprite);

            // Create Text for title, credits, and score

            var demoTXT:FlxText = add(new FlxText((FlxG.width - 200) * .5, 0, 200, "HI-SCORE").setFormat(null, 14, 0xffffff, "center")) as FlxText;
            var highScore:FlxText = add(new FlxText(demoTXT.x, demoTXT.y + demoTXT.height, 200, scoreboard.getScore(0).score).setFormat(null, 14, 0xffe00000, "center")) as FlxText;
            var scoreLabel:FlxText = add(new FlxText(demoTXT.x - 100, 0, 100, "Score").setFormat(null, 14, 0xffffff, "right")) as FlxText;
            scoreTxt = add(new FlxText(scoreLabel.x - 50, scoreLabel.height, 150, FlxG.score.toString()).setFormat(null, 14, 0xffe00000, "right")) as FlxText;
        }

    }
}
