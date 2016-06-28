
extends TileMap
var wx=50
var wy=50
var gen_width=100
var gen_height=100
var cells_cleared=0
var constrained_mode=true
var gen_pools_amount=randi()%5 + 5

func _ready():
	tile_info.map = self
	my_build_level()

func my_build_level():
	#variables that need to be reset
	cells_cleared=0
	wx=50
	wy=50
	tile_info.pos_pools=[]
	randomize()
	self.clear()
	
	#Initial floor placement
	while(cells_cleared<(gen_height*gen_width*0.5)):
		my_update_drunk()
		my_clear_cell(wx,wy)
	print(str(cells_cleared)+" floors placed")
	my_build_walls()
	print("Walls built")

	for pool in range(gen_pools_amount):
		my_place_pool((randi()%300)+25)
	print("Placed "+str(gen_pools_amount)+ " pools of slime.")
	my_edge_pools()


	
func my_clear_cell(inx,iny):
	if((self.get_cell(inx,iny)==-1)):
		#var new_tile=tile_info.choose_tile(tile_info.ter_dirt)
		var new_tile=tile_info.choose_tile(tile_info.ter_dirt)
		self.set_cell(inx,iny,new_tile,false,false,false)
		cells_cleared+=1
		
func my_wobble_vector(inputv):
	"""Takes a vector and moves it by one in a cardinal direction"""
	var tempx=inputv.x
	var tempy=inputv.y
	if(randi()%2==1):
		#choose a direction
		if(randi()%2==1):
			tempx+=1
		else:
			tempx-=1
	else:
		#other axis
		if(randi()%2==1):
			tempy+=1
		else:
			tempy-=1
	return Vector2(tempx,tempy)

func my_update_drunk():
	var tempv=Vector2(wx,wy)
	tempv=my_wobble_vector(tempv)
	wx=tempv.x
	wy=tempv.y
	if (constrained_mode):
		if (wx==0):
			wx=1
		if (wx==gen_width-1):
			wx=gen_width-2
		#now handle up down
		if (wy==0):
			wy=1
		if (wy==gen_height-1):
			wy=gen_height-2
	#now we have set and fixed tempy and tempx
	
func my_build_walls():
	"""Loop over all empty tiles, and if they border a floor, they become a wall"""
	for xloop in range(gen_width):
		for yloop in range(gen_height):
			if (self.get_cell(xloop,yloop)==-1):
				if tile_info.check_area_contains(xloop-1,yloop-1,xloop+2,yloop+2,tile_info.ter_dirt):
					#var new_tile=tile_info.choose_tile(tile_info.ter_wall)
					var new_tile=tile_info.choose_tile(tile_info.ter_wall)
					self.set_cell(xloop,yloop,new_tile,false,false,false)
	
func my_place_pool(amount):
	"""Places a pool at a random location
	then grows it using random walks from that location"""
	
	var start_pos
	var tiles_placed=0
	var locations
	start_pos=tile_info.find_position_in(tile_info.ter_dirt)
	
	print("Calling get area with:"+str(start_pos))
	self.set_cellv(start_pos,tile_info.choose_tile(tile_info.ter_ooze),false,false,false)
	locations=tile_info.find_area(start_pos,amount,tile_info.ter_dirt)
	for tile in locations:
		self.set_cellv(tile,tile_info.choose_tile(tile_info.ter_ooze),false,false,false)
		tile_info.pos_pools.append(tile)


func my_edge_pools():
	for pool in tile_info.pos_pools:
		var above_tile=self.get_cellv(Vector2(pool.x,pool.y-1))
		if above_tile in tile_info.ter_dirt:
			self.set_cellv(pool,12)
			
	
