## Controlls tank animation speed based on its speed.
extends AnimationPlayer

signal finished_destroy_animation

## Max  number of animations cycles per second.
## When the tank is stoped, animation is stopped.
@export
var max_animation_speed := 2.0

var current_speed := 0.0
var max_speed := 0.0
var append := "tank_anim/"
var is_alive := true

func an(anim:String)->String:
	return append+anim


func _process(_delta):
	speed_scale=1
	if(is_alive):
		var anim_speed_scale = 0
		if(current_speed == 0.0):
			if current_animation !=an("idle"):
				play("tank_anim/idle")
		else:
			if current_animation != an("moving"):
				play("tank_anim/moving")
			anim_speed_scale = lerp(0.0, max_animation_speed,
									current_speed/max_speed)
			speed_scale = anim_speed_scale

func _on_health_health_depleted():
	is_alive=false
	play("tank_anim/destroying")

func _on_animation_finished(anim_name):
	if(anim_name == an("destroying")):
		finished_destroy_animation.emit()


func _on_tank_health_health_depleted():
	pass # Replace with function body.

func _on_tank_health_hurted(damage_size):
	is_alive=false
	if(damage_size=="big_damage"):
		play("tank_anim/spark_big")
	else:
		play("tank_anim/spark_small")
