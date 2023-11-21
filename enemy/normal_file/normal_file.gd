extends CharacterBody2D

@onready var target = global.target
@export var speed = 500
@export var hp = 2
@export var stop = randf_range(0,2)

@export var file: InvItem

var mouse_in = false
var target_position
var direction
var delay_pos


func _ready():
	delay_pos = target.position
	pass

func _physics_process(delta):
	movement()
	pass

func movement():
	target_position = delay_pos
	direction = ( target_position - self.position).normalized()
	if direction.x > 0:
		$Sprite2D.flip_h = true
	elif direction.x < 0:
		$Sprite2D.flip_h = false
	velocity = Vector2(direction).rotated(rotation) * speed * 1
	move_and_slide()
	


func _process(delta):
	dead()
	
	$hp.text = "normal" + str(hp)

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

func _on_area_2d_area_entered(area):
	if area.is_in_group("folder") and visible:
		target.collect(file,hp,'normal')
		target.hp -= 1
		visible = false
		
func respawn():
	visible = true
	position = get_global_mouse_position()


func _on_timer_timeout():
	delay_pos = target.position
	speed = 0
	await get_tree().create_timer(stop,false).timeout
	speed = 500

