package {
import flash.net.getClassByAlias;

public class Log extends WrappingSprite {

    [Embed(source="data/tree_1.png")] private var Log0:Class;
    [Embed(source="data/tree_2.png")] private var Log1:Class;
    [Embed(source="data/tree_3.png")] private var Log2:Class;

    public static const TypeA:uint = 0;
    public static const TypeB:uint = 1;
    public static const TypeC:uint = 2;

    public static const TypeAWidth:uint = 95;
    public static const TypeBWidth:uint = 196;
    public static const TypeCWidth:uint = 127;

    public function Log(x:Number, y:Number, type:uint, dir:uint,  velocity:uint) {

        var graphicClass:Class;

        switch (type)
        {
            case TypeA:
                graphicClass = Log0;
            break;
            case TypeB:
                graphicClass = Log1;
            break;
            case TypeC:
                graphicClass = Log2;
            break;
        }

        super(x, y, graphicClass, dir, velocity );

    }
}
}