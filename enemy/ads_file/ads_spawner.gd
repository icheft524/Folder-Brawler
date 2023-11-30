extends Node2D

@onready var timer : Timer = $"ads_time"
@onready var main = $"../.."

var ads = preload("res://enemy/ads_file/ads_file_s.tscn")
var adm = preload("res://enemy/ads_file/ads_file_m.tscn")
var adl = preload("res://enemy/ads_file/ads_file_l.tscn")
var stop_spawn = false

var adscale = [ads,adm,adl]

var offset = 200
const art_Path = "res://art/ad/"


var ad_im_m = [
	"Ads_M_1.png",
	"Ads_M_2.png",
	"Ads_M_3.png"
	]
var ad_im_l = [
	"Ads_L_1.png",
	"Ads_L_2.png",
	"Ads_L_3.png"
	]
var ad_im_s = [
	"Ads_S_1.png",
	"Ads_S_2.png",
	"Ads_S_3.png"
	]

func _ready():
	timer.start()
	global.boss_dies.connect(boss_dead)
	pass

func _process(delta):
	if global.ad_clicked and !stop_spawn:
		_spawn()
		global.ad_clicked = false


func _on_ads_time_timeout():
	if !stop_spawn:
		_spawn()
		await get_tree().create_timer(global.adstimelock,false).timeout
		timer.start()
	

func _spawn():
	var random_ad = randi() % adscale.size()
	var ins_ad = adscale[random_ad].instantiate()
	match random_ad:
		0:
			ins_ad.set_meta("Image",load(art_Path + ad_im_s[randi() % ad_im_s.size()]))
		1:
			ins_ad.set_meta("Image",load(art_Path + ad_im_m[randi() % ad_im_m.size()]))
		2:
			ins_ad.set_meta("Image",load(art_Path + ad_im_l[randi() % ad_im_l.size()]))
	ins_ad.global_position = _postion_random_srceen(offset)
	get_parent().add_child(ins_ad)

func _postion_random_srceen(set_offset: int):
	var randomx = get_viewport_rect().size.x
	#var randomx = get_viewport_rect().size.x
	var randomy = get_viewport_rect().size.y
	return Vector2(randf_range(100,1000),randf_range(offset,randomy-offset))
	
func boss_dead():
	stop_spawn = true
