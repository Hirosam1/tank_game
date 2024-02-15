## Custom class handling hurtboxes, hurtboxes will *damage* 
## any parent class.
extends Area2D
class_name  HurtBox
## How much damage this hurtbox will reduce.
@export
var damage_negator := 0

## Identifier for health handling.
@export
var id: String = ""

func damage(val: int):
	get_parent().damage(self, val-damage_negator)
