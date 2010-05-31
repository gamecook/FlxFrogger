package {
import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxU;

public class PlayState extends FlxState {

    [Embed(source="data/background.png")]
    private var LevelBG:Class;

    public static const WELCOME_STATE:uint = 0;
    public static const PLAYING_STATE:uint = 1;
    public static const COLLISION_STATE:uint = 2;
    public static const RESTART_STATE:uint = 3;
    public static const GAME_OVER_STATE:uint = 4;
    public static const DEATH_OVER:uint = 5;

    public var collision:Boolean;
    public var gameState:uint;

    private const TILE_SIZE:int = 40;

    private var _player:Frog;
    private var logGroup:FlxGroup;
    private var carGroup:FlxGroup;
    private var lives:Number;
    private var turtleGroup:FlxGroup;
    private var timerBar:FlxSprite;
    private var gameTime:int = 2500;
    private var timer:int;

    override public function create():void {
        FlxG.showBounds = true;

        timer = gameTime;

        var bg:FlxSprite = new FlxSprite(0, 0, LevelBG);
        add(bg);

        add(new FlxText(0, 0, 100, "FlxFrogger Demo"));

        lives = 3;

        // Goals

        // Create Logs

        logGroup = new FlxGroup();
        turtleGroup = new FlxGroup();

        logGroup.add(new Log(0, TILE_SIZE * 2, Log.TypeC, FlxSprite.RIGHT, 40));
        logGroup.add(new Log(Log.TypeCWidth + 77, TILE_SIZE * 2, Log.TypeC, FlxSprite.RIGHT, 40));
        logGroup.add(new Log((Log.TypeCWidth + 77) * 2, TILE_SIZE * 2, Log.TypeC, FlxSprite.RIGHT, 40));

        turtleGroup.add(new TurtlesA(0, TILE_SIZE * 3, -1, -1, FlxSprite.LEFT, 40));
        turtleGroup.add(new TurtlesA((TurtlesA.SPRITE_WIDTH + 123) * 1, TILE_SIZE * 3, TurtlesA.DEFAULT_TIME, 200, FlxSprite.LEFT, 40));
        turtleGroup.add(new TurtlesA((TurtlesA.SPRITE_WIDTH + 123) * 2, TILE_SIZE * 3, -1, -1, FlxSprite.LEFT, 40));

        logGroup.add(new Log(0, TILE_SIZE * 4, Log.TypeB, FlxSprite.RIGHT, 40));
        logGroup.add(new Log(Log.TypeBWidth + 70, TILE_SIZE * 4, Log.TypeB, FlxSprite.RIGHT, 40));

        logGroup.add(new Log(0, TILE_SIZE * 5, Log.TypeA, FlxSprite.RIGHT, 40));
        logGroup.add(new Log(Log.TypeAWidth + 77, TILE_SIZE * 5, Log.TypeA, FlxSprite.RIGHT, 40));
        logGroup.add(new Log((Log.TypeAWidth + 77) * 2, TILE_SIZE * 5, Log.TypeA, FlxSprite.RIGHT, 40));

        turtleGroup.add(new TurtlesB(0, TILE_SIZE * 6, TurtlesA.DEFAULT_TIME, 0, FlxSprite.LEFT, 40));
        turtleGroup.add(new TurtlesB((TurtlesB.SPRITE_WIDTH + 95) * 1, TILE_SIZE * 6, -1, -1, FlxSprite.LEFT, 40));
        turtleGroup.add(new TurtlesB((TurtlesB.SPRITE_WIDTH + 95) * 2, TILE_SIZE * 6, -1, -1, FlxSprite.LEFT, 40));


        add(logGroup);
        add(turtleGroup);

        _player = add(new Frog(TILE_SIZE * 1, TILE_SIZE * 13 + 2)) as Frog;

        // Cars
        carGroup = new FlxGroup();

        carGroup.add(new Truck(0, TILE_SIZE * 8, FlxSprite.LEFT, 40));
        carGroup.add(new Truck(270, TILE_SIZE * 8, FlxSprite.LEFT, 40));

        carGroup.add(new Car(0, TILE_SIZE * 9, Car.TYPE_C, FlxSprite.RIGHT, 40));
        carGroup.add(new Car(270, TILE_SIZE * 9, Car.TYPE_C, FlxSprite.RIGHT, 40));

        carGroup.add(new Car(0, TILE_SIZE * 10, Car.TYPE_D, FlxSprite.LEFT, 40));
        carGroup.add(new Car(270, TILE_SIZE * 10, Car.TYPE_D, FlxSprite.LEFT, 40));


        carGroup.add(new Car(0, TILE_SIZE * 11, Car.TYPE_B, FlxSprite.RIGHT, 40));
        carGroup.add(new Car((Car.SPRITE_WIDTH + 138) * 1, TILE_SIZE * 11, Car.TYPE_B, FlxSprite.RIGHT, 40));
        carGroup.add(new Car((Car.SPRITE_WIDTH + 138) * 2, TILE_SIZE * 11, Car.TYPE_B, FlxSprite.RIGHT, 40));

        carGroup.add(new Car(0, TILE_SIZE * 12, Car.TYPE_A, FlxSprite.LEFT, 40));
        carGroup.add(new Car((Car.SPRITE_WIDTH + 138) * 1, TILE_SIZE * 12, Car.TYPE_A, FlxSprite.LEFT, 40));
        carGroup.add(new Car((Car.SPRITE_WIDTH + 138) * 2, TILE_SIZE * 12, Car.TYPE_A, FlxSprite.LEFT, 40));

        add(carGroup);

        gameState = PLAYING_STATE;

        timerBar = new FlxSprite(480, bg.height + 20);
        timerBar.createGraphic(1, 16, 0xff21de00);
        timerBar.scrollFactor.x = timerBar.scrollFactor.y = 0;
        timerBar.origin.x = timerBar.origin.y = 0;
        timerBar.scale.x = -300;
        add(timerBar);

    }

    override public function update():void {

        timer -= FlxG.elapsed;

        timerBar.scale.x = Math.round(-(timer / gameTime * 300));

        if (timer == 0) {

            killPlayer();
        }
        //Updates all the objects appropriately
        super.update();

        if (gameState == DEATH_OVER) {
            restart();
        }
        else {
            FlxU.overlap(carGroup, _player, death);
            FlxU.overlap(logGroup, _player, float);
            FlxU.overlap(turtleGroup, _player, float);

            if (_player.x < 0 || _player.x > (FlxG.width - _player.frameWidth)) {
                gameState = COLLISION_STATE;

                _player.death();
            }
        }

    }

    private function float(Collision:WrappingSprite, Player:Frog):void {

        if (!(FlxG.keys.LEFT || FlxG.keys.RIGHT)) {
            //Player.velocity.x = Collision.velocity.x;
        }
    }

    private function restart():void {


        _player.restart();
        timer = gameTime;
        PlayState(FlxG.state).gameState = PlayState.PLAYING_STATE;

    }

    public function death(Collision:FlxSprite, Player:Frog):void {
        killPlayer();
    }

    private function killPlayer():void {

        gameState = COLLISION_STATE;

        _player.death();

        lives --;

        if (lives == 0) {
            gameOver();
        }
    }

    private function gameOver():void {

    }
}
}