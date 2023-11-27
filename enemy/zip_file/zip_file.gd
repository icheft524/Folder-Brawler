extends CharacterBody2D

@onready var target = global.target
@export var normal_speed = 50
@export var hp = 2
@export var file_size = 3
@export var file: InvItem
@export var take_normal_dmg = 1
@export var take_crit_dmg = 2
@export var offset_spawn = 200
var percent = randf_range(0,1)
var speed = normal_speed


var mouse_in = false
var target_position
var direction
var indicator_finished = false

const normal_file = preload("res://enemy/normal_file/normal_file.tscn")

func _ready():
	$indicator.visible = false
	if !global.enemy_file_drop:
		indicating()
	else:
		indicator_finished = true
		sound.zipspawn()
		speeddown()
	global.enemy_file_drop = false
	

func _physics_process(delta):
	if indicator_finished:
		movement()

func movement():
	target_position = target.position
	direction = ( target_position - self.position).normalized()
	#if direction.x > 0:
		#$Sprite2D.flip_h = true
	#elif direction.x < 0:
		#$Sprite2D.flip_h = false
	velocity = Vector2(direction).rotated(rotation) * speed * 1
	move_and_slide()

func _process(delta):
	dead()
	if indicator_finished:
		$hp.text = "zip" + str(hp)

func speeddown():
	speed = normal_speed * global.slow_speed
	await get_tree().create_timer(0.2,false).timeout
	speed = normal_speed

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in && indicator_finished && !global.inv_open:
			get_viewport().set_input_as_handled()
			if percent > global.crit_chance:
				sound.critical()
				hp -= take_crit_dmg
			elif percent <= global.crit_chance:
				sound.enemyhit()
				hp -= take_normal_dmg
			speeddown()


func _on_area_2d_mouse_entered():
	mouse_in = true


func _on_area_2d_mouse_exited():
	mouse_in = false

func dead():
	if hp <= 0:
		global.shaking = true
		queue_free()
		_spawn_file(3)
		
func _spawn_file(count: int):
	for i in range(count):
		var fileins = normal_file.instantiate()
		global.enemy_file_drop = true
		fileins.position = position
		fileins.set_meta("broken_pos",position - Vector2(randf_range(-1,1) * offset_spawn,randf_range(-1,1) * offset_spawn))
		get_parent().add_child(fileins)
	pass

func _on_area_2d_area_entered(area):
	if area.is_in_group("folder") and visible and indicator_finished:
		indicator_finished = false
		await get_tree().create_timer(0.2,false).timeout
		target.collect(file,hp,file_size,'zip')
		target.capacity += file_size
		global.shaking = true
		sound.playerhit()
		queue_free()
		
func indicating():
	$indicator.visible = true
	$Sprite2D.visible = false
	$Area2D.monitoring = false
	await get_tree().create_timer(1,false).timeout
	indicator_finished = true
	$Area2D.monitoring = true
	$indicator.visible = false
	$Sprite2D.visible = true
	sound.zipspawn()
	speeddown()
		
func respawn():
	visible = true
	position = get_global_mouse_position()
