extends Control


func _ready():
	yield(get_tree().create_timer(5.0),"timeout")
	assert(get_tree().change_scene("res://Scenes/main_menu.tscn") == OK)
