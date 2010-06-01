package
{
    import flash.events.KeyboardEvent;

    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxText;
    import org.flixel.touch.FlxTouchButton;

    public class TouchControls
    {
        private var btn:FlxTouchButton;
        private var btn2:FlxTouchButton;
        private var btn3:FlxTouchButton;
        private var btn4:FlxTouchButton;
        public function TouchControls(target:FlxState, x:int, y:int, padding:int)
        {
            btn = new FlxTouchButton(x, y, onUpPress, onUpRelease);
            btn.loadText(new FlxText(0,30,100,"UP").setFormat(null, 20,0xffffff,"center"));
            target.add(btn);

            btn2 = new FlxTouchButton(btn.x + btn.width + padding, btn.y, onDownPress, onDownRelease);
            btn2.loadText(new FlxText(0,30,100,"DOWN").setFormat(null, 20,0xffffff,"center"));
            target.add(btn2);

            btn3 = new FlxTouchButton(btn2.x + btn2.width + padding, btn.y, onLeftPress, onLeftRelease);
            btn3.loadText(new FlxText(0,30,100,"LEFT").setFormat(null, 20,0xffffff,"center"));
            target.add(btn3);

            btn4 = new FlxTouchButton(btn3.x + btn3.width + padding, btn.y, onRightPress, onRightRelease);
            btn4.loadText(new FlxText(0,30,100,"RIGHT").setFormat(null, 20,0xffffff,"center"));
            target.add(btn4);
        }

        private function onLeftRelease():void {
            FlxG.keys.handleKeyUp(new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 0, 37, 0, false, false, false));
        }

        private function onLeftPress():void {
            FlxG.keys.handleKeyDown(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, 37, 0, false, false, false));
        }

        private function onRightRelease():void {
            FlxG.keys.handleKeyUp(new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 0, 39, 0, false, false, false));
        }

        private function onRightPress():void {
            FlxG.keys.handleKeyDown(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, 39, 0, false, false, false));
        }

        private function onUpRelease():void {
            FlxG.keys.handleKeyUp(new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 0, 38, 0, false, false, false));
        }

        private function onUpPress():void {
            FlxG.keys.handleKeyDown(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, 38, 0, false, false, false));
        }

        private function onDownRelease():void {
            FlxG.keys.handleKeyUp(new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 0, 40, 0, false, false, false));
        }

        private function onDownPress():void {
            FlxG.keys.handleKeyDown(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, 40, 0, false, false, false));
        }
    }
}