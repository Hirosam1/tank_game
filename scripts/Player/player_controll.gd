## Controlls the movement of the player controller,
## based on player input.
extends CharacterBody2D
## How much it increaces velocity per second.
@export
var acceleration = 15.0
## How much speed is lost per second, not including player input.
@export
var deacceleration = 8.0
## Maximum speed per second
@export
var top_speed = 200.0
##Minimum angular velocity in radians
@export
var min_angular_velocity = 1.5
## The angular velocity at speed = 0, at others speeds it is 
## interpolated with min_angular_velocity 
@export
var top_angular_vel = 2.5

@onready var tank_animation := $TankAnimation
var mov_vec = Vector2() 
var speed = 0.0

func _ready():
	tank_animation.max_speed = top_speed

func update_child_nodes():
	tank_animation.current_speed = speed

func _process(_delta):
	mov_vec = Input.get_vector("player_mov_left", "player_mov_right", 
	"player_mov_down", "player_mov_up")
	update_child_nodes()

func _physics_process(delta):
	var moved_vec = mov_vec
	var vel_add = moved_vec.y * acceleration
	if(abs(speed) > 0.1):
		if(vel_add*sign(speed) < 0.1):
			vel_add -= deacceleration * sign(speed)
	else:
		speed = 0
	var smooth_vel = smoothstep(0.0, 1.0, 1.0 - (abs(speed)/top_speed))
	var ang_vel = moved_vec.x * lerp(min_angular_velocity,
									 top_angular_vel, 
									 smooth_vel)

	rotation += ang_vel * delta
	speed = clamp(speed+vel_add*delta,-top_speed,top_speed)
	var speed_vec = Vector2.DOWN.rotated(rotation) * speed
	var col: KinematicCollision2D =  move_and_collide(speed_vec*delta)
	if(col):
		speed = 0
