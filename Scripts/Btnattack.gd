extends Button

signal turn_end()

var is_not_action = true 

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("pressed", self, "_button_pressed")
	get_parent().get_node("self_mamon").connect("enemy_turn_end", self, "_change_button_state")
	
	
func _button_pressed():
	
	if is_not_action:
		
		is_not_action = false
		
		var info_txt = get_parent().get_node("infoText")
		info_txt.clear()
		info_txt.add_text("Voce selecionou atacar!\nVoce deu 20 de dano!")
		
		get_parent().get_node("enemy_mamon/anim").play("hit")
		yield(get_parent().get_node("enemy_mamon/anim"), "animation_finished")
		
		get_parent().get_node("enemy_mamon").current_hp_set(20)
		
		if get_parent().get_node("enemy_mamon").current_hp_get() > 0:
			yield(get_tree().create_timer(2.0),"timeout")
			emit_signal("turn_end")


func _change_button_state():
	is_not_action = true
