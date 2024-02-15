#Choose a player to update their UI
extends CanvasLayer

@export
var player_node_path := NodePath()

@onready
var player_speed_label := $SpeedLabel

@onready
var player_ang_velocity_label := $AngVelocityLabel

var player_node: Node = null

## Labels text
var player_speed_text = "Speed %d px/s"
var player_ang_speed_text = "Ang. velocity %.2f rad/s"

func _ready():
	player_node = get_node(player_node_path)
	
func _process(_delta):
	player_speed_label.text = player_speed_text % [player_node.speed]
	var ang_vel :float = player_node.calc_current_ang_vel()
	player_ang_velocity_label.text = player_ang_speed_text % [ang_vel]

func _on_button_restart_pressed():
	get_tree().reload_current_scene()
