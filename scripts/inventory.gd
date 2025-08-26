extends Node
var shopping_cart : Array[Item] = []
var isDirty = true
var icons : Dictionary = {
	"empty" : preload("res://sprites/empty.png"),
	"biscuit" : preload("res://sprites/biscuit.png")
}

func addToCart(item : String):
	isDirty = true
	shopping_cart.append(Item.new(item))

func getCartIcon(index : int):
	if (index >= shopping_cart.size()):
		return icons["empty"]
	return icons[shopping_cart[index].name]
