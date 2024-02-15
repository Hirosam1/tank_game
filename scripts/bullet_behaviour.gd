extends Node2D

## Default speed of the bullet in px/s. May be changed depending on the 
## spawner speed.
@export
var speed: float = 150.0

func _process(delta):
	position += -Vector2.UP.rotated(rotation) * speed * delta
	
func de_spawn():
	queue_free()
