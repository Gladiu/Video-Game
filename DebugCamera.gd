extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		set_h_offset(get_h_offset()+5)
	if Input.is_action_just_pressed("ui_left"):
		set_h_offset(get_h_offset()-5)
	if Input.is_action_just_pressed("ui_up"):
		set_v_offset(get_v_offset()+5)
	if Input.is_action_just_pressed("ui_down"):
		set_v_offset(get_v_offset()-5)
