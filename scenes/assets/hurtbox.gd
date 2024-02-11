extends Area2D

@export
var health := 1

func damage(val: int)->int:
	health -= val
	if(health < 0):
		get_parent().destroy()
	return health 

func destroy():
	queue_free()
