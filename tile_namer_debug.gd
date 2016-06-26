
extends Label



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	
func _process(delta):
	"""
	var pos=get_node("/root/main").get_global_mouse_pos()
	var tile=tile_info.map.get_cellv(tile_info.map.world_to_map(pos))
	set_pos(pos)
	set_text("       "+str(tile))
	"""
