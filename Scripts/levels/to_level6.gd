extends Area2D

onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_parent().connect("ready_finished", self, "post_ready")

func post_ready():
	get_parent().get_node("player/feet_sensor").connect("to_level6", self, "on_enter")

func on_enter():
	
	if get_parent().name == 'level5':
		player_vars.spawn_position = Vector2(224, 20)
	elif get_parent().name == 'HouseInterior6':
		player_vars.spawn_position = Vector2(160, 192)
	elif get_parent().name == 'HouseInterior7':
		player_vars.spawn_position = Vector2(304, 192)
	
	assert(get_tree().change_scene("res://Scenes/levels/level6.tscn") == OK)
