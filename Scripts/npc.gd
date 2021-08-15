extends StaticBody2D


var ballon = preload("res://Scenes/dialog_ballon.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_player_start_dialogue():
	var instance = ballon.instance()
	get_parent().add_child(instance)


func _on_player_end_dialogue():
	get_parent().get_node("dialog_ballon").close_dialog()
