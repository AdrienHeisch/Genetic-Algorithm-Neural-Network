package com.adrienheisch.spacewar.game
{
	import com.adrienheisch.spacewar.game.Explosion;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class Ship extends MovieClip
	{
		public static var list:Vector.<Ship> = new Vector.<Ship>();
		
		protected static const COLORS:Vector.<uint> = new <uint>[0xFF0000, 0x0099FF, 0x00FF00, 0xFFFFFF];
		
		public static const MAX_HEALTH:Number = 5;
		protected static const MAX_TURNING_SPEED:Number = 3;
		protected static const TURNING_ACCELERATION_VALUE:Number = 0.25;
		protected static const BASE_MAX_SPEED:Number = 5;
		protected static const BASE_ACCELERATION:Number = 0.2;
		protected static const BRAKE:Number = 0.1;
		protected static const SELF_BRAKE:Number = 0.05;
		protected static const BOOST_MULT:Number = 2;
		protected static const SHOOT_COOLDOWN:int = 20;
		
		public var velocity:Point = new Point(0, 0);
		protected var maxSpeed:int = 0;
		protected var acceleration:Point = new Point(0, 0);
		protected var accelerationValue:Number = 0;
		protected var turningSpeed:Number = 0;
		protected var turningAcceleration:Number = 0;
		protected var shootTimer:int = 0;
		protected var color:uint = 0;
		
		//0:left, 1:right, 2:up, 3:down, 4:boost, 5:shoot
		public var input:Vector.<Boolean> = new Vector.<Boolean>(6, true);
		public var health:Number;
		public var id: uint;
		
		public var mcColor:MovieClip;
		public var mcShootPoint:MovieClip;
		
		public function Ship()
		{
			super();
			
			list.push(this);
			
			cacheAsBitmap = true;
			
			health = MAX_HEALTH;
			id = list.indexOf(this) + 1;
			
			mcShootPoint.visible = false;
			
			color = COLORS[list.indexOf(this)];
			var lColorTransform:ColorTransform = new ColorTransform();
			lColorTransform.color = color;
			mcColor.transform.colorTransform = lColorTransform;
		}
		
		public function gameLoop():void
		{
			if (input[5] && shootTimer == 0)
				shoot();
			else if (shootTimer != 0)
				shootTimer -= 1;
			
			maxSpeed = BASE_MAX_SPEED * (input[4] ? BOOST_MULT : 1);
			accelerationValue = BASE_ACCELERATION * (input[4] ? BOOST_MULT : 1);
			
			if ((!input[0] && !input[1]) || (input[0] && input[1]))
			{
				turningAcceleration = 0;
				if (turningSpeed > 0)
				{
					turningSpeed -= TURNING_ACCELERATION_VALUE;
				}
				if (turningSpeed < 0)
				{
					turningSpeed += TURNING_ACCELERATION_VALUE;
				}
			}
			else if (input[0])
				turningAcceleration = -TURNING_ACCELERATION_VALUE;
			else if (input[1])
				turningAcceleration = TURNING_ACCELERATION_VALUE;
			
			if ((turningSpeed >= MAX_TURNING_SPEED && turningAcceleration > 0) || (turningSpeed <= -MAX_TURNING_SPEED && turningAcceleration < 0)) turningAcceleration = 0;
			turningSpeed += turningAcceleration;
			rotation += turningSpeed;
			
			if (input[2])
			{
				acceleration.x = accelerationValue * Math.cos(rotation * Math.PI / 180);
				acceleration.y = accelerationValue * Math.sin(rotation * Math.PI / 180);
			}
			else
			{
				acceleration.setTo(0, 0);
				if (input[3] && GameParameters.shipMoveBackAllowed)
				{
					acceleration.x = BRAKE * -Math.cos(rotation * Math.PI / 180);
					acceleration.y = BRAKE * -Math.sin(rotation * Math.PI / 180);
					
				}
				else if (Math.abs(velocity.length) > SELF_BRAKE && GameParameters.shipAutoSlow)
				{
					acceleration.x = SELF_BRAKE * -Math.cos(Math.atan2(velocity.y, velocity.x));
					acceleration.y = SELF_BRAKE * -Math.sin(Math.atan2(velocity.y, velocity.x));
				}
			}
			
			velocity.x += acceleration.x;
			velocity.y += acceleration.y;
			
			if (velocity.length >= maxSpeed)
			{
				velocity.x += (SELF_BRAKE + accelerationValue) * -Math.cos(Math.atan2(velocity.y, velocity.x));
				velocity.y += (SELF_BRAKE + accelerationValue) * -Math.sin(Math.atan2(velocity.y, velocity.x));
			}
			
			if ((x <= width / 2 && velocity.x < 0) || (x >= stage.stageWidth - width / 2 && velocity.x > 0))
				velocity.x *= -1;
			if ((y <= height / 2 && velocity.y < 0) || (y >= stage.stageHeight - height / 2 && velocity.y > 0))
				velocity.y *= -1;
			
			x += velocity.x;
			y += velocity.y;
		}
		
		protected function shoot():void
		{
			var lBullet:Bullet;
			shootTimer = SHOOT_COOLDOWN;
			parent.addChild(lBullet = new Bullet());
			var lBulletCoords:Point = localToGlobal(parent.globalToLocal(new Point(mcShootPoint.x, mcShootPoint.y)));
			lBullet.parentShip = this;
			lBullet.x = lBulletCoords.x;
			lBullet.y = lBulletCoords.y;
			lBullet.rotation = rotation;
			lBullet.velocity = new Point(Bullet.SPEED * Math.cos(rotation * Math.PI / 180), Bullet.SPEED * Math.sin(rotation * Math.PI / 180));
			lBullet.color = color;
		}
		
		public function destroy():void
		{
			var lExplosion:Explosion;
			parent.addChild(lExplosion = new Explosion());
			lExplosion.x = x;
			lExplosion.y = y;
			
			list.splice(list.indexOf(this), 1);
			if (parent != null) parent.removeChild(this);
		}
	
	}

}