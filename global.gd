extends Node

var time = 0
var gameend = false
var target
var adstimelock = 0
var crit_chance = 1
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

signal boss_dies
signal not_responding

func boss_died():
	boss_dies.emit()

func boss_not_respond():
	not_responding.emit()
