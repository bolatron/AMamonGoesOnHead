extends Label

signal end_dialog()

var timer
var wt = .05

# Called when the node enters the scene tree for the first time.
func _ready():
	
	timer = Timer.new()
	timer.set_wait_time(wt)
	add_child(timer)
	timer.connect("timeout", self, "_on_writter")
	get_node("/root/first_scene").connect("new_dialog", self, "_on_timer")
	
func _on_timer():
	get_node("../sprite").visible = false
	get_node("../sprite/anim").stop()
	
	self.set_visible_characters(0)
	timer.start()
	
func _on_writter():
	set_visible_characters(get_visible_characters() + 1)
	if get_visible_characters() == get_total_character_count():
		get_node("../sprite").visible = true
		get_node("../sprite/anim").play("activate")
		timer.stop()
		emit_signal("end_dialog")
