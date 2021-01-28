extends Node

var dungeon_scene
var dungeon_node
var hero_scene
var hero_node
var enemy_scene
var enemy_node
var camera
# Update viewport size whenever changed pls
var viewport_size



# Called when the node enters the scene tree for the first time.
func _ready():
	# Loading Dungeon scene
	dungeon_scene = preload("res://Dungeon.tscn")
	dungeon_node = dungeon_scene.instance()
	add_child(dungeon_node)
	dungeon_node.get_world().space
	dungeon_node.get_spawn_spaces()
	
	# Loading Hero scene
	hero_scene = preload("res://Hero.tscn")
	hero_node = hero_scene.instance()
	add_child(hero_node)
	
	# Loading Enemy scene
	enemy_scene = preload("res://Enemy.tscn")
	enemy_node = enemy_scene.instance()
	add_child(enemy_node)
	
	# Setting camera node
	camera = $Camera
	#viewport_size = get_viewport().get_



const ray_length = 1000

func _process(delta):
	if Input.is_action_pressed("mouse_left"):
		var from = camera.project_ray_origin(get_viewport().get_mouse_position())
		var to = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * ray_length
		var dungeon_collision_shape = dungeon_node.get_world().direct_space_state
		var result = dungeon_collision_shape.intersect_ray(from, to)
		if result.size() > 0 :
			hero_node.walk(result.position)#dungeon_node.get_closesest_valid_space_to_move(hero_node.get_transform().origin, result.position))
	var camera_pos = camera.get_transform().origin
	camera_pos.x = hero_node.get_transform().origin.x+30
	camera_pos.z = hero_node.get_transform().origin.z+30
	camera.set_transform(Transform(camera.get_transform().basis, camera_pos))

