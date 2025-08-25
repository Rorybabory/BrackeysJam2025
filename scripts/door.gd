extends Node3D

var open : bool = false;
var closeTimer : float = 0.0
func _ready():
	pass

func _process(delta):
	if open and $hinge.rotation_degrees.y < 90.0:
		$hinge.rotation_degrees.y += delta * 45.0;
	if (open and $hinge.rotation_degrees.y >= 90.0):
		if (closeTimer < 5.0):
			closeTimer += delta
		else:
			open = false
	if (not open and $hinge.rotation_degrees.y > 0.0):
		closeTimer = 0.0	
		$hinge.rotation_degrees.y -= delta * 45.0;

func _on_trigger_body_entered(body: Node3D) -> void:
	if (body.is_in_group("Player")):
		if (open == false):
			open = true
	pass # Replace with function body.
