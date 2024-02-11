#Choose a player to update their UI
extends CanvasLayer

@export
var player_node_path := NodePath()

@onready
var player_speed_label := $SpeedLabel
var player_node: Node = null

func _ready():
	player_node = get_node(player_node_path)
	
func _process(_delta):
	player_speed_label.text = "Speed: %d" % [player_node.speed]
	
