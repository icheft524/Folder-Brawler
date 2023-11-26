extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	sound.play_menumusic()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	sound.play_gametheme()
	get_tree().change_scene_to_file("res://main.tscn")
