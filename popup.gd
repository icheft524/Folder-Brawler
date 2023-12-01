extends Node2D

@onready var image = $image
@onready var close_but = $"image/close"
@onready var mouse_cam = $"../cam"
@onready var folder = $"../folder"
@onready var folder_shadow = $"../folder/shadow"

var howto1 = preload("res://art/howtoplay/howtoplay.png")
var howto2 = preload("res://art/howtoplay/howtoplay2.png")
var howto3 = preload("res://art/howtoplay/howtoplay3.png")

var mouse_close_in = false
var already_clicked = false
var normal = Vector2(0.369,0.369)
#@export var close =  Vector2(0.8,0.8)

var wave2 = true
var wave3 = true
var wave4 = true
var pop =  Vector2(0.05,0.05)
var close =  Vector2(0.1,0.1)
var is_enter = false
var closed = false


func _ready():
	if global.pop_enter_tutorial:
		is_enter = true
	#showpo(howto1)
	global.pop_start_tutorial = true
	

func showpo( howtoimage):
	#if !is_show:
	#if global.pop_start_tutorial:
		#is_enter = true
	if !closed and !global.scene_reloaded:
		image.set_texture(howtoimage)
		get_tree().paused = true
		image.visible = true
		close_but.visible = true
		image.scale = normal
		mouse_cam.popup_mouse()
		var tween = create_tween()
		tween.tween_property(image,"scale",normal + pop,0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		tween.play()

func closepo():
	image.visible = false
	close_but.visible = false
	mouse_cam.close_popup()
	if !global.on_upgrade:
		get_tree().paused = false
	

func _process(delta):
	#if global.pop_enter_tutorial && !is_enter:
	if global.time == 3:
		closed = false
	if global.time == 4:
		showpo(howto1)
	if global.time == 11:
		closed = false
	if global.time == 12:
		showpo(howto2)
	if global.time == 21:
		closed = false
	if global.time == 22 : #wave2 big
		wave2 = false
	if global.time == 50:
		closed = false
	if global.time == 51 : #wave3 enc
		showpo(howto3)
		wave3 = false
	if global.time == 71:
		closed = false
	if global.time == 72 : #wave4 zip
		wave4 = false
	
	if image.scale < Vector2(0.3,0.3):
		closepo()
		

		



func _on_close_pressed():
	closed = true
	folder.dragging_folder = false
	folder_shadow.visible = false
	var tween_close = create_tween()
	tween_close.tween_property(image,"scale",normal - close,0.4).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween_close.play()
	global.hand_mouse = false
	mouse_cam.force_pointer_on = true
	


func _on_close_mouse_entered():
	if !closed:
		print(closed)
		mouse_cam.force_pointer_on = false
		#global.hand_mouse = true


func _on_close_mouse_exited():
	if !closed:
		print(closed)
		mouse_cam.force_pointer_on = true
		#global.hand_mouse = false
