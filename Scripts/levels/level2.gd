extends Node2D

signal ready_finished()

onready var player_vars = get_node("/root/PlayerVariables")
onready var player = preload("res://Scenes/player.tscn").instance()
onready var item = preload("res://Scenes/Item.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_child(player)
	player.position = player_vars.spawn_position
	
	player.get_node("camera").limit_top = 0
	player.get_node("camera").limit_bottom = 336 
	player.get_node("camera").limit_right = 352
	player.get_node("camera").limit_left = 0
	
	if player_vars.itens_list.has(4):
		self.add_child(item)
		item.position = Vector2(152, 64)
		player_vars.itens_list.erase(4)
	
	emit_signal("ready_finished")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
