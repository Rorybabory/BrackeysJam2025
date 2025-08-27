extends StaticBody3D

var timer : float = 0.0
var active = false
func _process(delta: float) -> void:
	if (active):
		timer+=delta
		if (timer > 1.5):
			$debit_card.hide()
			get_node("../").state = "pickup"

func _on_use(player):
	if (visible):
		$indicator.hide()
		$debit_card.show()
		active = true;
