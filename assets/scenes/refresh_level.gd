
extends Node2D
var map
# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	map = get_node("/root/main/world_map")
	set_process(true)
	
	pass
	
func _process(delta):
	if(Input.is_action_pressed("ui_accept")):
		map.my_build_level()


