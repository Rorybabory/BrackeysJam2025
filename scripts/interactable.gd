extends StaticBody3D

@export var itemName : String = "biscuit"

func _ready():
	$Sprite3D.texture = Inventory.icons[itemName]

func _process(delta):
	pass

func _on_use(player):
	if (not visible):
		return
	Inventory.addToCart(itemName)
	queue_free()
