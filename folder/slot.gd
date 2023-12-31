extends Panel

@onready var file_visual: Sprite2D = $CenterContainer/Panel/file_display
@onready var health_text: Label = $CenterContainer/Panel/file_display/ehp
@onready var name_text: Label = $CenterContainer/Panel/file_display/ename
@onready var drop = $"../../../../enemy_spawner"
@onready var player = $"../../../../folder"
@onready var inventory = $"../../../../folder_inventory"
@onready var cam = $"../../../../cam"

@export var inv: Inv

var dragging
var mouse_in
var slot_num
var origin
var ehp
var occupied

func update(slot: InvSlot):
	if !slot.item:
		file_visual.visible = false
		name_text.visible = false
		health_text.visible = false
		
	else:
		$".".visible = true
		file_visual.visible = true
		file_visual.texture = slot.item.texture
		#name_text.visible = true
		#health_text.visible = true
		#health_text.text = str(slot.ehp)
		name_text.text = slot.ename
		ehp = slot.ehp
		occupied = true
		slot_num = slot.slot_num
		origin = $Sprite2D.position

func _physics_process(delta):
	
	if dragging == true:
		global.hand_mouse = true
		file_visual.position = get_local_mouse_position()
		if !global.inv_open:
			dragging = false
			file_visual.position = origin
			#occupied = true
		

func _on_gui_input(event):
	if event is InputEventMouseButton and !(name_text.text == 'encrypted'):
		#file_visual.position = origin
		if event.is_pressed() && mouse_in && occupied:
			get_viewport().set_input_as_handled()
			global.mouse_inv_drag = true
			dragging = true
			global.slot_dragging = true
			$CenterContainer/Panel/file_display.z_index = 2
			
		elif occupied:
			dragging = false
			global.mouse_inv_drag = false
			global.hand_mouse = false
			global.slot_dragging = false
			$CenterContainer/Panel/file_display.z_index = 1
			file_visual.position = origin
			
			if name_text.text == 'normal' and !inventory.mouse_in:
				file_visual.visible = false
				$".".visible = false
				file_visual.position = origin
				occupied = false
				inv.removed(slot_num)
				drop.respawn_normal(ehp,get_global_mouse_position())
				
			if name_text.text == 'zip' and !inventory.mouse_in:
				file_visual.visible = false
				$".".visible = false
				file_visual.position = origin
				occupied = false
				inv.removed(slot_num)
				drop.respawn_zip(ehp,get_global_mouse_position())
			
			if name_text.text == 'big' and !inventory.mouse_in:
				file_visual.visible = false
				$".".visible = false
				file_visual.position = origin
				occupied = false
				inv.removed(slot_num)
				drop.respawn_big(ehp,get_global_mouse_position())

#func _on_mouse_entered():
	#mouse_in = true
	#global.mouse_inv_tab = true


#func _on_mouse_exited():


func _on_center_container_mouse_entered():
	mouse_in = true
	global.mouse_inv_tab = true


func _on_center_container_mouse_exited():
	mouse_in = false
	global.mouse_inv_tab = false
