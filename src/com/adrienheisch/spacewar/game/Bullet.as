package com.adrienheisch.spacewar.game
{
	
	import com.adrienheisch.neuralnetwork.Genetic;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class Bullet extends MovieClip
	{
		
		public static var list:Vector.<Bullet> = new Vector.<Bullet>();
		
		protected static const DAMAGE:Number = 1;
		
		public static const SPEED:Number = 10;
		
		public var parentShip:Ship;
		public var velocity:Point;
		
		public function Bullet()
		{
			super();
			
			list.push(this);
			
			cacheAsBitmap = true;
		}
		
		public function set color(pColor:uint):void
		{
			var lColorTransform:ColorTransform = new ColorTransform();
			lColorTransform.color = pColor;
			transform.colorTransform = lColorTransform;
		}
		
		public function gameLoop():void
		{
			var lShip:Ship;
			for (var i:int = Ship.list.length - 1; i >= 0; i--)
			{
				lShip = Ship.list[i];
				if (lShip != parentShip && lShip.hitTestPoint(x, y))
				{
					lShip.health -= DAMAGE;
					if (lShip.health <= 0)
					{
						lShip.destroy();
						if (parentShip is NeuralShip) NeuralShip(parentShip).network.fitness += 2600, Genetic.winners++;
					}
					if (lShip is NeuralShip) NeuralShip(lShip).network.fitness /= 1.25;
					if (parentShip is NeuralShip) NeuralShip(parentShip).network.fitness += 1200;
					destroy();
					return;
				}
			}
			if (x < -width || x > stage.stageWidth + width || y < -height || y > stage.stageHeight + height)
			{
				destroy();
			}
			else
			{
				x += velocity.x;
				y += velocity.y;
			}
		}
		
		public function destroy():void
		{
			list.splice(list.indexOf(this), 1);
			if (parent != null) parent.removeChild(this);
		}
	
	}

}