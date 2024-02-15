## Health component of the node.
extends Node2D
class_name Health

signal health_depleted 

## Health of the object
@export_range(1.0,2.0,1.0,"or_greater")
var health :int = 1

var depleated := false

func damage(hurtbox: HurtBox, val):
	health -= val
	if(health <= 0 and not depleated):
		depleated = true
		health_depleted.emit()
