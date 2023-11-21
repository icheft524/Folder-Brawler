extends CharacterBody2D

@onready var target = $"../folder"
@export var speed = 100
@export var hp = 2

@export var file: InvItem

var mouse_in = false
var target_position
var direction


func _ready():
	pass

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
	if area.is_in_group("folder"):
		target.collect(file,hp)
		target.hp -= 1
		queue_free()


		
