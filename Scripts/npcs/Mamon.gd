extends StaticBody2D

signal on_enter_finished()
var ballon = preload("res://Scenes/dialog_ballon.tscn")
onready var player_vars = get_node("/root/PlayerVariables")


func _ready():
	get_node("/root/level4").connect("ready_finished", self, "post_ready")
	player_vars.mamon_mission = false

func post_ready():
	get_node("/root/level4/player/feet_sensor").connect("dialog_mamon", self, "on_enter")
	get_node("/root/level4/player/feet_sensor").connect("dialog_mamon_exited", self, "_end_dialog")


func on_enter():
	
	player_vars.mamons = 4
	var instance = ballon.instance()
	
	get_node("/root/level4").add_child(instance)
	instance.npc_name = self.name
	instance.scene_name = "level4"
	yield(instance, "post_ballon_ready")
	
	instance.get_node("frame/label").text = "Agora eu sou seu!!!"


func _end_dialog():
	if get_node("/root/level4").has_node("dialog_ballon"):
		get_node("/root/level4/dialog_ballon").close_dialog()
		
	queue_free()
