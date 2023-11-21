extends Panel

@onready var file_visual: Sprite2D = $CenterContainer/Panel/file_display
@onready var health_text: Label = $CenterContainer/Panel/ehp
@onready var name_text: Label = $CenterContainer/Panel/ename

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
