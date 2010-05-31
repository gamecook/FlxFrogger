package
{
    public class Log extends WrappingSprite
    {

        [Embed(source="data/tree_1.png")]
        private var SpriteImage1:Class;
        [Embed(source="data/tree_2.png")]
        private var SpriteImage2:Class;
        [Embed(source="data/tree_3.png")]
        private var SpriteImage3:Class;

        public static const TypeA:uint = 0;
        public static const TypeB:uint = 1;
        public static const TypeC:uint = 2;

        public static const TypeAWidth:uint = 95;
        public static const TypeBWidth:uint = 196;
        public static const TypeCWidth:uint = 127;

        public function Log(x:Number, y:Number, type:uint, dir:uint, velocity:uint)
        {

            var graphicClass:Class;

            switch (type)
            {
                case TypeA:
                    graphicClass = SpriteImage1;
                    break;
                case TypeB:
                    graphicClass = SpriteImage2;
                    break;
                case TypeC:
                    graphicClass = SpriteImage3;
                    break;
            }

            super(x, y, graphicClass, dir, velocity);

        }
    }
}