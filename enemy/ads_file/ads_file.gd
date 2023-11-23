extends CharacterBody2D

@onready var target = %folder
@onready var image = $"Panel/Texture"
var draggingDistance
var dir
var dragging_folder
var newPosition = Vector2()
@export var speed_x = 7
@export var speed_y = 7
@export var speed = 200

const nodeself = preload("res://enemy/ads_file/ads_file.tscn")
var mouse_in = false
var mouse_close_in = false
var mouse_ads_in = false
var target_position
var direction

signal adsclick

func _ready():
	sound.adspawn()
	image.set_texture(get_meta("Image"))
	pass


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
		if event.is_pressed() && mouse_close_in:
			get_parent().remove_child(self)
			self.queue_free()
			
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_ads_in:
			#var adsspawn = $Marker2D.global_position
			#var ads = nodeself.instantiate()
			#ads.position = adsspawn
			#get_parent().add_child(ads)
			emit_signal("adsclick")

func _physics_process(delta):
	if dragging_folder:
		velocity = (newPosition - position) * Vector2(speed_x, speed_y)
		move_and_slide()


func _on_drag_area_mouse_entered():
	mouse_in = true


func _on_drag_area_mouse_exited():
	mouse_in = false


func _on_close_area_mouse_entered():
	mouse_close_in = true


func _on_close_area_mouse_exited():
	mouse_close_in = false


func _on_ads_area_mouse_entered():
	mouse_ads_in = true


func _on_ads_area_mouse_exited():
	mouse_ads_in = false
