
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)
	
	pass
	
func _process(delta):
	if(Input.is_action_pressed("ui_accept")):
		print("Void right now")
		#tile_info.map.my_build_level()


