extends StaticBody2D

var ballon = preload("res://Scenes/dialog_ballon.tscn")
onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_node("/root/HouseInterior5").connect("ready_finished", self, "post_ready")

func post_ready():
	get_node("/root/HouseInterior5/player/feet_sensor").connect("dialog_anciao2", self, "on_enter")
	get_node("/root/HouseInterior5/player/feet_sensor").connect("dialog_anciao2_exited", self, "_end_dialog")


func on_enter():
	
	player_vars.mamon_mission = true
	
	var instance = ballon.instance()
	
	get_node("/root/HouseInterior5").add_child(instance)
	instance.npc_name = self.name
	instance.scene_name = "HouseInterior5"
	yield(instance, "post_ballon_ready")
	
	instance.get_node("frame/label").text = "Voce eh o " + player_vars.player_name + \
											"?\nQue bom que veio. Preciso de agua\n" + \
											"para meu cha!!! Va ao lago que\n" + \
											"fica no meio do caminho pra ca.\n"


func _end_dialog():
	if get_node("/root/HouseInterior5").has_node("dialog_ballon"):
		get_node("/root/HouseInterior5/dialog_ballon").close_dialog()
