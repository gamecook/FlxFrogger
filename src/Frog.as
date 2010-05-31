package {
import flash.geom.Point;

import flashx.textLayout.formats.Direction;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

public class Frog extends FlxSprite{

    [Embed(source="data/frog_sprites.png")] private var ImgPlayer:Class;
    private var startPosition:Point;
    private var _move_speed:int;

    public function Frog(X:Number, Y:Number) {
        super(X,Y);

        startPosition = new Point(X,Y);
        loadGraphic(ImgPlayer,true, false, 37, 43);
        var speed:int = 3;
        _move_speed = 32*(speed-1);
        //drag.x = 500;
        drag.x = 32*speed+1;
        drag.y = 32*speed+1;

        width = 32;
        height = 30;
        offset.x = 1;
        offset.y = 7;

        addAnimation("idle"+UP,[0],0,false);
        addAnimation("idle"+RIGHT,[2],0,false);
        addAnimation("idle"+DOWN,[4],0,false);
        addAnimation("idle"+LEFT,[6],0,false);
        addAnimation("walk"+UP,[0,1],2,true);
        addAnimation("walk"+RIGHT,[2,3],2,true);
        addAnimation("walk"+DOWN,[4,5],2,true);
        addAnimation("walk"+LEFT,[6,7],2,true);
        addAnimation("die",[8, 9, 10, 11],2,false);

        facing = FlxSprite.UP;

    }

    override public function update():void
    {
        var state:PlayState = FlxG.state as PlayState;

        if(state.gameState == PlayState.COLLISION_STATE)
        {
            if(frame == 11)
            {
                state.gameState = PlayState.DEATH_OVER;
            }
        }
        else
        {
            
            if(velocity.x == 0 && velocity.y == 0)
            {
                if(FlxG.keys.LEFT) {
                     velocity.x -= _move_speed;
                    facing = LEFT;
                } else if (FlxG.keys.RIGHT) {
                     velocity.x += _move_speed;
                    facing = RIGHT;
                }
                else if(FlxG.keys.UP) {
                     velocity.y -= _move_speed;
                    facing = UP;
                } else if (FlxG.keys.DOWN) {
                     velocity.y += _move_speed;
                    facing = DOWN;
                }
                play("idle"+facing);

            }
            else
            {
                play("walk"+facing);
            }

        }

        //Default object physics update
        super.update();
    }

    public function death():void
    {
        acceleration.x = 0;
        acceleration.y = 0;
                
        play("die");
    }

    public function restart():void {
        x = startPosition.x;
        y = startPosition.y;
        facing = UP;
        play("idle"+facing);
    }
}
}