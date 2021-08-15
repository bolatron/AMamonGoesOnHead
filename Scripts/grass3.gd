extends TileMap

var rng = RandomNumberGenerator.new()
onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	get_parent().connect("ready_finished", self, "post_ready")

func post_ready():
	get_parent().get_node("player/feet_sensor").connect("grass3", self, "on_enter")

func on_enter():
	rng.randomize()
	if rng.randi() % 6 == 0 && (player_vars.mamons != -1):
		
		player_vars.spawn_position = get_node("/root/level8/player").get_position()
		player_vars.level_returner = "level8"
		
		assert(get_tree().change_scene("res://Scenes/battle/Battle.tscn") == OK)
