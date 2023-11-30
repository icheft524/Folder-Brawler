extends Sprite2D


func _ready():
	modulate.a = 0.75
	pass
func _process(delta):
	if global.on_upgrade:
		visible = true
	else:
		visible = false
	pass
