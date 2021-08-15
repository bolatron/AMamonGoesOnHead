extends Area2D

onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_parent().connect("ready_finished", self, "post_ready")

func post_ready():
	get_parent().get_node("player/feet_sensor").connect("to_level2", self, "on_enter")

func on_enter():
	
	if get_parent().name == 'level1':
		player_vars.spawn_position = Vector2(8, 120)
	elif get_parent().name == 'level3':
		player_vars.spawn_position = Vector2(330, 168)
	elif get_parent().name == 'level4':
		player_vars.spawn_position = Vector2(64, 328)
	
	assert(get_tree().change_scene("res://Scenes/levels/level2.tscn") == OK)
