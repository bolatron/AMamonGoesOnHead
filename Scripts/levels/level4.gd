extends Node2D

signal ready_finished()

onready var player_vars = get_node("/root/PlayerVariables")
onready var player = preload("res://Scenes/player.tscn").instance()
onready var item = preload("res://Scenes/Item.tscn").instance()
onready var mamon = preload("res://Scenes/Mamon.tscn").instance()
onready var obstacle = preload("res://Scenes/obstacle.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_child(player)
	player.position = player_vars.spawn_position
	
	player.get_node("camera").limit_top = 0
	player.get_node("camera").limit_bottom = 384
	player.get_node("camera").limit_right = 384
	player.get_node("camera").limit_left = 0

	if player_vars.itens_list.has(5):
		self.add_child(item)
		item.position = Vector2(344, 313)
		player_vars.itens_list.erase(5)
		
	if player_vars.mamons == -1 and player_vars.mamon_mission == true:
		get_node("Npcs").add_child(mamon)
		mamon.position = Vector2(195, 85)
		
	if player_vars.main_mission == false:
		add_child(obstacle)
	
	emit_signal("ready_finished")
