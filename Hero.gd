extends Spatial

var movement := Vector2()
var destination := Vector2()
var walking = false
var speed = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if _reached_destination(delta):
		walking = false
	if walking:
		var current_pos = get_transform().origin
		var current_movement
		current_movement = Vector3((movement.x*delta), 0, (movement.y*delta)) 
		if $KinematicBody.test_move(get_transform(), Vector3(0 ,0, (movement.y*delta)) ):
			current_movement.z = 0
		if $KinematicBody.test_move(get_transform(), Vector3((movement.x*delta), 0, 0) ):
			current_movement.x = 0
			
		set_transform(Transform(get_transform().basis, current_pos + current_movement))


func walk(position):
	destination = Vector2(position.x, position.z)
	var starting_pos = Vector2(get_transform().origin.x, get_transform().origin.z)
	movement = Vector2(position.x, position.z)-starting_pos
	movement = movement.normalized()*speed
	walking = true
	
func _reached_destination(delta):
	var current_pos = get_transform().origin
	# Casting position to Vector2
	current_pos = Vector2(current_pos.x, current_pos.z);
	var true_movement = destination-current_pos
	if true_movement.x != 0 and true_movement.x/abs(true_movement.x) != movement.x/abs(movement.x):
		return true
	if true_movement.y != 0 and true_movement.y/abs(true_movement.y) != movement.y/abs(movement.y):
		return true
	else:
		return false

func _has_hit_wall(delta):
	var current_pos = Vector2(get_transform().origin.x, get_transform().origin.z)
	#print($KinematicBody.test_move(get_transform(), Vector3((movement.x*delta), 0, (movement.y*delta)) ))
	if $KinematicBody.test_move(get_transform(), Vector3((movement.x*delta), 0, (movement.y*delta)) ):
		destination = current_pos
