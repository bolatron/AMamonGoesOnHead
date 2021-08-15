extends Button

signal turn_end()

func _ready():
	self.connect("pressed", self, "_button_pressed")
	
func _button_pressed():
	var info_txt = get_parent().get_node("infoText")
	info_txt.clear()
	info_txt.add_text("You selected change mamon!")
	
	get_parent().get_node("self_mamon/sprite").region_rect = Rect2(256, 0, 64, 64)
	
	emit_signal("turn_end")
