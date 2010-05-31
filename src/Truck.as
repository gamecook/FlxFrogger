package {
public class Truck extends WrappingSprite {

    [Embed(source="data/truck.png")] private var ImgPusher:Class;

    public function Truck(x:Number, y:Number, direction:uint, velocity:int) {
        super(x, y, ImgPusher, direction, velocity);
    }
}
}