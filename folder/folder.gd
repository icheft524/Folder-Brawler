extends CharacterBody2D


var draggingDistance
var dir
var dragging_folder
var newPosition = Vector2()
@export var speed_x = 7
@export var speed_y = 7
@export var hp = 10
@export var inv: Inv
@export var capacity = 0

@onready var inventory = $"../folder_inventory"

var mouse_in = false

func _ready():
	sound.play_gametheme()
	global.target = self
	pass

func _process(delta):
	check_cap()
	$hp.text = "CAP: " + str(capacity)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			sound.playergrab()
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

func check_cap():
	if capacity < 4:
		$Sprite2D.texture = load("res://folder/folder_empty.png2.png")
	elif capacity < 10:
		$Sprite2D.texture = load("res://folder/folder_half.png2.png")
	else:
		$Sprite2D.texture = load("res://folder/folder_full.png2.png")

func _on_area_2d_mouse_entered():
	mouse_in = true

func _on_area_2d_mouse_exited():
	mouse_in = false

func _on_area_2d_area_entered(area):
	if area.is_in_group('enemy'):
		pass
		
func collect(file,ehp,file_size,enemy_name):
	inv.insert(file,ehp,file_size,enemy_name)
