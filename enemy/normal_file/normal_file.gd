extends CharacterBody2D

@onready var target = %folder
@export var speed = 100
@export var hp = 2

var mouse_in = false


func _ready():
	pass

func _process(delta):
	look_at(target.global_position)
	position += transform.x * speed * delta
	dead()
	
	$hp.text = "normal" + str(hp)

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
		queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("folder"):
		target.hp -= 1
		queue_free()
