extends Node2D

## Scene to the instanec of an bullet.
@export
var bullet_asset : PackedScene

## Delay, in secons, of between each fire.
@export
var shoot_delay = 1.0

var time_passed  = 0.0

func _ready():
	time_passed = shoot_delay

func _process(delta):
	time_passed += delta
	if(Input.is_action_pressed("fire") and time_passed > shoot_delay):
		time_passed = 0
		var bullet: Node2D = bullet_asset.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.speed += max(0.0,get_parent().speed)
		bullet.position = global_position
		bullet.rotation = global_rotation
