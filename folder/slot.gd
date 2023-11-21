extends Panel

@onready var file_visual: Sprite2D = $CenterContainer/Panel/file_display
@onready var health_text: Label = $CenterContainer/Panel/file_display/ehp
@onready var name_text: Label = $CenterContainer/Panel/file_display/ename
@onready var drop_normal = $"../../../../normalFile"
@onready var drop_zip = $"../../../../zipFile"

var dragging
var mouse_in

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
		
func _physics_process(delta):
	if dragging:
		file_visual.position = get_local_mouse_position()

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			dragging = true
		else:
			dragging = false
			if name_text.text == 'normal':
				file_visual.visible = false
				drop_normal.respawn()
			if name_text.text == 'zip':
				file_visual.visible = false
				drop_zip.respawn()

func _on_mouse_entered():
	mouse_in = true


func _on_mouse_exited():
	mouse_in = false
