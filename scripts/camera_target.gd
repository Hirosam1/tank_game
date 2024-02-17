extends Camera2D

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

func update_camera_position(t_global_position:Vector2,\
							t_global_rotation:float,\
							speed:float, delta:float):
	var target_speed = speed
	var target_direction = Vector2.DOWN.rotated(t_global_rotation)
	var rat = target_speed/speed_ratio
	var new_zoom = min((max_zoom - min_zoom)*(1.0-abs(rat)) + min_zoom, max_zoom)
	var target_pos = t_global_position +\
				  target_direction*(rat*camera_max_offset)
	var step := 1.0/camera_time_to_reach_pos
	target_pos =  lerp(global_position, target_pos, step*delta) 
	global_position = target_pos
	zoom = lerp(zoom, Vector2(new_zoom,new_zoom), step*delta)
