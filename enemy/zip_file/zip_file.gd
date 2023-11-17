extends CharacterBody2D

@onready var target = %folder
@export var speed = 50
@export var hp = 2

var mouse_in = false

const normal_file = preload("res://enemy/normal_file/normal_file.tscn")

func _process(delta):
	look_at(target.global_position)
	position += transform.x * speed * delta
	dead()
	
	$hp.text = "zip" + str(hp)


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			hp -= 1


func _on_area_2d_mouse_entered():
	mouse_in = true


func _on_area_2d_mouse_exited():
	mouse_in = false

func dead():
	if hp == 0:
		var filespawn = global_position
		var file = normal_file.instantiate()
		file.position = filespawn
		get_parent().add_child(file)
		queue_free()
	
