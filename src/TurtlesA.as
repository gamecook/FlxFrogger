package {
public class TurtlesA extends TimerSprite {

    //65
    //34
    [Embed(source="data/turtle_2_sprites.png")]
    private var SpriteImage:Class;

    public static const SPRITE_WIDTH:int = 65;
    public static const SPRITE_HEIGHT:int = 40;
    public static const DEFAULT_TIME:int = 300;

    public function TurtlesA(x:Number, y:Number, hideTimer:int = DEFAULT_TIME, startTime:int = DEFAULT_TIME, dir:uint = RIGHT, velocity:int = 40) {
        super(x, y, null, hideTimer, startTime, dir, velocity);

        loadGraphic(SpriteImage, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);

        addAnimation("idle", [0], 0, false);
        addAnimation("hide", [1, 2, 3], 3, false);
        addAnimation("show", [3, 2, 1, 0], 3, false);
    }

    override protected function onActivate():void {
        play("show");
    }

    override protected function onDeactivate():void {
        play("hide");
    }
}
}