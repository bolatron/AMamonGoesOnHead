extends StaticBody2D

var ballon = preload("res://Scenes/dialog_ballon.tscn")
onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_node("/root/HouseInterior6").connect("ready_finished", self, "post_ready")

func post_ready():
	get_node("/root/HouseInterior6/player/feet_sensor").connect("dialog_jacinto", self, "on_enter")
	get_node("/root/HouseInterior6/player/feet_sensor").connect("dialog_jacinto_exited", self, "_end_dialog")


func on_enter():
	
	var instance = ballon.instance()
	
	get_node("/root/HouseInterior6").add_child(instance)
	instance.npc_name = self.name
	instance.scene_name = "HouseInterior6"
	yield(instance, "post_ballon_ready")
	
	instance.get_node("frame/label").text = "SOCORRRO! TA PEGANDO FOGO BICHO!\n" + \
											"Os bandidos saquearam a vila!!\n" + \
											"Um deles falou que iam para o\n" + \
											"esconderijo abaixo do lago."

	player_vars.main_mission = true

func _end_dialog():
	if get_node("/root/HouseInterior6").has_node("dialog_ballon"):
		get_node("/root/HouseInterior6/dialog_ballon").close_dialog()
