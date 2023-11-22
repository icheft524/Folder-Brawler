extends Control

@onready var Inv = preload("res://folder/inventory/playerInv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var isOpen: bool = false
var mouse_in 
var mouse_in_tab
var dragging 
var dir 
var dragging_folder


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
			dragging_folder = true
			dragging = position.distance_to(get_global_mouse_position())
			dir = (get_global_mouse_position() - position).normalized()
		else:
			dragging_folder = false
			

func _physics_process(delta):

	if dragging_folder:
		position =  position.move_toward(get_global_mouse_position()-(dragging*dir),70)
		#position =  get_global_mouse_position()-(dragging*dir)
		


func open():
	visible = true
	isOpen = true
	
func close():
	visible = false
	isOpen = false


func _on_esc_button_pressed():
	close()


func _on_mouse_entered():
	mouse_in = true


func _on_mouse_exited():
	if not Rect2(Vector2(),size).has_point(get_local_mouse_position()):
		mouse_in = false


func _on_tab_mouse_entered():
	mouse_in_tab = true


func _on_tab_mouse_exited():
	mouse_in_tab = false
