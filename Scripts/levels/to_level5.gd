extends Area2D

onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_parent().connect("ready_finished", self, "post_ready")

func post_ready():
	get_parent().get_node("player/feet_sensor").connect("to_level5", self, "on_enter")

func on_enter():
	
	if get_parent().name == 'level1':
		player_vars.spawn_position = Vector2(120, 16)
	elif get_parent().name == 'level6':
		player_vars.spawn_position = Vector2(160, 280)
	
	assert(get_tree().change_scene("res://Scenes/levels/level5.tscn") == OK)
