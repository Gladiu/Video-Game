extends Spatial




func _ready():
	generate_dungeon_floor(2)

func make_room_tiles_at(room_center):
	var tile_array = []
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var room_width = rng.randi_range(3,6)
	var room_height = rng.randi_range(3,6)
	
	for x in range(int((room_width/2)-room_width),int(room_width/2)):
		for y in range(int((room_height/2)-room_width),int(room_height/2)):
			tile_array.push_back(Vector2(x+room_center.x,y+room_center.y))
	return tile_array

func get_valid_direction_of_room(center_of_last_room):
	var anwser := Vector2(0.0, 0.0)
	var generating = true
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
		$Floor.set_cell_item(tile.x, 0, tile.y, 1)
		
	# Generating next rooms if number_of_rooms > 1
	for current_room in range(number_of_rooms-1):
		for tile in current_room_tiles:
			$Floor.set_cell_item(tile.x, 0, tile.y, 1)
		
		direction_of_room = get_valid_direction_of_room(position_of_room)
		lenght_of_corridor = rng.randi_range(20, 30)
		for i in range(lenght_of_corridor):
			$Floor.set_cell_item(position_of_room.x+direction_of_room.x+i*int(direction_of_room.x>0), 0, position_of_room.y+direction_of_room.y+i*int(direction_of_room.y>0), 1)
		position_of_room += lenght_of_corridor*direction_of_room
		current_room_tiles = make_room_tiles_at(position_of_room)
