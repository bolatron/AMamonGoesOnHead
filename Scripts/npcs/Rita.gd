extends StaticBody2D

var ballon = preload("res://Scenes/dialog_ballon.tscn")
onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_node("/root/level1").connect("ready_finished", self, "post_ready")

func post_ready():
	get_node("/root/level1/player/feet_sensor").connect("dialog_rita", self, "on_enter")
	get_node("/root/level1/player/feet_sensor").connect("dialog_rita_exited", self, "_end_dialog")


func on_enter():
	
	if not get_node("/root/level1").has_node("dialog_ballon"):
		var instance = ballon.instance()
		
		get_node("/root/level1").add_child(instance)
		instance.npc_name = self.name
		instance.scene_name = "level1"
		yield(instance, "post_ballon_ready")
		
		instance.get_node("frame/label").text = "Ah, eh o " + player_vars.player_name + \
												"!\n" + "O velho da vila esta te" +\
												" esperando\nna cabana.\n"
	
	


func _end_dialog():
	if get_node("/root/level1").has_node("dialog_ballon"):
		get_node("/root/level1/dialog_ballon").close_dialog()
