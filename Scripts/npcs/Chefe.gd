extends StaticBody2D

var ballon = preload("res://Scenes/dialog_ballon.tscn")
onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_node("/root/level7").connect("ready_finished", self, "post_ready")

func post_ready():
	get_node("/root/level7/player/feet_sensor").connect("dialog_chefe", self, "on_enter")
	get_node("/root/level7/player/feet_sensor").connect("dialog_chefe_exited", self, "_end_dialog")


func on_enter():
	
	var instance = ballon.instance()
		
	get_node("/root/level7").add_child(instance)
	instance.npc_name = self.name
	instance.scene_name = "level7"
	yield(instance, "post_ballon_ready")
	
	if player_vars.win_chefe == false:
		
		player_vars.win_chefe = true
		
		instance.get_node("frame/label").text = "Ha Ha Ha voce vai morrer!"

		player_vars.spawn_position = get_node("/root/level7/player").get_position()
		player_vars.level_returner = "level7"
		yield(get_tree().create_timer(1.0),"timeout")
		assert(get_tree().change_scene("res://Scenes/battle/Battle.tscn") == OK)
	
	else:
		assert(get_tree().change_scene("res://Scenes/cut_scenes/FinalCutScene.tscn") == OK)


func _end_dialog():
	if get_node("/root/level7").has_node("dialog_ballon"):
		get_node("/root/level7/dialog_ballon").close_dialog()
