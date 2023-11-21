extends Node2D

@export var spawns: Array[spawn_info] = []
@export var enemy_upgrade_time = 10
@export var enemyhpincrease = 3
@export var enemyhpcap = 30
@onready var player = $"../folder"

#var time = 0
func _ready():
	global.time = 0
	
func respawn_normal(ehp):
	var normal_enemy = load("res://enemy/normal_file/normal_file.tscn")
	var enemy_spawn = normal_enemy.instantiate()
	enemy_spawn.hp = ehp
	enemy_spawn.global_position = get_global_mouse_position()
	add_child(enemy_spawn)
	
func respawn_zip(ehp):
	var zip_enemy = load("res://enemy/zip_file/zip_file.tscn")
	var enemy_spawn = zip_enemy.instantiate()
	enemy_spawn.hp = ehp
	enemy_spawn.global_position = get_global_mouse_position()
	add_child(enemy_spawn)

func _on_timer_timeout():
	global.time += 1
	print(global.time)
	var enemy_spawns = spawns
	for i in enemy_spawns:
		if global.time >= i.time_start and global.time <= i.time_end:
			if i.spawn_delay_counter < i.enemy_spawn_delay:
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0
				var new_enemy = load(str(i.enemy.resource_path))
				var enemy_spawn = new_enemy.instantiate()
				var counter = 0
				while counter < i.enemy_num:
					#var enemy_spawn = new_enemy.instantiate()
					#if global.time >= enemy_upgrade_time:
						#enemy_spawn.hp += enemyhpincrease*(floor(global.time/enemy_upgrade_time))
						#if enemy_spawn.hp > enemyhpcap:
							#enemy_spawn.hp = enemyhpcap
					enemy_spawn.global_position = get_random_position()
					add_child(enemy_spawn)
					
					counter += 1
					
					
func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.1,1.4)
	var top_left = Vector2(player.position.x - vpr.x/2, player.position.y - vpr.y/2)
	var top_right = Vector2(player.position.x + vpr.x/2, player.position.y - vpr.y/2)
	var bot_left = Vector2(player.position.x - vpr.x/2, player.position.y + vpr.y/2)
	var bot_right = Vector2(player.position.x + vpr.x/2, player.position.y + vpr.y/2)
	
	var pos_side = ['up','down','right','left'].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		'up':
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		'down':
			spawn_pos1 = bot_left
			spawn_pos2 = bot_right
		'right':
			spawn_pos1 = top_right
			spawn_pos2 = bot_right
		'left':
			spawn_pos1 = top_left
			spawn_pos2 = bot_left
			
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	
	return Vector2(x_spawn,y_spawn)
