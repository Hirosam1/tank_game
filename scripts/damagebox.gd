## Custom class handling the damage boxes, when in contact
## with a custom hurtbox class it will *damage* it.
extends Area2D

## Specifies how much this object will damage another.
@export
var object_damage = 0
## If set as true, the object will be destroyed at impact
@export
var destroy_at_impact := true
## Path to the main node of this hurtbox.
@export
var root_node : NodePath = NodePath()


func _on_area_entered(area: Area2D):
	# On cases where you don't know the type of object
	# you are interacting, you can check if it has a method you can use.
	if(area.has_method("damage")):
		area.damage(object_damage)
	if(destroy_at_impact):
		get_node(root_node).queue_free()

