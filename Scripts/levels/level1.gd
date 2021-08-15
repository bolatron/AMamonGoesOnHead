extends Node2D


onready var player = load("res://Scenes/player.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	#player.instance()
	self.add_child(player)
	player.position = Vector2(10, 10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
