extends Node2D

var width = 200

signal post_ballon_ready()
onready var npc_name = ""
onready var scene_name = ""

onready var tween = get_node("tween")

func _ready():
	yield(get_tree().create_timer(0.2), "timeout")
	self.position = get_node("/root/" + scene_name + "/Npcs/" + npc_name).position + Vector2(0, -50)
	get_node("frame").set_height(50)
	
	tween.interpolate_method(self, "resize", 0, 1, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	tween.start()
	yield(tween, "tween_completed")
	
	emit_signal("post_ballon_ready")


func resize(value):
	get_node("frame").set_width(value * width)


func close_dialog():
	
	get_node("frame/label").text = ""
	
	tween.interpolate_method(self, "resize", 1, 0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	tween.start()
	yield(tween, "tween_completed")

	queue_free()
