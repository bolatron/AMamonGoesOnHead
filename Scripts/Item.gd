extends Area2D

onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_parent().connect("ready_finished", self, "post_ready")

func post_ready():
	get_parent().get_node("player/feet_sensor").connect("Item", self, "on_enter")
	get_parent().get_node("player/feet_sensor").connect("Item_exited", self, "_end_dialog")


func on_enter():
	player_vars.qtd_itens += 1

func _end_dialog():
	queue_free()
