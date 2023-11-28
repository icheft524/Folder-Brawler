extends Node2D

@onready var normal = $normal
@onready var ads = $ads
@onready var big = $big
@onready var zip = $zip
@onready var enc = $enc

var tutorial = true
var mouse_close_in = false
var already_clicked = false
#@export var close =  Vector2(0.8,0.8)

var wave2 = true
var wave3 = true
var wave4 = true
var wave5 = true
var wave6 = true

func _ready():
	if tutorial == true:
		get_tree().paused = true
		normal.visible = true
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.time == 22 and wave2: #wave2 big
		get_tree().paused = true
		big.visible = true
	if global.time == 47 and wave3: #wave3 enc
		get_tree().paused = true
		enc.visible = true
	if global.time == 72 and wave4: #wave4 zip
		get_tree().paused = true
		zip.visible = true
	

func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("leftclick") && mouse_close_in && !already_clicked && !global.inv_open:
			already_clicked = true
			get_viewport().set_input_as_handled()
			#var tween_close = create_tween()
			#tween_close.tween_property(self,"scale",close,0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
			#tween_close.play()


func _on_normal_mouse_entered():
	mouse_close_in = true


func _on_normal_mouse_exited():
	mouse_close_in = false
	normal.visible = false
	ads.visible = true



func _on_ads_mouse_entered():
	mouse_close_in = true


func _on_ads_mouse_exited():
	mouse_close_in = false
	ads.visible = false
	get_tree().paused = false


func _on_big_mouse_entered():
	mouse_close_in = true


func _on_big_mouse_exited():
	mouse_close_in = false
	big.visible = false
	wave2 = false
	get_tree().paused = false


func _on_enc_mouse_entered():
	mouse_close_in = true


func _on_enc_mouse_exited():
	mouse_close_in = false
	enc.visible = false
	wave3 = false
	get_tree().paused = false


func _on_zip_mouse_entered():
	mouse_close_in = true


func _on_zip_mouse_exited():
	mouse_close_in = false
	zip.visible = false
	wave4 = false
	get_tree().paused = false
