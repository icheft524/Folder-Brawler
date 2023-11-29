extends Node2D

@onready var pic_wave1 = $wave1
@onready var pic_wave2 = $wave2
@onready var pic_wave3 = $wave3
@onready var pic_wave4 = $wave4
@onready var close_but = $close

var mouse_close_in = false
var already_clicked = false
#@export var close =  Vector2(0.8,0.8)

var wave2 = true
var wave3 = true
var wave4 = true


func _ready():
	get_tree().paused = true
	pic_wave1.visible = true
	close_but.visible = true
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.time == 22 and wave2: #wave2 big
		pic_wave2.visible = true
		close_but.visible = true
		get_tree().paused = true

	if global.time == 47 and wave3: #wave3 enc
		pic_wave3.visible = true
		close_but.visible = true
		get_tree().paused = true

	if global.time == 72 and wave4: #wave4 zip
		pic_wave4.visible = true
		get_tree().paused = true



func _on_close_pressed():
	pic_wave1.visible = false
	close_but.visible = false
	get_tree().paused = false
	
	if global.time == 22 and wave2: #wave2 big
		pic_wave2.visible = false
		close_but.visible = false
		get_tree().paused = false
	
	if global.time == 47 and wave2: #wave2 big
		pic_wave3.visible = false
		close_but.visible = false
		get_tree().paused = false
		
	if global.time == 72 and wave2: #wave2 big
		pic_wave4.visible = false
		close_but.visible = false
		get_tree().paused = false
