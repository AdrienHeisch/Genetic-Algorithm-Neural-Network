package com.adrienheisch.spacewar.utils 
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class Utils 
	{
		public static const RAD2DEG: Number = 180 / Math.PI;
		public static const DEG2RAD: Number = Math.PI / 180;
		
		public static function distanceBetweenPoints(pX1: Number, pY1: Number, pX2: Number, pY2: Number): Number {
			return Math.sqrt(Math.pow(pX1 - pX2, 2) + Math.pow(pY1 - pY2, 2));
		}
		
		public static function angleDifference(pAngleA: Number, pAngleB: Number): Number {
			pAngleA *= DEG2RAD;
			pAngleB *= DEG2RAD;
			var lDifference:Number = Math.atan2(Math.sin(pAngleA - pAngleB), Math.cos(pAngleA - pAngleB)) * RAD2DEG;
			return lDifference;
		}
		
		public static function sortArrayAtIndex0(pArrayA: Array, pArrayB: Array): Number {
			return pArrayA[0] <= pArrayB[0] ? -1 : 1;
		}
		
		public static function clone(source:Object):* //used to clone an Object
		{ 
			var myBA:ByteArray = new ByteArray(); 
			myBA.writeObject(source); 
			myBA.position = 0; 
			return(myBA.readObject()); 
		}
		
	}

}