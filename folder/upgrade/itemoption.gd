extends ColorRect

@onready var lblName = $Label_name
@onready var lblDescription = $Label_description
@onready var lblLevel = $Label_level
@onready var itemIcon = $ItemIcon

var mouse_over = false
var item = null
@onready var player = get_tree().get_first_node_in_group("folder")

signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade",Callable(player,"upgrade_character"))
	if item == null:
		item = "Endtask"
	lblName.text = UpgradeDb.UPGRADES[item]["displayname"]
	lblDescription.text = UpgradeDb.UPGRADES[item]["details"]
	lblLevel.text = UpgradeDb.UPGRADES[item]["level"]
	itemIcon.texture = load(UpgradeDb.UPGRADES[item]["icon"])


func _input(event):
	if event.is_action("left_click"):
		if mouse_over == true:
			emit_signal("selected_upgrade",item)

func _on_mouse_entered():
	pass # Replace with function body.


func _on_mouse_exited():
	pass # Replace with function body.
