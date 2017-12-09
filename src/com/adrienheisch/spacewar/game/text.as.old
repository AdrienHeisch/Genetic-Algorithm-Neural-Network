import flash.events.Event;
import flash.geom.Point;
import flash.geom.ColorTransform;

var keyLeft: Boolean = false;
var keyRight: Boolean = false;
var keyUp: Boolean = false;
var keyDown: Boolean = false;
var keyAcceleration: Boolean = false;
var keyShoot: Boolean = false;

// INTIALISATION
// placer ici le code qui s'executera une fois au lancement

const MAX_TURNING_SPEED: Number = 3;
const TURNING_ACCELERATION_VALUE: Number = 0.25;
const BASE_MAX_SPEED: Number = 5;
const BASE_ACCELERATION: Number = 0.2;
const BRAKE: Number = 0.1;
const SELF_BRAKE: Number = 0.05;

const BOOST_MULT: Number = 2;

const BULLET_SPEED: int = 30;
const SHOOT_COOLDOWN: int = 6;

mcShip.x = stage.stageWidth / 2;
mcShip.y = stage.stageHeight / 2;

var velocity: Point = new Point(0, 0);
var maxSpeed: int = 0;

var acceleration: Point = new Point(0, 0);
var accelerationValue: Number = 0;

var direction: Number = 0;
var turningSpeed: Number = 0;
var turningAcceleration: Number = 0;

var bullets:Array = [];
var bulletsSpeed:Array = [];
var shootTimer: int = 0;
var SHOOT_COLOR: uint = 0xFF0000;

// ACTION


function shipControl(): void {
	maxSpeed = BASE_MAX_SPEED * (keyAcceleration ? BOOST_MULT : 1);
	accelerationValue = BASE_ACCELERATION * (keyAcceleration ? BOOST_MULT : 1);

	if ((!keyLeft && !keyRight) || (keyLeft && keyRight)) {
		turningAcceleration = 0;
		if (turningSpeed > 0) {
			turningSpeed -= TURNING_ACCELERATION_VALUE;
		}
		if (turningSpeed < 0) {
			turningSpeed += TURNING_ACCELERATION_VALUE;
		}
	} else if (keyLeft) 
		turningAcceleration = -TURNING_ACCELERATION_VALUE;
	else if 
		(keyRight) turningAcceleration = TURNING_ACCELERATION_VALUE;
	
	if (Math.abs(turningSpeed) >= MAX_TURNING_SPEED) turningAcceleration = 0;
	turningSpeed += turningAcceleration;
	direction += turningSpeed;
	mcShip.rotation = direction;


	if (keyUp) {
		acceleration.x = accelerationValue * Math.cos(direction * Math.PI / 180);
		acceleration.y = accelerationValue * Math.sin(direction * Math.PI / 180);
	} else {
		acceleration.setTo(0, 0);
		if (keyDown) {
			acceleration.x = BRAKE * -Math.cos(direction * Math.PI / 180);
			acceleration.y = BRAKE * -Math.sin(direction * Math.PI / 180);

		} else if (Math.abs(velocity.length) > SELF_BRAKE) {
			acceleration.x = SELF_BRAKE * -Math.cos(Math.atan2(velocity.y, velocity.x));
			acceleration.y = SELF_BRAKE * -Math.sin(Math.atan2(velocity.y, velocity.x));
		}
	}

	velocity.x += acceleration.x;
	velocity.y += acceleration.y;

	if (velocity.length >= maxSpeed) {
		velocity.x += (SELF_BRAKE + accelerationValue) * -Math.cos(Math.atan2(velocity.y, velocity.x));
		velocity.y += (SELF_BRAKE + accelerationValue) * -Math.sin(Math.atan2(velocity.y, velocity.x));
	}
	
	if ((mcShip.x <= mcShip.width/2 && velocity.x < 0) || (mcShip.x >= stage.stageWidth - mcShip.width/2 && velocity.x > 0))
		velocity.x *= -1;
	if ((mcShip.y <= mcShip.height/2 && velocity.y < 0) || (mcShip.y >= stage.stageHeight - mcShip.height/2 && velocity.y > 0))
		velocity.y *= -1;

	mcShip.x += velocity.x;
	mcShip.y += velocity.y;
}

function shoot():void {
	var lColorTransform: ColorTransform = new ColorTransform();
	var lBullet: Bullet = new Bullet();
	shootTimer = SHOOT_COOLDOWN;
	bullets.push(lBullet);
	addChild(lBullet);
	lBullet.x = mcShip.x;
	lBullet.y = mcShip.y;
	lBullet.rotation = direction;
	bulletsSpeed.push([BULLET_SPEED * Math.cos(direction * Math.PI / 180), BULLET_SPEED * Math.sin(direction * Math.PI / 180)]);
	lColorTransform.color = SHOOT_COLOR;
	lBullet.transform.colorTransform = lColorTransform;
}

function moveBullets(): void {	
	var lNbBullets: uint = bullets.length;
	for (var i: int = lNbBullets - 1; i >= 0; i--) {
		if (bullets[i].x < -bullets[i].width || bullets[i].x > stage.stageWidth + bullets[i].width || bullets[i].y < -bullets[i].height || bullets[i].y > stage.stageHeight + bullets[i].height) {
			removeChild(bullets[i]);
			bullets.splice(i,1);
			bulletsSpeed.splice(i,1);
		}
		else {
			bullets[i].x += bulletsSpeed[i][0];
			bullets[i].y += bulletsSpeed[i][1];
		}
	}
	
}

addEventListener(Event.ENTER_FRAME, gameLoop);
stage.addEventListener(KeyboardEvent.KEY_DOWN, registerKey);
stage.addEventListener(KeyboardEvent.KEY_UP, unregisterKey);

function registerKey(pEvent: KeyboardEvent): void {
	if (pEvent.keyCode == Keyboard.LEFT) keyLeft = true;
	else if (pEvent.keyCode == Keyboard.RIGHT) keyRight = true;
	else if (pEvent.keyCode == Keyboard.UP) keyUp = true;
	else if (pEvent.keyCode == Keyboard.DOWN) keyDown = true;
	else if (pEvent.keyCode == Keyboard.C) keyAcceleration = true;
	else if (pEvent.keyCode == Keyboard.V) keyShoot = true;
}

function unregisterKey(pEvent: KeyboardEvent): void {
	if (pEvent.keyCode == Keyboard.LEFT) keyLeft = false;
	else if (pEvent.keyCode == Keyboard.RIGHT) keyRight = false;
	else if (pEvent.keyCode == Keyboard.UP) keyUp = false;
	else if (pEvent.keyCode == Keyboard.DOWN) keyDown = false;
	else if (pEvent.keyCode == Keyboard.C) keyAcceleration = false;
	else if (pEvent.keyCode == Keyboard.V) keyShoot = false;
}