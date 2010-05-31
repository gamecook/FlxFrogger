package {
public class Alligator extends WrappingSprite {

    [Embed(source="data/alligator_sprites.png")]
    private var SpriteImage:Class;

    public static const SPRITE_WIDTH:int = 102;
    public static const SPRITE_HEIGHT:int = 40;
    public static const VELOCITY:int = 40;

    public function Alligator(X:Number, Y:Number, dir:uint, velocity:int) {

        super(X, Y, null, dir, velocity);

        loadGraphic(SpriteImage, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);

        addAnimation("idle", [0,1], 1, true);

        play("idle");
    }


}
}