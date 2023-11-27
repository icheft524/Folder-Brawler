extends CharacterBody2D

@onready var target = global.target
@export var normal_speed = 150
@export var speed_range = 100
@export var hp = 1
@export var file_size = 1
@export var take_normal_dmg = 1
@export var take_crit_dmg = 2
#var slow_speed = normal_speed * 0.5
var percent = randf_range(0,1)
var speed = normal_speed

@export var file: InvItem

var mouse_in = false
var indicator_finished = false
var target_position
var direction


func _ready():
	$indicator.visible = false
	if !global.enemy_file_drop:
		indicating()
	else:
		indicator_finished = true
		$spawnanim.play("spawn")
		sound.enemyspawn()
		speeddown()
	global.enemy_file_drop = false
	if not (get_meta("broken_pos") == Vector2.ZERO):
		var tween = create_tween()
		tween.tween_property(self,"position",get_meta("broken_pos"),0.3).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		tween.play()
		pass

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
		$hp.text = "normal" + str(hp)
		$speed.text = str(speed)

func speeddown():
	speed = normal_speed * global.slow_speed
	await get_tree().create_timer(0.5,false).timeout
	speed = randi_range(normal_speed,normal_speed+speed_range)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in && indicator_finished && !global.inv_open:
			get_viewport().set_input_as_handled()
			#hp -= 1
			if percent > global.crit_chance:
				sound.critical()
				hp -= take_crit_dmg
			elif percent <= global.crit_chance:
				hp -= take_normal_dmg
				sound.enemyhit()
			speeddown()

func _on_area_2d_mouse_entered():
	mouse_in = true


func _on_area_2d_mouse_exited():
	mouse_in = false

func dead():
	if hp <= 0:
		#sound.enemydeath()
		global.shaking = true
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
	$spawnanim.play("spawn")
	sound.enemyspawn()
	speeddown()


func _on_area_2d_area_entered(area):
	if area.is_in_group("folder") and visible and indicator_finished:
		indicator_finished = false
		await get_tree().create_timer(0.2,false).timeout
		target.collect(file,hp,file_size,'normal')
		sound.playerhit()
		target.capacity += file_size
		global.shaking = true
		queue_free()
		



