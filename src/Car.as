package {
public class Car extends WrappingSprite {

    [Embed(source="data/car_sprites.png")] private var ImgCars:Class;

    public static const SPRITE_WIDTH:uint = 35;
    public static const SPRITE_HEIGHT:uint = 35;

    public static const TYPE_A:uint = 0;
    public static const TYPE_B:uint = 1;
    public static const TYPE_C:uint = 2;
    public static const TYPE_D:uint = 3;
    
    public function Car(x:Number, y:Number, type:uint, direction:int, velocity:int) {
        super(x, y, null, direction, velocity);
        
        loadGraphic(ImgCars, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);

        frame = type;
    }
}
}