extends Spatial



func _ready():
	pass 

func set_pos(pos):
	var temp_transform = get_transform().origin
	# Input is vector 2D for now so im casting it to 3D coordinates 
	temp_transform.x = pos.x
	temp_transform.z = pos.y
	set_transform(Transform(get_transform().basis, temp_transform))


