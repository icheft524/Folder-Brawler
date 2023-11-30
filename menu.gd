extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	sound.play_menumusic()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.global_position = get_global_mouse_position()


func _on_button_button_down():
	sound.play_gametheme()
	get_tree().change_scene_to_file("res://main.tscn")



func _on_sfx_value_changed(value):
	sound.click()
