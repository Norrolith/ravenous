
extends TileMap
var ter_dirt=[1,7]
var ter_wall=[2,8]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func choose_tile(tiletype):
	"""Chooses a terrain tile from the named terrain list"""
	var length= tiletype.size()
	return randi()%length

func check_area_contains(x1,y1,x2,y2,tiletype):
	"""Chek if an area contains something. 
	you can call it with your own array to check for multiple things"""
	var width= x2-x1
	var height= y2-y1
	var checked_cell
	for xloop in range(width):
		for yloop in range(height):
			checked_cell=self.get_cell(x1+xloop,y1+yloop)
			print(str(checked_cell))
	if checked_cell in tiletype:
		return true
		print("I said yes")
	else:
		print("I said no")
		return false