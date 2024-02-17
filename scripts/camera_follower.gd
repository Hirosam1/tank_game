extends Camera2D

## Target to follow, need to have the speed property working
## correctly.
@export
var moving_target := NodePath()

## Maximum camera zoom, when the car is stoped
@export_range(0.25,4,0.25)
var max_zoom := 2.75

## Minimum zoom, if the car can reach speed ratio or more.
@export_range(0.25,4,0.25)
var min_zoom := 1.75

## Commum ratio for speed
@export
var speed_ratio = 300

## How much ofsset from the center in pixel the camera should move.
@export
var camera_max_offset := 100

## Time in seconds, that is expected the camera to reach its
## calculated position, smaller values makes the camera move faster. 
@export
var camera_time_to_reach_pos := 0.15

var target_node: Node2D = null

func calc_cam_params()->Array:
	var target_speed = target_node.speed
	var target_direction = Vector2.DOWN.rotated(target_node.global_rotation)
	var rat = target_speed/speed_ratio
	var new_zoom = min((max_zoom - min_zoom)*(1.0-abs(rat)) + min_zoom, max_zoom)
	var new_pos = target_node.global_position +\
				  target_direction*(rat*camera_max_offset)
	return [new_pos, Vector2(new_zoom,new_zoom)]

func scene_ready():	
	target_node = get_node(moving_target)
	global_position = target_node.global_position

func _ready():
	GlobalSignals.on_scene_ready.connect(scene_ready)

func _process(delta):
	var params := calc_cam_params()
	var target_pos = params[0]
	var target_zoom = params[1]
	camera_time_to_reach_pos
	var step := 1.0/camera_time_to_reach_pos
	global_position = lerp(global_position, target_pos, step*delta)
	zoom = lerp(zoom, target_zoom, step*delta)
	
	

