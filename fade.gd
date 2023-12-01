extends Sprite2D

@onready var cam = $"../cam"
@onready var inventory = $"../folder_inventory"

func _ready():
	modulate.a = 0.75
	pass
func _process(delta):
	if global.on_upgrade:
		visible = true
		inventory.close()
	else:
		visible = false
	pass
