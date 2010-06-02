package
{
    public class Car extends WrappingSprite
    {

        [Embed(source="../build/assets/car_sprites.png")]
        private var SpriteImage:Class;

        public static const SPRITE_WIDTH:uint = 40;
        public static const SPRITE_HEIGHT:uint = 40;

        public static const TYPE_A:uint = 0;
        public static const TYPE_B:uint = 1;
        public static const TYPE_C:uint = 2;
        public static const TYPE_D:uint = 3;

        public function Car(x:Number, y:Number, type:uint, direction:int, velocity:int)
        {
            super(x, y, null, direction, velocity);

            loadGraphic(SpriteImage, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);

            frame = type;
        }
    }
}