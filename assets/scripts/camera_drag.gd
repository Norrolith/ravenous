
extends Camera2D

var jumped=false

func _ready():
	set_process(true)
	self.make_current()
	pass
func _process(delta):
	if(Input.is_mouse_button_pressed(BUTTON_LEFT) and !jumped):
		set_pos(get_viewport().get_mouse_pos())
		jumped=true
		Input.warp_mouse_pos(get_pos())
	else:
		if(!Input.is_mouse_button_pressed(BUTTON_LEFT) and jumped):
			jumped=false


