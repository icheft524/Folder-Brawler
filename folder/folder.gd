extends CharacterBody2D


var draggingDistance
var dir
var dragging_folder
var newPosition = Vector2()
@export var speed_x = 7
@export var speed_y = 7
@export var inv: Inv
var capacity = 0
@export var max_capacity = 10
@export var slowness = 0.02
@export var mid_fat = 0.8
@export var extreme_fat = 0.4

@onready var inventory = $"../folder_inventory"
@onready var _Upgrade = $"../upgrade"
@onready var upgradeOptions = _Upgrade.get_node("%UpgradeOptions")

var itemOptions = preload("res://folder/upgrade/itemoption.tscn")

var collected_upgrades = []
var upgrade_options = []

var mouse_in = false
var drag_back_left = false
var drag_back_right = false
var drag_back_top = false
var drag_back_bottom = false
var end_task = false
var fatness

@export var positionx = 700
@export var positiony = 300

var wave2 = true
var wave3 = true
var wave4 = true
var wave5 = true

func _ready():
	inv.allremoved()
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
			get_viewport().set_input_as_handled()
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging_folder = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging_folder = false
			
	elif event is InputEventMouseMotion:
		if dragging_folder:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
	
	if event is InputEventMouseMotion:
		if event.relative.x < 0:
			drag_back_left = true
		if event.relative.x > 0:
			drag_back_right = true
		if event.relative.y < 0:
			drag_back_top = true
		if event.relative.y > 0:
			drag_back_bottom = true
			
			
	if event is InputEventMouseButton:
		if event.is_double_click() && mouse_in:
			inventory.open()
			sound.playeropenfolder()
	
	
	if event.is_action_pressed("ui_accept"): #change to global.time
		levelup()
	
	if global.time == 22 and wave2 == true: #wave2
		levelup()
		wave2 = false
	elif global.time == 47 and wave3 == true: #wave3
		levelup()
		wave3 = false
	elif global.time == 72 and wave4 == true: #wave4
		levelup()
		wave4 = false
	elif global.time == 97 and wave5 == true: #wave5
		levelup()
		wave5 = false
	
func _physics_process(delta):
	print(self.global_position)
	
	if dragging_folder:
		if self.global_position.x >= 1350 :
			speed_x = 0
			if drag_back_left and get_global_mouse_position().x <= 1350:
				drag_back_left = false 
				speed_x = 7
				
		if self.global_position.x <= 50:
			speed_x = 0
			if drag_back_right and get_global_mouse_position().x >= 50:
				drag_back_right = false 
				speed_x = 7
				
		if self.global_position.y >= 1100:
			speed_y = 0
			if drag_back_top and get_global_mouse_position().x <= 1100:
				drag_back_top = false 
				speed_y = 7
				
		if self.global_position.y <= 0:
			speed_y = 0
			if drag_back_bottom and get_global_mouse_position().x >= 0:
				drag_back_bottom = false 
				speed_y = 7

		velocity = (newPosition - position) * Vector2(speed_x, speed_y) * fatness
		move_and_slide()
		
		
	#if global.slot_dragging:
		#Engine.time_scale = slowness
	#elif !global.slot_dragging:
		#Engine.time_scale = 1


func check_cap():
	if capacity < 4:
		fatness = 1
		$Sprite2D.texture = load("res://folder/folder_empty.png2.png")
	elif capacity < 8:
		fatness = mid_fat
		$Sprite2D.texture = load("res://folder/folder_half.png2.png")
	elif capacity < max_capacity:
		fatness = extreme_fat
		$Sprite2D.texture = load("res://folder/folder_full.png2.png")
	else:
		get_tree().reload_current_scene()

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
			max_capacity += 2
		"Harddisk2":
			max_capacity += 2
		"Harddisk3":
			max_capacity += 2
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
			global.slow_speed -= 0.25
		"shock2":
			global.slow_speed -= 0.25
		"shock3":
			global.slow_speed -= 0.25
		"Endtask":
			end_task = true
			inv.allremoved()
			capacity = 0
	print("get: " + upgrade)
	var option_children = upgradeOptions.get_children()
	for i in option_children:
		i.queue_free()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	_Upgrade.visible = false
	_Upgrade.position = Vector2(700,700)
	get_tree().paused = false

func levelup():
	get_tree().paused = true
	var tween = _Upgrade.create_tween()
	tween.tween_property(_Upgrade,"position",Vector2(positionx,positiony),0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
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
