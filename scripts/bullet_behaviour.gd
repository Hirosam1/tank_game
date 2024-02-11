extends Node2D

@export
var speed: float = 150.0

func _process(delta):
	position += -Vector2.UP.rotated(rotation) * speed * delta
	
func de_spawn():
	queue_free()
