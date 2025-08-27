extends StaticBody3D

var active = false

var state = "idle" #idle, moving, scanning, pay, pickup

var stateTimer = 0.0;

func _ready():
	$moving.hide()
	$pay_box.hide()
	$pay_box.hide()
	$bag.hide()

func scanItem():
	for slot in $moving.get_children():
		if (slot.visible):
			slot.hide()
			return
	state = "pay"

func _process(delta):
	if (state == "idle"):
		$moving.position.z = 2.15;
	if state == "moving":
		$moving.position.z -= delta * 0.25
		if ($moving.position.z <= 0):
			state = "scanning"
			stateTimer = 0.0
	elif state == "scanning":
		stateTimer += delta
		if (stateTimer > 1.5):
			scanItem()
			stateTimer = 0.0;
		pass
	elif state == "pay":
		$pay_box.show()
		$screen.show();
	elif state == "pickup":
		$bag.show()
		if ($bag.get_children().size() < 1):
			state = "idle"
			
	
func _on_use(player):
	if (state != "idle"):
		return
	print("conveyor used!")
	state = "moving"
	$moving.show()
	
	var slotnum : int = 0
	for slot in $moving.get_children():
		slot.texture = Inventory.getCartIcon(slotnum)
		slotnum+=1
	Inventory.shopping_cart.clear()
	Inventory.isDirty = true
	pass
