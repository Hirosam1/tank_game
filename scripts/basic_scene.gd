extends Node2D

func _ready():
	GlobalSignals.on_scene_ready.emit()
