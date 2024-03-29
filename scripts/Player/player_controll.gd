## Controlls the movement of the player controller,
## based on player input.
extends CharacterBody2D

## How much it increaces speed (px/s) per second.
@export
var acceleration = 15.0

## How much speed is lost per second, not including player input.
@export
var deacceleration = 8.0

## Maximum speed.
@export
var top_speed = 200.0

##Minimum angular velocity in radians per seconds.
@export
var min_angular_velocity = 1.5

## The angular velocity at speed = 0, at others speeds it is 
## interpolated with min_angular_velocity .
@export
var top_angular_vel = 2.5

@onready var tank_animation := $TankAnimation
@onready var tank_camera := $Camera2D
var mov_vec = Vector2() 
var speed = 0.0

func _ready():
	tank_animation.max_speed = top_speed

func update_child_nodes():
	tank_animation.current_speed = speed

func _process(_delta):
	mov_vec.x = Input.get_axis("player_mov_left","player_mov_right")
	mov_vec.y = Input.get_axis("player_mov_down","player_mov_up")
	update_child_nodes()

## Calculates current angular velocity based on player's speed
func calc_current_ang_vel()->float:
	var smooth_margin = -5
	var smooth_vel = smoothstep(top_speed-smooth_margin, 
								0+smooth_margin, abs(speed))
	return lerp(min_angular_velocity,top_angular_vel, smooth_vel)

func _physics_process(delta):
	var moved_vec = mov_vec
	var vel_add = moved_vec.y * acceleration
	if(abs(speed) > 0.1):
		if(vel_add*sign(speed) < 0.01):
			vel_add -= deacceleration * sign(speed)
	else:
		speed = 0

	var ang_vel = moved_vec.x * calc_current_ang_vel()
	rotation += ang_vel * delta
	speed = clamp(speed+vel_add*delta,-top_speed,top_speed)
	velocity = Vector2.DOWN.rotated(rotation) * speed
	var col: KinematicCollision2D =  move_and_collide(velocity*delta)
	if(col):
		speed = 0
	
	tank_camera.update_camera_position(global_position,
									   global_rotation,speed,delta)

func _on_health_health_depleted():
	pass # Replace with function body.
