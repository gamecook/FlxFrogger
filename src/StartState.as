package
{
    import flash.events.MouseEvent;

    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class StartState extends FlxState
    {
        [Embed(source="../build/assets/frogger_title.gif")]
        private var TitleSprite:Class;

        [Embed(source="../build/assets/frogger_sounds.swf", symbol="FroggerThemeSound")]
        private static var FroggerThemeSound: Class;

        public function StartState()
        {
            super();
        }

        override public function create():void
        {
            var sprite:FlxSprite = new FlxSprite();
            sprite.createGraphic(FlxG.width, FlxG.height/2,0xff000047);
            add(sprite);

            stage.addEventListener(MouseEvent.CLICK, onClick);

            var title:FlxSprite = new FlxSprite(0,100, TitleSprite);
            title.x = (FlxG.width * .5) - (title.width * .5);
            add(title);
            
            add(new FlxText(0,200,FlxG.width, "PUSH").setFormat(null, 18, 0xffffffff, "center"));
            add(new FlxText(0,300,FlxG.width, "ANYWHERE TO START").setFormat(null, 18, 0xd33bd1, "center"));
            //add(new FlxText(0,400,FlxG.width, "ANYWHERE TO START").setFormat(null, 18, 0xffffffff, "center"));

        }

        private function onClick(event:MouseEvent):void
        {

            FlxG.state = new PlayState();
            FlxG.play(FroggerThemeSound);
                       
        }

        override public function destroy():void
        {
            stage.removeEventListener(MouseEvent.CLICK, onClick);
            super.destroy();
        }

    }
}