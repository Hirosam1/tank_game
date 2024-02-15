#Choose a player to update their UI
extends CanvasLayer

@export
var player_node_path := NodePath()

@onready
var player_speed_label := $SpeedLabel

@onready
var player_ang_velocity_label := $AngVelocityLabel

var player_node: Node = null

func _ready():
	player_node = get_node(player_node_path)
	
func _process(_delta):
	player_speed_label.text = "Speed: %d" % [player_node.speed]
	var ang_vel :float = player_node.calc_current_ang_vel()
	player_ang_velocity_label.text = "Ang. velocity: %.2f" % [ang_vel]
