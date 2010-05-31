package {
public class TurtlesB extends TurtlesA {

    [Embed(source="data/turtle_3_sprites.png")]
    private var SpriteImage:Class;

    public static const SPRITE_WIDTH:int = 99;
    public static const SPRITE_HEIGHT:int = 40;
    public static const DEFAULT_TIME:int = 300;

    public function TurtlesB(x:Number, y:Number, hideTimer:int = DEFAULT_TIME, startTime:int = DEFAULT_TIME, dir:uint = RIGHT, velocity:int = 40) {
        super(x, y, hideTimer, startTime, dir, velocity);

        loadGraphic(SpriteImage, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);

    }

}
}