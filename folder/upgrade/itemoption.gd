extends ColorRect

@onready var lblName = $"box/Label_name"
@onready var lblDescription = $"box/Label_description"
@onready var lblLevel = $"box/Label_level"
@onready var itemIcon = $"box/ItemIcon"
@onready var box = $box
@onready var outline = $outline

var unhighlight = 0.25

var mouse_over = false
var item = null
@onready var player = get_tree().get_first_node_in_group("folder")

signal selected_upgrade(upgrade)
signal upgrade

func _ready():
	outline.modulate.a = unhighlight
	box.hide()
	connect("selected_upgrade",Callable(player,"upgrade_character"))
	
func _process(delta):
	if item == null:
		item = "Endtask"
	lblName.text = UpgradeDb.UPGRADES[item]["displayname"]
	lblDescription.text = UpgradeDb.UPGRADES[item]["details"]
	lblLevel.text = UpgradeDb.UPGRADES[item]["level"]
	itemIcon.texture = load(UpgradeDb.UPGRADES[item]["icon"])

func _input(event):
	if event.is_action("leftclick"):
		if mouse_over == true:
			global.on_upgrade = false
			outline.modulate.a = unhighlight
			emit_signal("selected_upgrade",item)
			emit_signal("upgrade")

func _on_area_2d_mouse_entered():
	mouse_over = true
	if global.on_upgrade:
		outline.modulate.a = 1
	pass


func _on_area_2d_mouse_exited():
	mouse_over = false
	if global.on_upgrade:
		outline.modulate.a = unhighlight
	pass
