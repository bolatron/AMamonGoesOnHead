extends Node2D

signal ready_finished()

onready var player_vars = get_node("/root/PlayerVariables")
onready var player = preload("res://Scenes/player.tscn").instance()


func _ready():
	self.add_child(player)
	player.position = Vector2(144, 192)
	player.scale = Vector2(2, 2)
	
	player.get_node("camera").limit_top = 0
	player.get_node("camera").limit_bottom = 272
	player.get_node("camera").limit_right = 382-16
	player.get_node("camera").limit_left = -16

	emit_signal("ready_finished")
