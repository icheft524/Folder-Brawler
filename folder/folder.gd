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
@export var m_fat = 0.8
@export var l_fat = 0.5
@export var xl_fat = 0.3

@onready var inventory = $"../folder_inventory"
@onready var hud = $"../hud"
@onready var Upgrade = $"../hud/upgrade"
@onready var UpgradeList = $"../hud/upgrade/list"
#@onready var _Upgrade = $"../upgrade"
#@onready var upgradeOptions = _Upgrade.get_node("%UpgradeOptions")

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
	global.hand_mouse = false
	pass

func _process(delta):
	check_cap()
	$hp.text = "CAP: " + str(capacity)
	if Input.is_action_just_pressed("leftclick"):
		sound.click()

func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("leftclick") && mouse_in:
			$shadow.visible = true
			sound.playergrab()
			get_viewport().set_input_as_handled()
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging_folder = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging_folder = false
			$shadow.visible = false
			
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
			
			
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
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
	if capacity < 2:
		fatness = 1
		$Sprite2D.texture = load("res://art/playerfolder/s/playerbody_s_idle.png")
		$face.texture = load("res://art/playerfolder/s/playerface_S.png")
		$outline.texture = load("res://art/playerfolder/s/playerbody_s_hover.png")
		$shadow.texture = load("res://art/playerfolder/s/playerbody_s_dragging.png")
	elif capacity < 4:
		fatness = m_fat
		$Sprite2D.texture = load("res://art/playerfolder/m/playerbody_m_idle.png")
		$face.texture = load("res://art/playerfolder/m/playerface_M.png")
		$outline.texture = load("res://art/playerfolder/m/playerbody_m_hover.png")
		$shadow.texture = load("res://art/playerfolder/m/playerbody_m_dragging.png")
	elif capacity < 6:
		fatness = l_fat
		$Sprite2D.texture = load("res://art/playerfolder/l/playerbody_l_idle.png")
		$face.texture = load("res://art/playerfolder/l/playerface_L.png")
		$outline.texture = load("res://art/playerfolder/l/playerbody_l_hover.png")
		$shadow.texture = load("res://art/playerfolder/l/playerbody_l_dragging.png")
	elif capacity < 8:
		fatness = xl_fat
		$Sprite2D.texture = load("res://art/playerfolder/xl/playerbody_xl_idle.png")
		$face.texture = load("res://art/playerfolder/xl/playerface_XL.png")
		$outline.texture = load("res://art/playerfolder/xl/playerbody_xl_hover.png")
		$shadow.texture = load("res://art/playerfolder/xl/playerbody_xl_dragging.png")
	else:
		get_tree().reload_current_scene()

func _on_area_2d_mouse_entered():
	mouse_in = true
	$outline.visible = true

func _on_area_2d_mouse_exited():
	mouse_in = false
	$outline.visible = false

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
		"shock":
			global.slow_speed = 0
		#"shock2":
			#global.slow_speed -= 0.25
		#"shock3":
			#global.slow_speed -= 0.25
		"Endtask":
			end_task = true
			inv.allremoved()
			capacity = 0
	var option_children = UpgradeList.get_children()
	for i in option_children:
		i.get_node("box").hide()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	get_tree().paused = false

func flash():
	$flashanim.play("flash")

# delete order = _Upgrade , upgradeOptions
func levelup():
	sound.upgrade()
	global.on_upgrade = true
	get_tree().paused = true
	var option_children = UpgradeList.get_children()
	for i in option_children:
		i.get_node("box").show()
		i.item = get_random_item()

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
