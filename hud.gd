extends Control

@onready var player = global.target

func _ready():
	pass # Replace with function body.



func _process(delta):
	$VBoxContainer/capacity.value = player.capacity
	$VBoxContainer/capacity.max_value = player.max_capacity
	$VBoxContainer/time.text = "Timer: " + str(global.time)
	
	$VBoxContainer/wave.text = "Wave: " + str(1)
	if global.time >= 21: #wave2
		$VBoxContainer/wave.text = "Wave: " + str(2)
	if global.time >= 41: #wave3
		$VBoxContainer/wave.text = "Wave: " + str(3)
	if global.time >= 61: #wave4
		$VBoxContainer/wave.text = "Wave: " + str(4)
	if global.time >= 81: #wave5
		$VBoxContainer/wave.text = "Wave: " + str(5)
