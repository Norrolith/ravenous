
extends Node2D
export (PackedScene) var spawn
# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)
	
	pass
	
func _process(delta):
	if(Input.is_action_pressed("ui_accept")):
		var temp=get_child(1)
		temp.queue_free()
		temp=spawn.instance()
		add_child(temp)


