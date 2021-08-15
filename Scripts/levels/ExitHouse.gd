extends Area2D

onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_parent().connect("ready_finished", self, "post_ready")

func post_ready():
	get_parent().get_node("player/feet_sensor").connect("to_level1", self, "on_enter")

func on_enter():
	assert(get_tree().change_scene("res://Scenes/levels/level1.tscn") == OK)
