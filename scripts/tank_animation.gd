## Controlls tank animation speed based on its speed.
extends AnimationPlayer

## Max  number of animations cycles per second.
## When the tank is stoped, animation is stopped.
@export
var max_animation_speed := 2.0

var current_speed := 0.0
var max_speed := 0.0

func _process(_delta):
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
