extends Control

@onready var player = global.target
@onready var itemoption = get_tree().get_nodes_in_group("itemoption")
@onready var wavebar = $upgrade/wavebar
@onready var cam = $"../cam"

var secs = 0
var mins = 0

var wave2 = true
var wave3 = true
var wave4 = true
var wave5 = true
var wave6 = true

func _ready():
	itemoption[0].connect("upgrade",upgraded)
	itemoption[1].connect("upgrade",upgraded)
	$wave.text = str(1)
	pass # Replace with function body.

func upgraded():
	$upgrade/upgradeanim.play("loading")
	cam.force_pointer = false

func upgradeready():
	$upgrade/upgradeanim.play("upgradeready")
	cam.force_pointer = true

func _process(delta):
	secs = fmod(global.time,60)
	mins = fmod(global.time,60*60) / 60
	$capacity.value = player.capacity
	$capacity.max_value = player.max_capacity
	$time.text = "%02d:%02d" % [mins,secs]
	if $capacity.value == $capacity.max_value:
		$capacity.set_self_modulate('f00000')
	if $capacity.value != $capacity.max_value:
		$capacity.set_self_modulate('ffffff')
	if global.time == 22 and wave2: #wave2
		upgradeready()
		$wave.text = str(2)
		wavebar.max_value = 47-22
		wave2 = false
	if global.time == 47 and wave3: #wave3
		upgradeready()
		$wave.text = str(3)
		wavebar.max_value = 72-47
		wave3 = false
	if global.time == 72 and wave4: #wave4
		upgradeready()
		$wave.text = str(4)
		wavebar.max_value = 97-72
		wave4 = false
	if global.time == 97 and wave5: #wave5
		upgradeready()
		$wave.text = str(5)
		wavebar.max_value = 132-97
		wave5 = false
	if global.time == 132 and wave6: #wave6
		upgradeready()
		$wave.text = str(5)
		wavebar.max_value = 1
		wave6 = false
		
	if not wave6:
		wavebar.value = global.time-132
	elif not wave5:
		wavebar.value = global.time-97
	elif not wave4:
		wavebar.value = global.time-72
	elif not wave3:
		wavebar.value = global.time-47
	elif not wave2:
		wavebar.value = global.time-22
	else:
		wavebar.value = global.time


