extends Area2D

onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_parent().connect("ready_finished", self, "post_ready")

func post_ready():
	get_parent().get_node("player/feet_sensor").connect("to_level4", self, "on_enter")

func on_enter():
	
	if get_parent().name == 'level2':
		player_vars.spawn_position = Vector2(64, 24)
	elif get_parent().name == 'level8':
		player_vars.spawn_position = Vector2(48, 360)

	assert(get_tree().change_scene("res://Scenes/levels/level4.tscn") == OK)
