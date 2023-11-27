extends Camera2D

@export var shake_power = 4
@export var big_shake_power = 10
@export var shake_time = 0.2
@export var big_shake_time = 0.5
var isShake = false
var curPos
var elapsedtime = 0

func _ready():
	randomize()
	curPos = offset

func _process(delta):
	if global.shaking:
		shake(delta)
	if global.big_shaking:
		big_shake(delta)
	
	
func shake(delta):
	if elapsedtime<shake_time:
		offset =  Vector2(randf(), randf()) * shake_power
		elapsedtime += delta
	else:
		global.shaking = false
		elapsedtime = 0
		offset = curPos

func big_shake(delta):
	if elapsedtime<big_shake_time:
		offset =  Vector2(randf(), randf()) * big_shake_power
		elapsedtime += delta
	else:
		global.big_shaking = false
		elapsedtime = 0
		offset = curPos
