extends Spatial

var spawn_coordinates



func _ready():
	generate_dungeon_floor(7)
	generate_walls()
	
#func _physics_process(delta):
#	var space_state = get_world().direct_space_state

func make_room_tiles_at(room_center):
	var tile_array = []
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var room_width = rng.randi_range(6,12)
	var room_height = rng.randi_range(6,12)
	
	for x in range(int((room_width/2)-room_width),int(room_width/2)):
		for y in range(int((room_height/2)-room_height),int(room_height/2)):
			tile_array.push_back(Vector2(x+room_center.x,y+room_center.y))
	return tile_array

func get_valid_direction_of_room():
	var anwser := Vector2(0.0, 0.0)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	match(rng.randi_range(0,3)):
		0:
			anwser = Vector2(-1, 0)
		1:
			anwser = Vector2(0, 1)
		2:
			anwser = Vector2(1, 0)
		3:
			anwser = Vector2(0, -1)
	return anwser

func generate_dungeon_floor(number_of_rooms):
	var direction_of_room
	var lenght_of_corridor
	var position_of_room := Vector2(0, 0)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# Generating first room
	var current_room_tiles = make_room_tiles_at(position_of_room)
	for tile in current_room_tiles:
		$Environment/Floor.set_cell_item(tile.x, 0, tile.y, 1)
		
	# Generating next rooms if number_of_rooms > 1
	for _current_room in range(number_of_rooms-1):
		# Generating corridor connecting two generated rooms
		direction_of_room = get_valid_direction_of_room()
		lenght_of_corridor = rng.randi_range(10, 20)
		var pos_of_tile = position_of_room
		for _i in range(lenght_of_corridor):
			pos_of_tile.x += direction_of_room.x
			pos_of_tile.y += direction_of_room.y
			$Environment/Floor.set_cell_item(pos_of_tile.x, 0, pos_of_tile.y, 1)
		
		# 33,33% of chance that corridor will be twice as thick
		if rng.randi_range(0, 2) == 1:
			pos_of_tile = position_of_room
			pos_of_tile.x += int(direction_of_room.y != 0)
			pos_of_tile.y += int(direction_of_room.x != 0)
			for _i in range(lenght_of_corridor):
				pos_of_tile.x += direction_of_room.x
				pos_of_tile.y += direction_of_room.y
				$Environment/Floor.set_cell_item(pos_of_tile.x, 0, pos_of_tile.y, 1)
		
		# Generating next room
		position_of_room += lenght_of_corridor*direction_of_room
		current_room_tiles = make_room_tiles_at(position_of_room)
		for tile in current_room_tiles:
			$Environment/Floor.set_cell_item(tile.x, 0, tile.y, 1)

func generate_walls():
	var tiles = $Environment/Floor.get_used_cells()
	for tile in tiles:
		for x in range(-1, 2):
			for z in range(-1, 2):
				if $Environment/Floor.get_cell_item(tile.x+x, tile.y, tile.z+z) != 1:
					$Environment/Wall.set_cell_item(tile.x+x, tile.y, tile.z+z, 0)
	tiles = $Environment/Wall.get_used_cells()
	for tile in tiles:
		$Environment/Wall2.set_cell_item(tile.x, tile.y, tile.z, 0)

func get_spawn_spaces():
	var cells_array = $Environment/Wall.get_used_cells()
	print(cells_array[1].x)

