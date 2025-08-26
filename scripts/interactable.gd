extends StaticBody3D

@export var itemName : String = "biscuit"

func _ready():
	pass

func _process(delta):
	pass

func _on_use(player):
	Inventory.addToCart(itemName)
	queue_free()
