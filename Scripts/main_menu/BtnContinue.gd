extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("button_up", self, "_button_pressed")

func _button_pressed():
	assert(get_tree().change_scene("res://Scenes/levels/level1.tscn") == OK)
