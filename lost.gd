extends Control


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_yes_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	visible = false


func _on_no_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")
	visible = false
