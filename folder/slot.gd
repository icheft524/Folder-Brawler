extends Panel

@onready var file_visual: Sprite2D = $CenterContainer/Panel/file_display
@onready var health_text: Label = $CenterContainer/Panel/file_display/ehp
@onready var name_text: Label = $CenterContainer/Panel/file_display/ename
@onready var drop = $"../../../../enemy_spawner"
@onready var player = $"../../../../folder"

@export var inv: Inv

var dragging
var mouse_in
var slot_num
var origin
var ehp

func update(slot: InvSlot):
	if !slot.item:
		file_visual.visible = false
		name_text.visible = false
		health_text.visible = false
	else:
		file_visual.visible = true
		file_visual.texture = slot.item.texture
		name_text.visible = true
		health_text.visible = true
		health_text.text = str(slot.ehp)
		name_text.text = slot.ename
		ehp = slot.ehp
		slot_num = slot.slot_num
		origin = $Sprite2D.position
		
func _physics_process(delta):
	if dragging:
		file_visual.position = get_local_mouse_position()
		

func _on_gui_input(event):
	if event is InputEventMouseButton:
		#file_visual.position = origin
		if event.is_pressed() && mouse_in:
			dragging = true
			print('Slot number',slot_num)
		else:
			dragging = false
			if name_text.text == 'normal':
				file_visual.visible = false
				file_visual.position = origin
				inv.removed(slot_num)
				drop.respawn_normal(ehp)
			if name_text.text == 'zip':
				file_visual.visible = false
				file_visual.position = origin
				inv.removed(slot_num)
				drop.respawn_zip(ehp)

func _on_mouse_entered():
	mouse_in = true


func _on_mouse_exited():
	mouse_in = false
