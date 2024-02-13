extends AnimationPlayer
signal finished_destroy_animation

var destroy_animation = "destructable_object_animations/destruction"

func _on_health_health_depleted():
	play(destroy_animation)

func _on_animation_finished(anim_name):
	if(anim_name == destroy_animation):
		finished_destroy_animation.emit()
