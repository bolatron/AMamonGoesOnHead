extends Button

onready var scn_changer = preload("res://scenes/Transitions/Transitions.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("pressed", self, "_button_pressed")
	
func _button_pressed():
		
		var info_txt = get_parent().get_node("infoText")
		info_txt.clear()
		info_txt.add_text("Voce selecionou correr!")
		
		yield(get_tree().create_timer(2.0),"timeout")
		get_parent().add_child(scn_changer)
		scn_changer.next_scene("res://Scenes/levels/level1.tscn")
		scn_changer.load_state()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
