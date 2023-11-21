extends Control

@onready var Inv = preload("res://folder/playerInv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var isOpen: bool = false

func _ready():
	close()
	Inv.update.connect(update_slots)
	update_slots()
	

func update_slots():
	for i in range(min(Inv.slots.size(), slots.size())):
		slots[i].update(Inv.slots[i])


func open():
	visible = true
	isOpen = true
	
func close():
	visible = false
	isOpen = false


func _on_esc_button_pressed():
	close()
