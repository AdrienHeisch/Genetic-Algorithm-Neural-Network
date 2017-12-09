package com.adrienheisch.spacewar.game
{
	import com.adrienheisch.neuralnetwork.Genetic;
	import com.adrienheisch.neuralnetwork.NeuralNetwork;
	import com.adrienheisch.spacewar.Main;
	import com.adrienheisch.spacewar.utils.Utils;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class NeuralShip extends Ship
	{
		protected static const DISTANCE_BEFORE_ACCELERATION:Number = 300;
		
		protected var target:Ship;
		public var network: NeuralNetwork;
		protected var surviveTime: uint = 0;
		
		public function NeuralShip()
		{
			super();
			
			network = new NeuralNetwork();
		}
		
		override public function gameLoop():void
		{
			var lLength:uint = list.length;
			if (lLength > 1)
			{
				var lShip:Ship;
				var lDistances:Vector.<Number> = new Vector.<Number>(lLength, true);
				var lSortedDistances:Array = [];
				
				for (var i:int = lLength - 1; i >= 0; i--)
				{
					lShip = list[i];
					if (GameParameters.aiMovePrediction) lDistances[i] = Utils.distanceBetweenPoints(x, y, lShip.x + (lShip.velocity.x * Utils.distanceBetweenPoints(x, y, lShip.x, lShip.y) / Bullet.SPEED), lShip.y + (lShip.velocity.y * Utils.distanceBetweenPoints(x, y, lShip.x, lShip.y) / Bullet.SPEED));
					else lDistances[i] = Utils.distanceBetweenPoints(x, y, lShip.x, lShip.y);
					lSortedDistances[i] = lDistances[i];
				}
				
				lSortedDistances.sort();
				
				target = list[lDistances.indexOf(lSortedDistances[1])];
				var lDistanceToTarget:Number = lSortedDistances[1];
				
				var lAngle:Number;
				if (GameParameters.aiShootPrediction)
				{
					var lFutureTargetPosition:Point = new Point(target.x + (target.velocity.x * lDistanceToTarget / Bullet.SPEED), target.y + (target.velocity.y * lDistanceToTarget / Bullet.SPEED));
					lAngle = Math.atan2(lFutureTargetPosition.y - y, lFutureTargetPosition.x - x) * Utils.RAD2DEG;
				}
				else lAngle = Math.atan2(target.y - y, target.x - x) * Utils.RAD2DEG;
				
				var lAngleDelta:Number = Utils.angleDifference(lAngle, rotation);
				
				network.input[0].output = lDistanceToTarget;
				network.input[1].output = lAngleDelta;
				
				for (i = input.length - 1; i >= 0; i--)
					input[i] = network.output[i].output;
			}
			else
			{
				for (var j:int = input.length - 1; j >= 0; j--)
					input[j] = false;
			}
			
			if (surviveTime < 3600) {
				surviveTime++;
				if (surviveTime % 2 == 0) network.fitness++;
			} else {
				destroy();
				return;
			}
			
			super.gameLoop();
		}
		
		override public function destroy():void
		{
			network.destroy();
			super.destroy();
		}
	
	}

}