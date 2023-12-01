extends Control

@onready var Inv = preload("res://folder/playerInv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var player = $"../folder"
@onready var popup  = $"../popup"


var isOpen: bool = false
var mouse_in 
var mouse_in_tab
var mouse_in_esc
var dragging 
var dir 
var dragging_folder
#@onready var file_visual = $NinePatchRect/GridContainer.get_children()


func _ready():
	close()
	Inv.update.connect(update_slots)
	update_slots()
	

func update_slots():
	for i in range(min(Inv.slots.size(), slots.size())):
		slots[i].update(Inv.slots[i])


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in_tab:
			get_viewport().set_input_as_handled()
			dragging_folder = true
			global.mouse_inv_drag = true
			dragging = position.distance_to(get_global_mouse_position())
			dir = (get_global_mouse_position() - position).normalized()
		else:
			dragging_folder = false
			global.mouse_inv_drag = false
			
		if event.is_pressed() && mouse_in_esc:
			get_viewport().set_input_as_handled()
			mouse_in_esc = false
			global.hand_mouse = false
			close()
		
		if event.is_pressed() && global.inv_open && !mouse_in:
			get_viewport().set_input_as_handled()
		
		
		
func _physics_process(delta):
	
	if player.end_task == true:
		for i in slots:
			i.visible = false
		player.end_task = false
		
	if dragging_folder:
		position =  position.move_toward(get_global_mouse_position()-(dragging*dir),70)
		#position =  get_global_mouse_position()-(dragging*dir)
	
	
		


func open():
	self.global_position = Vector2(400,370)
	visible = true
	isOpen = true
	global.inv_open = true
	Engine.time_scale = 0.35
	
func close():
	visible = false
	isOpen = false
	global.inv_open = false
	Engine.time_scale = 1

func _on_mouse_entered():
	mouse_in = true


func _on_mouse_exited():
	if not Rect2(Vector2(),size).has_point(get_local_mouse_position()):
		mouse_in = false


func _on_tab_mouse_entered():
	mouse_in_tab = true
	global.mouse_inv_tab = true


func _on_tab_mouse_exited():
	mouse_in_tab = false
	global.mouse_inv_tab = false

func _on_esc_button_mouse_entered():
	mouse_in_esc = true
	global.mouse_inv_close = true
	global.hand_mouse = true


func _on_esc_button_mouse_exited():
	mouse_in_esc = false
	global.mouse_inv_close = false
	global.hand_mouse = false
	
