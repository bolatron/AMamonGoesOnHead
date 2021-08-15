extends Area2D

onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_parent().connect("ready_finished", self, "post_ready")

func post_ready():
	get_parent().get_node("player/feet_sensor").connect("to_level8", self, "on_enter")

func on_enter():
	
	if get_parent().name == 'level4':
		player_vars.spawn_position = Vector2(40, 24)
	elif get_parent().name == 'level7':
		player_vars.spawn_position = Vector2(24, 280)
	
	assert(get_tree().change_scene("res://Scenes/levels/level8.tscn") == OK)
