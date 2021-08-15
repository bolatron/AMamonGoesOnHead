extends StaticBody2D

var ballon = preload("res://Scenes/dialog_ballon.tscn")
onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_node("/root/HouseInterior").connect("ready_finished", self, "post_ready")

func post_ready():
	get_node("/root/HouseInterior/player/feet_sensor").connect("dialog_anciao", self, "on_enter")
	get_node("/root/HouseInterior/player/feet_sensor").connect("dialog_anciao_exited", self, "_end_dialog")


func on_enter():
	
	var instance = ballon.instance()
	
	get_node("/root/HouseInterior").add_child(instance)
	instance.npc_name = self.name
	instance.scene_name = "HouseInterior"
	yield(instance, "post_ballon_ready")
	
	instance.get_node("frame/label").text = "Olha se nao eh o " + player_vars.player_name + "!\n" + \
											"O anciao da vila ao leste precisa\nde sua ajuda."

func _end_dialog():
	if get_node("/root/HouseInterior").has_node("dialog_ballon"):
		get_node("/root/HouseInterior/dialog_ballon").close_dialog()
