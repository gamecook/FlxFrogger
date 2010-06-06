/*
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.flashartofwar.frogger.enum
{
    /**
     * These are the game states and help maintain a consistent state throughout the game.
     *
     * Playing - Allows full animation and collision detection
     * Collision - Flag that a collision has happened and everything needs to pause
     * Restart - The game is being restarted
     * Game Over - The game is over and everything is waiting until the PlayState is unloaded.
     * Death Over - The player's death animation is over and we can move back into Play State.
     * Level Over - A level has been completed and we wait for the time lable to go away.
     */
    public class GameStates
    {
        public static const PLAYING:uint = 0; //
        public static const COLLISION:uint = 1; //
        public static const RESTART:uint = 2; //
        public static const GAME_OVER:uint = 3; //
        public static const DEATH_OVER:uint = 4; //
        public static const LEVEL_OVER:uint = 5; //
    }
}