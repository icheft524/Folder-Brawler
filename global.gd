extends Node

signal reloaded
signal scored
var time = 0
var gameend = false
var target
var adstimelock = 0
var crit_chance = 0.95
var slot_dragging = false
var ad_clicked = false
var slow_speed = 0.75
var enemy_file_drop = false
var inv_open = false
var shaking = false
var big_shaking = false
var on_upgrade = false
var hand_mouse = false
var mouse_in_ads = false
var mouse_in_enemy = false
var mouse_inv_tab = false
var mouse_inv_close = false
var mouse_inv_drag = false
var pop_start_tutorial = false
var pop_enter_tutorial = false
var not_respond_mouse = false
var scene_reloaded = false
var score = 0
var highscore
var boss_enter = false
var bosshp = 40
var boss_rip = false

#enemy_score
var normal_score = 0
var encrypt_score = 0
var zip_score = 0
var big_score = 0
var boss_score = 0
var combo = 0

signal boss_dies
signal not_responding
signal bossready

func boss_died():
	boss_dies.emit()

func boss_not_respond():
	not_responding.emit()

func showbossbar():
	emit_signal("bossready")

func _ready():
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file != null:
		highscore = save_file.get_32()
	else:
		highscore = 0
		save_game()

func gainscore():
	score = normal_score + encrypt_score + zip_score + big_score + boss_score
	if score <= 0:
		score = 0
		normal_score = 0
		encrypt_score = 0
		zip_score = 0
		big_score = 0
	emit_signal("scored")
	#print("scored")
	

func sumscore():
	if score > highscore and boss_rip:
		highscore = score
		boss_rip = false
	pass

func save_game():
	sumscore()
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(highscore)
