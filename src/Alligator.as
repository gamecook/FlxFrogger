package {
import org.flixel.FlxSprite;

public class Alligator extends WrappingSprite {

    [Embed(source="data/alligator_sprites.png")] private var ImgPusher:Class;

    public static const SPRITE_WIDTH:int= 102;
    public static const SPRITE_HEIGHT:int = 41;
    public static const VELOCITY:int = 40;

    public function Alligator(X:Number, Y:Number, dir:uint, velocity:int) {
        super(X, Y, null, dir, velocity);

        fixed = true;		//We want the pusher to be "solid" and not shift during collisions
        
        loadGraphic(ImgPusher, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
        
        addAnimation("idle", [0,1], 1, true);

        play("idle");
    }

    
}
}