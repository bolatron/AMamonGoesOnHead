extends Control

signal continue_cut_scene()

onready var player_vars = get_node("/root/PlayerVariables")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("LineEdit").text = player_vars.player_name
	get_node("LineEdit").connect("text_entered", self, "_change_name")
	

func _change_name(text):
	player_vars.player_name = text
	emit_signal("continue_cut_scene")
