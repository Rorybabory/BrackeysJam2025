extends Control

func _ready():
	pass
func redrawInventory():
	Inventory.isDirty = false
	var slotnum : int = 0
	for slot in $slots.get_children():
		slot.texture = Inventory.getCartIcon(slotnum)
		slotnum+=1
func _process(delta):
	if (Inventory.isDirty):
		redrawInventory()
