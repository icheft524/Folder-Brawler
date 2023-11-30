extends Node2D

@onready var image = $image
@onready var close_but = $"image/close"

var mouse_close_in = false
var already_clicked = false
var normal = Vector2(0.369,0.274)
#@export var close =  Vector2(0.8,0.8)

var wave2 = true
var wave3 = true
var wave4 = true
var pop =  Vector2(0.05,0.05)
var close =  Vector2(0.1,0.1)


func _ready():
	showpo(global.pop_start_tutorial)
	global.pop_start_tutorial = true
	

func showpo(is_show: bool):
	if !is_show:
		get_tree().paused = true
		image.visible = true
		close_but.visible = true
		image.scale = normal
		var tween = create_tween()
		tween.tween_property(image,"scale",normal + pop,0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		tween.play()

func closepo():
	image.visible = false
	close_but.visible = false
	if !global.on_upgrade:
		get_tree().paused = false

func _process(delta):
	if image.scale < Vector2(0.3,0.3):
		closepo()
	if global.time == 22 and wave2: #wave2 big
		_ready()
		wave2 = false

	if global.time == 47 and wave3: #wave3 enc
		_ready()
		wave3 = false

	if global.time == 72 and wave4: #wave4 zip
		_ready()
		wave4 = false



func _on_close_pressed():
	var tween_close = create_tween()
	tween_close.tween_property(image,"scale",normal - close,0.4).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween_close.play()
