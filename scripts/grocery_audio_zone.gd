extends Area3D

var active = false
func _process(delta: float) -> void:
	var target = 1.0
	if (not active):
		target = 0.0
	$Grocery.volume_linear = lerp($Grocery.volume_linear, target, delta*0.5)
	$Outside.volume_linear = lerp($Outside.volume_linear, (1.0-target)*0.6, delta*0.5)
func _on_body_entered(body: Node3D) -> void:
	if (body.is_in_group("Player")):
		print("entered the store")
		active = true
	pass # Replace with function body.


func _on_body_exited(body: Node3D) -> void:
	if (body.is_in_group("Player")):
		print("exited the store")
		active = false
