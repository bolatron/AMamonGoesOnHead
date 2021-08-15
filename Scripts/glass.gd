extends TileMap

var rng = RandomNumberGenerator.new()
onready var scn_changer = preload("res://scenes/Transitions/Transitions.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D2_body_entered(body):
	rng.randomize()
	if rng.randi() % 1 == 0:
		get_parent().add_child(scn_changer)
		scn_changer.next_scene("res://Scenes/battle.tscn")
		scn_changer.load_state()
