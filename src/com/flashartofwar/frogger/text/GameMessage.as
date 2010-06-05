package com.flashartofwar.frogger.text
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
    import org.flixel.FlxText;

    /**
     * A simple button class that calls a function when clicked by the mouse.
     * Supports labels, highlight states, and parallax scrolling.
     */
    public class GameMessage extends FlxGroup
    {
        /**
         * Stores the 'off' or normal button state graphic.
         */
        protected var _off:FlxSprite;
        /**
         * Stores the 'off' or normal button state label.
         */
        protected var _offT:FlxText;

        /**
         * Creates a new <code>FlxButton</code> object with a gray background
         * and a callback function on the UI thread.
         *
         * @param    X            The X position of the button.
         * @param    Y            The Y position of the button.
         */
        public function GameMessage(X:int, Y:int, width:int, height:int)
        {
            super();
            x = X;
            y = Y;
            this.width = width;
            this.height = height;
            _off = new FlxSprite().createGraphic(width, height, 0xff7f7f7f);
            _off.solid = false;
            add(_off, true);
            _offT = null;
        }

        /**
         * Set your own image as the button background.
         *
         * @param    Image                A FlxSprite object to use for the button background.
         *
         * @return    This FlxButton instance (nice for chaining stuff together, if you're into that).
         */
        public function loadGraphic(Image:FlxSprite):GameMessage
        {
            _off = replace(_off, Image) as FlxSprite;

            _off.scrollFactor = scrollFactor;
            width = _off.width;
            height = _off.height;
            refreshHulls();
            return this;
        }

        /**
         * Add a text label to the button.
         *
         * @param    Text                A FlxText object to use to display text on this button (optional).
         *
         * @return    This FlxButton instance (nice for chaining stuff together, if you're into that).
         */
        public function loadText(Text:FlxText):GameMessage
        {
            if (Text != null)
            {
                if (_offT == null)
                {
                    _offT = Text;
                    add(_offT);
                }
                else
                    _offT = replace(_offT, Text) as FlxText;
            }

            _offT.scrollFactor = scrollFactor;
            return this;
        }

        public function set text(value:String):void
        {
            _offT.text = value;
        }

    }
}
