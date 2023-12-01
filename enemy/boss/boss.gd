extends CharacterBody2D

@onready var target = global.target
@export var normal_speed = 150
#@export var hp = 30
@export var file_size = 3000
@export var file_decay = 100
@export var take_normal_dmg = 1
@export var take_crit_dmg = 2
#var slow_speed = normal_speed * 0.5
var percent = randf_range(0,1)
var speed = normal_speed
var offset = 50


@export var file: InvItem

var mouse_in = false
var indicator_finished = false
var target_position
var direction
var phase2 = false
var phase3 = false
var immune = false

@export var offset_spawn = 50
var big = preload("res://enemy/big_file/big_file.tscn")
var zip = preload("res://enemy/zip_file/zip_file.tscn")
var enc = preload("res://enemy/encrypted/encrypted_file.tscn")
var normal = preload("res://enemy/normal_file/normal_file.tscn")

var mon = [big, zip, enc]
var hard_mon = [zip,enc,big]
var weak_mon = [normal]
var not_respond = false
var teleport_ready

func _ready():
	global.showbossbar()
	global.bosshp = 30
	global.boss_enter = true
	$indicator.visible = false
	if !global.enemy_file_drop:
		indicating()
	else:
		#$spawnanim.play("spawn")
		indicator_finished = true
		$teleportanim.play("teleport")
		sound.enemyspawn()

	global.enemy_file_drop = false
	teleport_ready = false
	

func _process(delta):
	
	if teleport_ready == false:
		teleport_ready = true
		$delay_teleport.start()
	
	dead()
	if indicator_finished:
		$hp.text = "boss" + str(global.bosshp)
	
	if global.bosshp <= 20 && !phase2:
		phase2 = true
		print('not res')
		not_respond = true
		#_spawn_file(3)
		global.boss_not_respond()
		$idleanim.play("notrespond")
		await get_tree().create_timer(3,false).timeout
		$idleanim.play("idle")
		not_respond = false
		
	if global.bosshp <= 10 && !phase3:
		phase3 = true
		not_respond = true
		global.boss_not_respond()
		$idleanim.play("notrespond")
		#_spawn_file(3)
		await get_tree().create_timer(5,false).timeout
		$idleanim.play("idle")
		not_respond = false
		



func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("leftclick") && mouse_in && indicator_finished && not_respond == false && !global.inv_open:
			get_viewport().set_input_as_handled()
			#hp -= 1
			if percent > global.crit_chance:
				sound.critical()
				$hitanim.play("hit")
				global.bosshp -= take_crit_dmg
			elif percent <= global.crit_chance:
				global.bosshp -= take_normal_dmg
				sound.enemyhit()
				$hitanim.play("hit")
			#_spawn_file(3)
			#teleport()


func teleport():
	indicating()
	self.position = Vector2(_postion_random_srceen(offset))
	teleport_ready = false
	await get_tree().create_timer(0.5,false).timeout
	_spawn_file(1,'hard')
	

func _on_area_2d_mouse_entered():
	mouse_in = true

func _on_area_2d_mouse_exited():
	mouse_in = false

func dead():
	if global.bosshp <= 0:
		#sound.enemydeath()
		global.boss_enter = false
		global.combo += 1
		global.boss_score += file_size + floor(global.combo/2)
		global.gainscore()
		global.boss_died()
		#global.boss_dead = true
		queue_free()
		global.scene_reloaded = true
		#get_tree().change_scene_to_file("res://menu.tscn")

func _spawn_file(count: int,type):
	#if not_respond == false:
		#for i in range(count):
			#var fileins = mon[i].instantiate()
			#global.enemy_file_drop = true
			#fileins.position = position
			#fileins.set_meta("broken_pos",position - Vector2(randf_range(-1,1) * offset_spawn,randf_range(-1,1) * offset_spawn))
			#get_parent().add_child(fileins)
	#else:
	if type == 'weak':
		for i in range(count):
			var fileins = weak_mon[0].instantiate()
			global.enemy_file_drop = true
			fileins.position = position
			fileins.set_meta("broken_pos",position - Vector2(randf_range(-1,1) * offset_spawn,randf_range(-1,1) * offset_spawn))
			get_parent().add_child(fileins)
				#await get_tree().create_timer(1,false).timeout
	if type == 'hard':
		for i in range(count):
			var fileins = hard_mon[randi_range(0,2)].instantiate()
			global.enemy_file_drop = true
			fileins.position = position
			fileins.set_meta("broken_pos",position - Vector2(randf_range(-1,1) * offset_spawn,randf_range(-1,1) * offset_spawn))
			get_parent().add_child(fileins)
				#await get_tree().create_timer(1,false).timeout
	pass

func indicating():
	$indicator.visible = true
	$Sprite2D.visible = false
	$Area2D.monitoring = false
	await get_tree().create_timer(1,false).timeout
	indicator_finished = true
	$Area2D.monitoring = true
	$indicator.visible = false
	$Sprite2D.visible = true
	$teleportanim.play("teleport")
	sound.enemyspawn()


func _on_area_2d_area_entered(area):
	if area.is_in_group("folder") and visible and indicator_finished:
		target.collect(file,global.bosshp,file_size,'normal')
		sound.playerhit()
		target.capacity += file_size
		queue_free()
	
func _postion_random_srceen(set_offset: int):
	var randomx = get_viewport_rect().size.x
	#var randomx = get_viewport_rect().size.x
	var randomy = get_viewport_rect().size.y
	return Vector2(randf_range(200,1300),randf_range(offset,randomy-offset))
	#return Vector2(randf_range(100,1200),randf_range(offset,randomy-offset) #- Vector2(randf_range(400,900),0)


func _on_delay_teleport_timeout():
	if !not_respond:
		teleport()


func _on_one_sec_spawn_timeout():
	if file_size >= file_decay + 500:
		file_size -= file_decay
	if $Sprite2D.visible == true:
		_spawn_file(1,'weak')
