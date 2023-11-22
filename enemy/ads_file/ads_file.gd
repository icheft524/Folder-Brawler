extends CharacterBody2D

@onready var target = %folder
var draggingDistance
var dir
var dragging_ads
var newPosition = Vector2()
var closing_ads
@export var speed_x = 7
@export var speed_y = 7
@export var speed = 200


var mouse_in = false
var target_position
var direction

func _ready():
	pass


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging_ads = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging_ads = false
			
	elif event is InputEventMouseMotion:
		if dragging_ads:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
			
			
	if event is InputEventMouseButton and closing_ads == true:
		if event.is_double_click() && mouse_in:
			get_parent().remove_child(self)
			self.queue_free()

func _physics_process(delta):
	if dragging_ads:
		velocity = (newPosition - position) * Vector2(speed_x, speed_y)
		move_and_slide()

func _on_drag_area_mouse_entered():
	mouse_in = true


func _on_drag_area_mouse_exited():
	mouse_in = false


func _on_close_area_mouse_entered():
	mouse_in = true
	closing_ads = true


func _on_close_area_mouse_exited():
	mouse_in = false
	closing_ads = true
