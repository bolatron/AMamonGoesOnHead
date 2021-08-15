extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_new_game_pressed():
	get_node("/root/main_menu/music_theme").stop()
	get_parent().get_node("button_pressed").play()
	yield(get_parent().get_node("button_pressed"), "finished")
	assert(get_tree().change_scene("res://Scenes/cut_scenes/first_scene.tscn") == OK)
