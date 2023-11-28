extends Control

@onready var player = global.target
@onready var wavebar = $"wavebar"

var secs = 0
var mins = 0

var wave2 = true
var wave3 = true
var wave4 = true
var wave5 = true

func _ready():
	$VBoxContainer/wave.text = "Wave: " + str(1)
	pass # Replace with function body.



func _process(delta):
	secs = fmod(global.time,60)
	mins = fmod(global.time,60*60) / 60
	$VBoxContainer/capacity.value = player.capacity
	$VBoxContainer/capacity.max_value = player.max_capacity
	$VBoxContainer/time.text = "Timer: %02d:%02d" % [mins,secs]
	if global.time == 22 and wave2: #wave2
		$VBoxContainer/wave.text = "Wave: " + str(2)
		wavebar.max_value = 47-22
		wave2 = false
	if global.time == 47 and wave3: #wave3
		$VBoxContainer/wave.text = "Wave: " + str(3)
		wavebar.max_value = 72-47
		wave3 = false
	if global.time == 72 and wave4: #wave4
		$VBoxContainer/wave.text = "Wave: " + str(4)
		wavebar.max_value = 97-72
		wave4 = false
	if global.time == 97 and wave5: #wave5
		$VBoxContainer/wave.text = "Wave: " + str(5)
		wavebar.max_value = 1
		wave5 = false
	if not wave5:
		wavebar.value = global.time-97
	elif not wave4:
		wavebar.value = global.time-72
	elif not wave3:
		wavebar.value = global.time-47
	elif not wave2:
		wavebar.value = global.time-22
	else:
		wavebar.value = global.time


