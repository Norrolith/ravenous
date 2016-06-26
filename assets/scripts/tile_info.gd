
extends TileMap
var ter_dirt=[0,1,2,3]
var ter_wall=[4,5,6,7]


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func choose_tile(tiletype):
	"""Chooses a terrain tile from the named terrain list"""
	var length= tiletype.size()
	return tiletype[randi()%length]
	

func check_area_contains(x1,y1,x2,y2,tiletype):
	"""Chek if an area contains something. 
	you can call it with your own array to check for multiple things"""
	var width= x2-x1
	var height= y2-y1
	var map = get_node("/root/main/world_map")
	var checked_cell
	for xloop in range(width):
		for yloop in range(height):
			checked_cell=map.get_cell(x1+xloop,y1+yloop)
			if checked_cell in tiletype:
				return true

func check_area_contains_amount(x1,y1,x2,y2,tiletype):
	"""Check how much of something an area contains"""
	var width= x2-x1
	var height= y2-y1
	var map = get_node("/root/main/world_map")
	var checked_cell
	var amount=0
	for xloop in range(width):
		for yloop in range(height):
			checked_cell=map.get_cell(x1+xloop,y1+yloop)
			if checked_cell in tiletype:
				amount+=1
	print(str(amount))
	print("am I called?")
	return amount