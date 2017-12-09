package com.adrienheisch.spacewar.background
{
	
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class Star extends MovieClip
	{
		
		public static var list:Vector.<Star> = new Vector.<Star>();
		
		public function Star()
		{
			super();
			
			list.push(this);
			
			cacheAsBitmap = true;
			
			var lScale:Number = Math.random();
			scaleX = lScale;
			scaleY = lScale;
			
			alpha = Math.random() * 0.5 + 0.5
		}
		
		public function destroy():void
		{
			list.splice(list.indexOf(this), 1);
			if (parent != null) parent.removeChild(this);
		}
	
	}

}