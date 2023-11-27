extends Control

@onready var player = global.target

var secs = 0
var mins = 0

func _ready():
	pass # Replace with function body.



func _process(delta):
	secs = fmod(global.time,60)
	mins = fmod(global.time,60*60) / 60
	$VBoxContainer/capacity.value = player.capacity
	$VBoxContainer/capacity.max_value = player.max_capacity
	$VBoxContainer/time.text = "Timer: %02d:%02d" % [mins,secs]
	
	$VBoxContainer/wave.text = "Wave: " + str(1)
	if global.time >= 21: #wave2
		$VBoxContainer/wave.text = "Wave: " + str(2)
	if global.time >= 41: #wave3
		$VBoxContainer/wave.text = "Wave: " + str(3)
	if global.time >= 61: #wave4
		$VBoxContainer/wave.text = "Wave: " + str(4)
	if global.time >= 81: #wave5
		$VBoxContainer/wave.text = "Wave: " + str(5)
