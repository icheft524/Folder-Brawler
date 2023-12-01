extends Node2D

var howto1 = preload("res://art/howtoplay/howtoplay.png")
var howto2 = preload("res://art/howtoplay/howtoplay2.png")
var howto3 = preload("res://art/howtoplay/howtoplay3.png")
var tutor = false
var page = 0
var howtos = [howto1,howto2,howto3]
var normal = Vector2(0.362,0.362)
var pop =  Vector2(0.05,0.05)
var close =  Vector2(0.1,0.1)
@onready var image = $tutorial/image
# Called when the node enters the scene tree for the first time.
func _ready():
	if global.scene_reloaded:
		$tutorial.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	sound.play_menumusic()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.global_position = get_global_mouse_position()
	if image.scale < Vector2(0.3,0.3) and !tutor:
		image.visible = false
		$tutorial/image/close_button.visible = false
		$tutorial/image/left.visible = false
		$tutorial/image/right.visible = false
	

func _on_sfx_value_changed(value):
	sound.click()



func _on_tutorial_pressed():
	tutor = true
	image.visible = true
	image.set_texture(howtos[page])
	$tutorial/image/close_button.visible = true
	$tutorial/image/right.visible = true
	var tween = create_tween()
	tween.tween_property(image,"scale",normal + pop,0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()

func _on_button_pressed():
	$gamestart.play("start")
	sound.playerhitbig()
	await get_tree().create_timer(0.7,false).timeout
	sound.play_gametheme()
	get_tree().change_scene_to_file("res://main.tscn")
	


func _on_close_button_pressed():
	page = 0
	tutor = false
	var tween_close = create_tween()
	tween_close.tween_property(image,"scale",normal - close,0.4).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween_close.play()


func _on_right_pressed():
	page += 1
	if page <= 2:
		image.set_texture(howtos[page])
	if page == 2:
		$tutorial/image/right.visible = false
	if page != 0:
		$tutorial/image/left.visible = true


func _on_left_pressed():
	page -= 1
	if page >= 0:
		image.set_texture(howtos[page])
	if page == 0:
		$tutorial/image/right.visible = true
		$tutorial/image/left.visible = false
	if page != 0:
		$tutorial/image/left.visible = true
