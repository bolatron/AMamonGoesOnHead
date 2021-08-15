extends Node2D


onready var scn_changer = preload("res://scenes/Transitions/Transitions.tscn").instance()


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().add_child(scn_changer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
