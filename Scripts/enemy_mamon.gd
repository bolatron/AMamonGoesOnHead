extends Node2D

var total_hp = 200
var current_hp = 50 setget current_hp_set, current_hp_get
var nome = "Mamon inimigo"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_node("hp").text = str(current_hp) + "/" + str(total_hp)
	get_node("name").text = nome


func current_hp_get():
	return current_hp


func current_hp_set(value):
	if (current_hp - value) > 0:
		current_hp -= value
		get_node("hp").text = str(current_hp) + "/" + str(total_hp)
	else:
		current_hp = 0
		get_node("hp").text = str(current_hp) + "/" + str(total_hp)
		
		var info_txt = get_parent().get_node("infoText")
		info_txt.clear()
		info_txt.add_text("You win!")
		yield(get_tree().create_timer(2.0),"timeout")
		get_tree().change_scene("res://Scenes/levels/level1.tscn")
