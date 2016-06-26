
extends TileMap
var wx=50
var wy=50
var gen_width=100
var gen_height=100
var cells_cleared=0

func _ready():
	my_build_level()

func my_build_level():
	#variables that need to be reset
	cells_cleared=0
	wx=50
	wy=50
	randomize()
	self.clear()
	

	#Now the map has been cleared and filled, randomize starting point

	print(str(self.get_used_cells().size()))
	print(str(gen_height*gen_width*0.5))
	#as a test, make 500 random holes
	while(cells_cleared<5000):
		my_update_drunk()
		my_clear_cell(wx,wy)
	print(str(cells_cleared))
	my_build_walls()
	
	
func my_clear_cell(inx,iny):
	if((self.get_cell(inx,iny)==-1)):
		#var new_tile=tile_info.choose_tile(tile_info.ter_dirt)
		var new_tile=tile_info.choose_tile(tile_info.ter_dirt)
		self.set_cell(inx,iny,new_tile,false,false,false)
		cells_cleared+=1


func my_update_drunk():
	var tempx=wx
	var tempy=wy
	#choose an axis
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
	#now check to make sure we have not left the grid.
	#if we are on the border, move back.
	wx=tempx
	wy=tempy

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
	for xloop in range(gen_width):
		for yloop in range(gen_height):
			if (self.get_cell(xloop,yloop)==-1):
				if tile_info.check_area_contains(xloop-1,yloop-1,xloop+2,yloop+2,tile_info.ter_dirt):
					#var new_tile=tile_info.choose_tile(tile_info.ter_wall)
					var new_tile=tile_info.choose_tile(tile_info.ter_wall)
					self.set_cell(xloop,yloop,new_tile,false,false,false)
	
