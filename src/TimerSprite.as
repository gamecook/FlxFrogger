package {
import org.flixel.FlxG;

public class TimerSprite extends WrappingSprite {

    public static const DEFAULT_TIME:int = 400;

    protected var timer:int;
    protected var hideTimer:int;

    public function TimerSprite(x:Number, y:Number, SimpleGraphic:Class = null, hideTimer:int = DEFAULT_TIME, startTime:int = DEFAULT_TIME, dir:uint = RIGHT, velocity:int = 40) {

        super(x, y, SimpleGraphic, dir, velocity);

        this.hideTimer = hideTimer;
        timer = startTime;
    }

    override public function update():void {

        super.update();

        if (timer > 0)
            timer -= FlxG.elapsed;

        if (timer == 0) {
            toggle()
        }
    }

    public function get isActive():Boolean {
        return (frame == 3) ? true : false;
    }

    protected function toggle():void {

        if (isActive) {
            onActivate();
        }
        else {
            onDeactivate();
        }

        timer = hideTimer;
    }

    protected function onDeactivate():void {

    }

    protected function onActivate():void {

    }
}
}