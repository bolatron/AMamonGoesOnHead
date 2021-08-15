extends Node2D

signal npc_path(path)
var ballon = preload("res://Scenes/dialog_ballon.tscn")

func _ready():
	get_node("/root/level1").connect("ready_finished", self, "post_ready")

func post_ready():
	get_node("/root/level1/player/feet_sensor").connect("dialog", self, "on_enter")
	get_node("/root/level1/player/feet_sensor").connect("dialog_exited", self, "_end_dialog")


func on_enter():
	
	var instance = ballon.instance()
	emit_signal("npc_path", self.get_path())
	
	get_node("/root/level1").add_child(instance)
	
	yield(instance, "post_ballon_ready")
	
	instance.get_node("frame/label").text = "Eu sou a enfermeira Joice.\n" + \
											"Deseja curar seu mamon?"
	
