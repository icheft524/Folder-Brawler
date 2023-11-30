extends Sprite2D

@onready var cam = $"../cam"

func _ready():
	modulate.a = 0.75
	pass
func _process(delta):
	if global.on_upgrade:
		visible = true
	else:
		visible = false
	pass
