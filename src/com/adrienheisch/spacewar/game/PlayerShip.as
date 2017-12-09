package com.adrienheisch.spacewar.game
{
	import com.adrienheisch.spacewar.utils.KeyboardManager;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class PlayerShip extends Ship
	{
		protected static const CONTROLS:Vector.<Vector.<uint>> = new < Vector.<uint> > [
			new <uint>[Keyboard.Q, Keyboard.D, Keyboard.Z, Keyboard.S, Keyboard.T, Keyboard.Y],
			new <uint>[Keyboard.LEFT, Keyboard.RIGHT, Keyboard.UP, Keyboard.DOWN, Keyboard.NUMPAD_2, Keyboard.NUMPAD_3]
		];
		
		protected var controls:Vector.<uint> = new Vector.<uint>(6, true);
		
		public function PlayerShip()
		{
			super();
			
			controls = CONTROLS[list.indexOf(this)];
		}
		
		override public function gameLoop():void
		{
			for (var i:int = controls.length - 1; i >= 0; i--)
			{
				input[i] = KeyboardManager.keys.indexOf(controls[i]) >= 0 ? true : false;
			}
			
			super.gameLoop();
		}
	
	}

}