extends StaticBody2D

var ballon = preload("res://Scenes/dialog_ballon.tscn")
onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_node("/root/level1").connect("ready_finished", self, "post_ready")

func post_ready():
	get_node("/root/level1/player/feet_sensor").connect("dialog_joice", self, "on_enter")
	get_node("/root/level1/player/feet_sensor").connect("dialog_joice_exited", self, "_end_dialog")


func on_enter():
	
	var instance = ballon.instance()
	
	get_node("/root/level1").add_child(instance)
	instance.npc_name = self.name
	instance.scene_name = "level1"
	yield(instance, "post_ballon_ready")
	
	instance.get_node("frame/label").text = "Eu sou a enfermeira Joice.\n" + \
											"Acabei de curar seu mamon!"
											
	player_vars.current_mamon_hp = 200
	
	


func _end_dialog():
	if get_node("/root/level1").has_node("dialog_ballon"):
		get_node("/root/level1/dialog_ballon").close_dialog()
