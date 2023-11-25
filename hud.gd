extends Control



func _ready():
	pass # Replace with function body.



func _process(delta):
	$TextureRect/time.text = "Timer: " + str(global.time)
