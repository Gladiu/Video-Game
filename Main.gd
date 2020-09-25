extends Node

var dungeon_scene
var dungeon_node
var hero_scene
var hero_node




# Called when the node enters the scene tree for the first time.
func _ready():
	# Loading Dungeon scene
	dungeon_scene = preload("res://Dungeon.tscn")
	dungeon_node = dungeon_scene.instance()
	add_child(dungeon_node)
	
	# Loading Hero scene
	hero_scene = preload("res://Hero.tscn")
	hero_node = dungeon_scene.instance()
	add_child(hero_node)
	
	# Setting up camera position
	var camera_transform = $Camera.get_camera_transform()
	camera_transform.origin.y += 30
	$Camera.transform = camera_transform
	
func _process(delta):
	var movement = Vector2(0,0)
	if Input.is_action_just_pressed("ui_up"):
		movement = Vector2(-1,-1)
	if Input.is_action_just_pressed("ui_down"):
		movement = Vector2(1,1)
	if Input.is_action_just_pressed("ui_left"):
		movement = Vector2(-1,1)
	if Input.is_action_just_pressed("ui_right"):
		movement = Vector2(1,-1)
	if movement.x != 0 or movement.y != 0:
		$Camera.transform.origin.x += movement.normalized().x
		$Camera.transform.origin.z += movement.normalized().y
