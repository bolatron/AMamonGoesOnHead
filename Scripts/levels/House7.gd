extends Area2D

func _ready():
	get_parent().connect("ready_finished", self, "post_ready")

func post_ready():
	get_parent().get_node("player/feet_sensor").connect("House7", self, "on_enter")

func on_enter():
	assert(get_tree().change_scene("res://Scenes/levels/HouseInterior7.tscn") == OK)
