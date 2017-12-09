package com.adrienheisch.neuralnetwork 
{
	
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class GraphicRepresentation extends MovieClip 
	{
		public static var list: Vector.<GraphicRepresentation> = new Vector.<GraphicRepresentation>();
		
		public function GraphicRepresentation() 
		{
			super();
			
			list.push(this);
		}
		
		public function destroy(): void {
			list.splice(list.indexOf(this), 1);
			if (parent != null) parent.removeChild(this);
		}

	}
	
}