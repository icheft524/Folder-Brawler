extends CharacterBody2D


var draggingDistance
var dir
var dragging_folder
var newPosition = Vector2()
@export var speed_x = 7
@export var speed_y = 7
@export var hp = 10
@export var inv: Inv

@onready var inventory = $"../folder_inventory"

var mouse_in = false

func _ready():
	pass

func _process(delta):
	$hp.text = "folder" + str(hp)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging_folder = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging_folder = false
			
	elif event is InputEventMouseMotion:
		if dragging_folder:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
			
			
	if event is InputEventMouseButton:
		if event.is_double_click() && mouse_in:
			inventory.open()

func _physics_process(delta):
	if dragging_folder:
		velocity = (newPosition - position) * Vector2(speed_x, speed_y)
		move_and_slide()


func _on_area_2d_mouse_entered():
	mouse_in = true

func _on_area_2d_mouse_exited():
	mouse_in = false

func _on_area_2d_area_entered(area):
	if area.is_in_group('enemy'):
		pass
		
func collect(file,enemy_hp):
	inv.insert(file,enemy_hp)
