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

var is_alive=true

func _ready():
	tank_animation.max_speed = top_speed

func update_child_nodes():
	tank_animation.current_speed = speed

func _process(_delta):
	update_child_nodes()

## Calculates current angular velocity based on player's speed
func calc_current_ang_vel()->float:
	var smooth_vel = smoothstep(0.0, 1.0, 1.0 - (abs(speed)/top_speed))
	return lerp(min_angular_velocity,top_angular_vel, smooth_vel)

func _physics_process(delta):
	pass
	
func _on_health_health_depleted():
	is_alive=false

func _on_tank_animation_finished_destroy_animation():
	queue_free()
