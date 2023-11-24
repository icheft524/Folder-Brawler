extends CharacterBody2D

@onready var target = global.target
@export var speed = 150
@export var hp = 3
@export var file_size = 1
@export var take_normal_dmg = 1
@export var take_crit_dmg = 2
var percent = randf_range(0,1)

@export var file: InvItem

var mouse_in = false
var target_position
var direction

func _ready():
	sound.enemyspawn()

func _physics_process(delta):
	movement()
	pass

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
	
	$hp.text = "normal" + str(hp)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			get_viewport().set_input_as_handled()
			sound.enemyhit()
			#hp -= 1
			if percent > global.crit_chance:
				hp -= take_crit_dmg
			elif percent <= global.crit_chance:
				hp -= take_normal_dmg
			speed = speed * 0.5
			await get_tree().create_timer(0.2,false).timeout
			speed = speed / 0.5

func _on_area_2d_mouse_entered():
	mouse_in = true


func _on_area_2d_mouse_exited():
	mouse_in = false

func dead():
	if hp == 0:
		#sound.enemydeath()
		queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("folder") and visible:
		target.collect(file,hp,file_size,'normal')
		sound.playerhit()
		target.capacity += file_size
		queue_free()
		



