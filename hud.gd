extends Control



func _ready():
	pass # Replace with function body.



func _process(delta):
	$TextureRect/time.text = "Timer: " + str(global.time)
	
	$TextureRect/wave.text = "Wave: " + str(1)
	if global.time == 21: #wave2
		$TextureRect/wave.text = "Wave: " + str(2)
	elif global.time == 41: #wave3
		$TextureRect/wave.text = "Wave: " + str(3)
	elif global.time == 61: #wave4
		$TextureRect/wave.text = "Wave: " + str(4)
	elif global.time == 81: #wave5
		$TextureRect/wave.text = "Wave: " + str(5)
