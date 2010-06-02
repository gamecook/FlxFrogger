package
{
    public class Truck extends WrappingSprite
    {

        [Embed(source="../build/assets/truck.png")]
        private var SpriteImage:Class;

        public function Truck(x:Number, y:Number, direction:uint, velocity:int)
        {
            super(x, y, SpriteImage, direction, velocity);
        }
    }
}