extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$cri.play("critical")

func _on_timer_timeout():
	queue_free()
