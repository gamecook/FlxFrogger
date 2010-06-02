package
{
    public class Bonus extends TimerSprite
    {

        public static const SPRITE_WIDTH:uint = 40;
        public static const SPRITE_HEIGHT:uint = 40;
        public static const BONUS:uint = 0;
        public static const NO_BONUS:uint = 1;
        public static const SUCCESS:uint = 2;
        public static const EMPTY:uint = 3;


        [Embed(source="../build/assets/bonus_sprites.png")]
        private var SpriteImage:Class;

        public var mode:uint;
        public var odds:uint;

        public function Bonus(x:int, y:int, hideTimer:int = TimerSprite.DEFAULT_TIME, startTime:int = TimerSprite.DEFAULT_TIME, odds:uint = 10)
        {
            super(x, y, null, hideTimer, startTime, 0, 0);

            this.odds = odds;

            loadGraphic(SpriteImage, false, false, SPRITE_WIDTH, SPRITE_HEIGHT);
            addAnimation("empty", [EMPTY], 0, false);
            addAnimation("bonus", [BONUS], 0, false);
            addAnimation("noBonus", [NO_BONUS], 0, false);
            addAnimation("success", [SUCCESS], 0, false);

            play("empty");

        }

        override protected function onDeactivate():void
        {
            showEmpty();
        }

        override protected function onActivate():void
        {
            var id:uint = Math.random() * odds;
            switch (id)
            {
                case(BONUS):
                    showBonus();
                    break;
                case(NO_BONUS):
                    showNoBonus();
                    break;
                default:
                    showEmpty();
                    break;
            }
        }

        private function showEmpty():void
        {
            play("empty");
        }

        private function showNoBonus():void
        {
            play("noBonus");
        }

        private function showBonus():void
        {
            play("bonus");
        }

        public function success():void
        {
            play("success");
            hideTimer = timer = -1;
        }
        
        protected function setMode(mode:uint, animationSet:String):void
        {
            this.mode = mode;
            play(animationSet);
        }

    }
}