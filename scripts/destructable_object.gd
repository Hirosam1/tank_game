extends Node2D

var is_destroyed := false

func _on_health_health_depleted():
	is_destroyed = true

func _on_animation_player_finished_destroy_animation():
	queue_free()
