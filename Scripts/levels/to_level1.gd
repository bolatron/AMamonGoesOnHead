extends Area2D

onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_parent().connect("ready_finished", self, "post_ready")

func post_ready():
	get_parent().get_node("player/feet_sensor").connect("to_level1", self, "on_enter")

func on_enter():
	
	if get_parent().name == 'level2':
		player_vars.spawn_position = Vector2(800, 360)
	elif get_parent().name == 'level5':
		player_vars.spawn_position = Vector2(504, 704)
	elif get_parent().name == 'HouseInterior':
		player_vars.spawn_position = Vector2(344, 381)
	elif get_parent().name == 'HouseInterior2':
		player_vars.spawn_position = Vector2(440, 192)
	elif get_parent().name == 'HouseInterior3':
		player_vars.spawn_position = Vector2(632, 288)
	elif get_parent().name == 'HouseInterior4':
		player_vars.spawn_position = Vector2(632, 478)
		
	assert(get_tree().change_scene("res://Scenes/levels/level1.tscn") == OK)
