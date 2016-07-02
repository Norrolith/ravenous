
extends TileMap
var ter_dirt=[0,1,2,3]
var ter_wall=[4,5,6,7]
var ter_ooze=[8,9,10,11,11,11,11]
var pos_pools=[]
var map

func _ready():

	# Initialization here
	var map = get_node("/root/main/world_map")
	pass
	
func get_map():
	return get_node("/root/main/world_map")
	

func choose_tile(tiletype):
	"""Chooses a terrain tile from the named terrain list"""
	var length= tiletype.size()
	return tiletype[randi()%length]
	

func check_area_contains(x1,y1,x2,y2,tiletype):
	"""Check if an area contains something. 
	you can call it with your own array to check for multiple things"""
	var width= x2-x1
	var height= y2-y1
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
	var checked_cell
	var amount=0
	for xloop in range(width):
		for yloop in range(height):
			checked_cell=map.get_cell(x1+xloop,y1+yloop)
			if checked_cell in tiletype:
				amount +=1
	return amount
	
func find_position_in(tiletype):
	"""Finds a random tile of the given type"""
	var pos = Vector2(0,0)
	var done=false
	while !done:
		if (map.get_cellv(pos) in tiletype):
			return pos
			done=true
		else:
			pos.x=(randi()%(map.gen_width-2))+1
			pos.y=(randi()%(map.gen_height-2))+1

func get_neighbors_in(startpos,tiletype):
	var positions=[]
	var returned=[]
	positions.append(Vector2(1,0))
	positions.append(Vector2(0,1))
	positions.append(Vector2(-1,0))
	positions.append(Vector2(0,-1))
	for pos in positions:
		var new_pos=pos+startpos
		if map.get_cellv(new_pos)in tiletype:
			returned.append(new_pos)
	return returned

func get_neighbors_not_in(startpos,tiletype):
	var positions=[]
	var returned=[]
	positions.append(Vector2(1,0))
	positions.append(Vector2(0,1))
	positions.append(Vector2(-1,0))
	positions.append(Vector2(0,-1))
	for pos in positions:
		var new_pos=pos+startpos
		if !get_cellv(new_pos)in tiletype:
			returned.append(startpos+pos)
	return returned



func find_area(startpos,amount,passable):
	var connected = []
	var active = []
	var done = false
	
	connected.append(startpos)
	active.append(startpos)
	
	while !done:
		#choose a point in the active list
		var chosen=(randi()%active.size())
		#make a list of it's neighbors that are passable
		var possibles=[]
		var is_this_broken=active[chosen]
		for item in get_neighbors_in(is_this_broken,passable):
			possibles.append(item)
		
		if possibles.size()>0:
			#if the list is longer then zero, remove any already in connected
			var index=0
			for item in possibles:
				if item in connected:
					possibles.remove(index)
				index+=1
			#now choose one of the remainng
			if possibles.size()>0:
				var final_chosen=(randi()%possibles.size())
				#and add it to connected and active
				connected.append(possibles[final_chosen])
				active.append(possibles[final_chosen])
		#now check if the active position still has a neighbor.
		var expansions=[]
		expansions.append(get_neighbors_in(active[chosen],passable))
		#Remove any valid expansions that are in connected
		var expansion_increment=0
		for expansion in expansions:
				if expansion in connected:
					expansions.remove(expansion_increment)
				expansion_increment+=1
		#if there are no valid expansions, remove the position from active
		if expansions.size()==0:
			active.remove(chosen)
		#finally we compare the length of connected against amount
		if connected.size()>=amount:
			done = true
			print("Found an area " +str(amount)+" units big.")
		#If there are no points in active, the algorithm is done.
		if active.size()==0:
			done=true
	return connected
	
func copy_tilemap(node_in,node_out):
	for xloop in range(node_in.gen_width):
		for yloop in range(node_in.gen_height):
			var tile = node_in.get_cell(xloop,yloop)
			node_out.set_cell(xloop,yloop,tile,false,false,false)
