
extends Camera2D

var jumped=false

func _ready():
	set_process(true)
	self.make_current()
	pass
func _process(delta):
	var pos=get_node("/root/main").get_global_mouse_pos()
	if(Input.is_mouse_button_pressed(BUTTON_LEFT) and !jumped):
		set_pos(pos)
		jumped=true
	else:
		if(!Input.is_mouse_button_pressed(BUTTON_LEFT) and jumped):
			jumped=false


