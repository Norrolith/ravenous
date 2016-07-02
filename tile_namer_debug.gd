
extends Label



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	
func _process(delta):
	
	var pos=get_node("/root/main").get_global_mouse_pos()
	var tile_pos=tile_info.map.world_to_map(pos)
	var amount=tile_info.check_area_contains_amount(tile_pos.x-1,tile_pos.y-1,tile_pos.x+2,tile_pos.y+2,[-1])
	#var amount= tile_info.get_neighbors_in(tile_pos,[-1])
	var tile=tile_info.map.get_cellv(tile_info.map.world_to_map(pos))
	var output_text=""
	output_text=output_text+"Position:" + str(tile_pos)
	output_text=output_text+"\nAdjacent walls:" + str(amount)
	output_text = output_text+ "\nPresent tile: " + str(tile)
	set_pos(Vector2(pos.x+10,pos.y))
	set_text(output_text)
	"""
	var pos=get_node("/root/main").get_global_mouse_pos()
	var tile=tile_info.map.get_cellv(tile_info.map.world_to_map(pos))
	set_pos(pos)
	set_text("       "+str(tile))
	"""
