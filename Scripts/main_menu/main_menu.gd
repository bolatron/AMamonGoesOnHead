extends Control


func _ready():
	get_node("music_theme").play()
	self.get_node("container/HBoxContainer/VBoxContainer/logo/anim").play("anim")
