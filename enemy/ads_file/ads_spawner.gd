extends Node2D

@onready var timer : Timer = $"ads_time"
@onready var main = $"../.."

var ad = preload("res://enemy/ads_file/ads_file.tscn")
@onready var ads = get_tree().get_nodes_in_group("res://enemy/ads_file/ads_file.tscn")
var offset = 100

var ad_im = [
	preload("res://enemy/ads_file/ads1.png"),
	preload("res://enemy/ads_file/ads2.png")
	]

func _ready():
	for ads in get_tree().get_nodes_in_group("ads"):
		ads.connect("adsclick", _spawn()) #not spawn
	timer.start()
	pass

func _process(delta):
	print()
	pass


func _on_ads_time_timeout():
	_spawn()
	timer.start()
	pass

func _spawn():
	var ins_ad = ad.instantiate()
	ins_ad.set_meta("Image",ad_im[randi() % ad_im.size()])
	ins_ad.global_position = _postion_random_srceen(offset)
	get_parent().add_child(ins_ad)

func _postion_random_srceen(set_offset: int):
	var randomx = get_viewport().size.x
	var randomy = get_viewport().size.y
	return Vector2(randi_range(offset,randomx-offset),randi_range(offset,randomy-offset))
