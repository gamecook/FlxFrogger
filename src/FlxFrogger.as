package {
import org.flixel.FlxGame;

[SWF(width="480", height="800", backgroundColor="#000000")]
[Frame(factoryClass="Preloader")]

public class FlxFrogger extends FlxGame {
    public function FlxFrogger() {
        super(480, 800, PlayState, 1);
    }
}
}
