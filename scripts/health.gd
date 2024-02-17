## Health component of the node.
extends Node2D
class_name Health

@export var fx_sprites_path := NodePath()

signal health_depleted 
signal hurted(damage_size)

## Health of the object
@export_range(1.0,2.0,1.0,"or_greater")
var health :int = 1

var depleated := false

## Set big damage to a percetege of max health
var big_damage = 0

func _ready():
	big_damage = health*0.2

var n2d_path := NodePath()
var fx_sprites: Node2D = null

func damage(hurtbox: HurtBox, val):
	health -= val
	if(health <= 0 and not depleated):
		get_node(fx_sprites_path).position = position
		depleated = true
		health_depleted.emit()
	else:
		get_node(fx_sprites_path).position = hurtbox.hurt_spot.position
		if(val >= big_damage):
			hurted.emit("big_damage")
		else:
			hurted.emit("small_damage")
