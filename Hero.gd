extends Spatial




# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera.set_current(true)
	$Camera.set_position(Vector3(0, 10, 0))
	$Camera.rotate(Vector3(0, 0, 0))


