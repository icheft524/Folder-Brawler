extends CharacterBody2D


var draggingDistance
var dir
var dragging_folder
var newPosition = Vector2()
@export var speed_x = 7
@export var speed_y = 7
@export var hp = 10
@export var inv: Inv
@export var capacity = 0

@onready var inventory = $"../folder_inventory"
@onready var _Upgrade = $"../upgrade"
@onready var upgradeOptions = _Upgrade.get_node("%UpgradeOptions")

var itemOptions = preload("res://folder/upgrade/itemoption.tscn")

var collected_upgrades = []
var upgrade_options = []

var mouse_in = false

func _ready():
	sound.play_gametheme()
	global.target = self
	pass

func _process(delta):
	check_cap()
	$hp.text = "CAP: " + str(capacity)
	if Input.is_action_just_pressed("leftclick"):
		sound.click()

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			sound.playergrab()
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging_folder = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging_folder = false
			
	elif event is InputEventMouseMotion:
		if dragging_folder:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
			
			
	if event is InputEventMouseButton:
		if event.is_double_click() && mouse_in:
			inventory.open()
			sound.playeropenfolder()
	
	if event.is_action_pressed("ui_accept"):
		levelup()
	pass
func _physics_process(delta):
	if dragging_folder:
		velocity = (newPosition - position) * Vector2(speed_x, speed_y)
		move_and_slide()

func check_cap():
	if capacity < 4:
		$Sprite2D.texture = load("res://folder/folder_empty.png2.png")
	elif capacity < 10:
		$Sprite2D.texture = load("res://folder/folder_half.png2.png")
	else:
		$Sprite2D.texture = load("res://folder/folder_full.png2.png")

func _on_area_2d_mouse_entered():
	mouse_in = true

func _on_area_2d_mouse_exited():
	mouse_in = false

func _on_area_2d_area_entered(area):
	if area.is_in_group('enemy'):
		pass
		
func collect(file,ehp,file_size,enemy_name):
	inv.insert(file,ehp,file_size,enemy_name)

func upgrade_character(upgrade):
	print("upgrade")
	match upgrade:
		"Adblocker1":
			global.adstimelock += 20
		"Adblocker2":
			global.adstimelock += 2
		"Adblocker3":
			global.adstimelock += 2
		"Antivirus1":
			global.crit_chance -= 0.10
		"Antivirus2":
			global.crit_chance -= 0.10
		"Antivirus3":
			global.crit_chance -= 0.15
		"Harddisk1":
			pass
		"Harddisk2":
			pass
		"Harddisk3":
			pass
		"increasedpi":
			speed_x = speed_x * 1.15
			speed_y = speed_y * 1.15
		"increasedp2":
			speed_x = speed_x * 1.25
			speed_y = speed_y * 1.25
		"increasedp3":
			speed_x = speed_x * 1.40
			speed_y = speed_y * 1.40
		"shock1":
			pass
		"shock2":
			pass
		"shock3":
			pass
		"Endtask":
			pass
	
	var option_children = upgradeOptions.get_children()
	for i in option_children:
		i.queue_free()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	_Upgrade.visible = false
	_Upgrade.position = Vector2(1000,500)
	get_tree().paused = false

func levelup():
	get_tree().paused = true
	#var tween = levelPanel.create_tween()
	#tween.tween_property(levelPanel,"position",Vector2(positionx,positiony),0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	#tween.play()
	_Upgrade.visible = true
	var options = 0
	var optionsmax = 2
	while  options < optionsmax:
		var option_choice = itemOptions.instantiate()
		option_choice.item = get_random_item()
		upgradeOptions.add_child(option_choice)
		options += 1

func get_random_item():
	var dblist = []
	for i in UpgradeDb.UPGRADES:
		if i in collected_upgrades: #Find already upgrades
			pass
		elif i in upgrade_options: #if upgrades is already options
			pass
		elif UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0: #Check for PreRequisites
			for n in UpgradeDb.UPGRADES[i]["prerequisite"]:
				if not n in collected_upgrades:
					pass 
				else:
					dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var randomitem = dblist.pick_random()
		upgrade_options.append(randomitem)
		return randomitem
	else:
		return null
