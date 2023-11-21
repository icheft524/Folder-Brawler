extends CharacterBody2D

@onready var target = $"../folder"
@export var speed = 50
@export var hp = 2

@export var file: InvItem


var mouse_in = false
var target_position
var direction

const normal_file = preload("res://enemy/normal_file/normal_file.tscn")


func _physics_process(delta):
	movement()
	pass

func movement():
	target_position = target.position
	direction = ( target_position - self.position).normalized()
	if direction.x > 0:
		$Sprite2D.flip_h = true
	elif direction.x < 0:
		$Sprite2D.flip_h = false
	velocity = Vector2(direction).rotated(rotation) * speed * 1
	move_and_slide()


func _process(delta):
	dead()
	
	$hp.text = "zip" + str(hp)


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			hp -= 1


func _on_area_2d_mouse_entered():
	mouse_in = true


func _on_area_2d_mouse_exited():
	mouse_in = false

func dead():
	if hp == 0:
		queue_free()
		var filespawn_top = $top.global_position
		var file_top = normal_file.instantiate()
		file_top.position = filespawn_top
		get_parent().add_child(file_top)
		
		var filespawn_mid = $mid.global_position
		var file_mid = normal_file.instantiate()
		file_mid.position = filespawn_mid
		get_parent().add_child(file_mid)
		
		var filespawn_bot = $bot.global_position
		var file_bot = normal_file.instantiate()
		file_bot.position = filespawn_bot
		get_parent().add_child(file_bot)
		
		

func _on_area_2d_area_entered(area):
	if area.is_in_group("folder"):
		target.collect(file,hp)
		target.hp -= 1
		queue_free()
