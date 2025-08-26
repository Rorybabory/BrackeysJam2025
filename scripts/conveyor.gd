extends StaticBody3D

var active = false

func _ready():
	pass

func _process(delta):
	if active:
		$Bar.position.z -= delta * 0.25
		if ($Bar.position.z <= 0):
			active = false
	pass
func _on_use(player):
	print("conveyor used!")
	active = true
	$Bar.show()
	pass
