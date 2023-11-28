extends CharacterBody2D

@onready var target = %folder
@onready var image = $"Panel/ads"
var draggingDistance
var dir
var dragging_folder
var newPosition = Vector2()
@export var speed_x = 7
@export var speed_y = 7
@export var speed = 200
@export var pop =  Vector2(1.5,1.5)
@export var close =  Vector2(0.8,0.8)


var mouse_in = false
var mouse_close_in = false
var mouse_in_ad = false
var already_clicked = false
var target_position
var direction
var drag_back_left = false
var drag_back_right = false
var drag_back_top = false
var drag_back_bottom = false

func _ready():
	already_clicked = false
	sound.adspawn()
	image.set_texture(get_meta("Image"))
	var tween = create_tween()
	tween.tween_property(self,"scale",pop,0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	pass


func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("leftclick") && mouse_in && !mouse_close_in && !global.inv_open:
			get_viewport().set_input_as_handled()
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging_folder = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging_folder = false
			
	if event is InputEventMouseMotion:
		if dragging_folder:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
			
			
	if event is InputEventMouseButton:
		if event.is_action_pressed("leftclick") && mouse_close_in && !already_clicked && !global.inv_open:
			already_clicked = true
			get_viewport().set_input_as_handled()
			var tween_close = create_tween()
			tween_close.tween_property(self,"scale",close,0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
			tween_close.play()
	
	if event is InputEventMouseButton:
		if event.is_action_pressed("leftclick") && mouse_in_ad && !global.inv_open:
			get_viewport().set_input_as_handled()
			global.ad_clicked = true
			
	if event is InputEventMouseMotion:
		if event.relative.x < 0:
			drag_back_left = true
		if event.relative.x > 0:
			drag_back_right = true
		if event.relative.y < 0:
			drag_back_top = true
		if event.relative.y > 0:
			drag_back_bottom = true

func _physics_process(delta):
	
	if dragging_folder:
		
		if self.global_position.x >= 1350 :
			speed_x = 0
			if drag_back_left and get_global_mouse_position().x <= 1350:
				drag_back_left = false 
				speed_x = 7
				
		if self.global_position.x <= 50:
			speed_x = 0
			if drag_back_right and get_global_mouse_position().x >= 50:
				drag_back_right = false 
				speed_x = 7
				
		if self.global_position.y >= 1100:
			speed_y = 0
			if drag_back_top and get_global_mouse_position().x <= 1100:
				drag_back_top = false 
				speed_y = 7
				
		if self.global_position.y <= 0:
			speed_y = 0
			if drag_back_bottom and get_global_mouse_position().x >= 0:
				drag_back_bottom = false 
				speed_y = 7
		
		velocity = (newPosition - position) * Vector2(speed_x, speed_y)
		move_and_slide()

func _process(delta):
	if !global.inv_open:
		$close_area.monitoring = false
		$drag_area.monitoring = false
		$Panel.monitoring = false
		$close_area.monitorable = false
		$drag_area.monitorable = false
		$Panel.monitorable = false
	else:
		$close_area.monitoring = true
		$drag_area.monitoring = true
		$Panel.monitoring = true
		$close_area.monitorable = true
		$drag_area.monitorable = true
		$Panel.monitorable = true
		
	if scale < Vector2(1,1):
		get_viewport().set_input_as_handled()
		get_parent().remove_child(self)
		global.hand_mouse = false
		global.mouse_in_ads = false
		self.queue_free()

func _on_drag_area_mouse_entered():
	mouse_in = true
	global.mouse_in_ads = true


func _on_drag_area_mouse_exited():
	mouse_in = false
	global.mouse_in_ads = false


func _on_close_area_mouse_entered():
	mouse_close_in = true
	if !global.inv_open:
		global.hand_mouse = true


func _on_close_area_mouse_exited():
	mouse_close_in = false
	if !global.inv_open && !global.mouse_in_enemy:
		global.hand_mouse = false


func _on_panel_mouse_entered():
	mouse_in_ad = true
	if !global.inv_open:
		global.hand_mouse = true


func _on_panel_mouse_exited():
	mouse_in_ad = false
	if !global.inv_open && !global.mouse_in_enemy:
		global.hand_mouse = false
