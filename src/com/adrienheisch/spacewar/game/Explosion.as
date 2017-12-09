package com.adrienheisch.spacewar.game
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class Explosion extends MovieClip
	{
		
		public static var list:Vector.<Explosion> = new Vector.<Explosion>();
		
		public function Explosion()
		{
			super();
			
			list.push(this);
		}
		
		public function gameLoop():void
		{
			if (currentFrame == totalFrames)
			{
				destroy();
			}
		}
		
		public function destroy():void
		{
			list.splice(list.indexOf(this), 1);
			if (parent != null) parent.removeChild(this);
		}
	
	}

}