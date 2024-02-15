## Controlls tank animation speed based on its speed.
extends AnimationPlayer

signal finished_destroy_animation

## Max  number of animations cycles per second.
## When the tank is stoped, animation is stopped.
@export
var max_animation_speed := 2.0

var current_speed := 0.0
var max_speed := 0.0

var destroy_animation = "destroy"

var is_alive=true

func _process(_delta):
	speed_scale=1
	if(is_alive):
		var anim_speed_scale = 0
		if(current_speed == 0.0):
			if current_animation != "Idle":
				play("Idle")
		else:
			if current_animation != "Moving":
				play("Moving")
			anim_speed_scale = lerp(0.0, max_animation_speed,
									current_speed/max_speed)
			speed_scale = anim_speed_scale

func _on_health_health_depleted():
	is_alive=false
	play(destroy_animation)

func _on_animation_finished(anim_name):
	if(anim_name == destroy_animation):
		finished_destroy_animation.emit()
