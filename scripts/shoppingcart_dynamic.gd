extends RigidBody3D

var playerUsing : bool = false

func _ready():
	pass

func _process(delta):
	if (playerUsing):
		position = position.lerp(Vector3(0,0,0), delta * 20.0)
		rotation_degrees = rotation_degrees.slerp(Vector3(0,0,0), delta*20.0)
	pass

func _on_use(player):
	print("Using shopping cart")
	get_node("../").remove_child(self)
	player.get_node("CartAttach").add_child(self)
	position = Vector3(0,0,0)
	rotation_degrees = Vector3(0,0,0)
	playerUsing = true
