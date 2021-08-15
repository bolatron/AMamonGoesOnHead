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
		
		var self_mamon  = get_parent().get_node("self_mamon")
		
		if self_mamon.current_hp_get() >= self_mamon.total_hp_get():
			var info_txt = get_parent().get_node("infoText")
			info_txt.clear()
			info_txt.add_text("Voce ja esta com HP maximo!")
			
			yield(get_tree().create_timer(1.0),"timeout")
			
			return 
		
		if (self_mamon.current_hp_get() + 20) < self_mamon.total_hp_get():
			var info_txt = get_parent().get_node("infoText")
			info_txt.clear()
			info_txt.add_text("Voce curou 20 de HP!")
			
			get_parent().get_node("self_mamon").current_hp_set(-20)
			
			get_parent().get_node("self_mamon/anim").play("heal")
			yield(get_parent().get_node("self_mamon/anim"), "animation_finished")
			
		elif (self_mamon.current_hp_get() + 20) > self_mamon.total_hp_get():
			var info_txt = get_parent().get_node("infoText")
			var heal_value = self_mamon.total_hp_get() - self_mamon.current_hp_get()
			info_txt.clear()
			info_txt.add_text("Voce curou %s de HP!" % heal_value)
			
			get_parent().get_node("self_mamon").current_hp_set(- heal_value)
			
			get_parent().get_node("self_mamon/anim").play("heal")
			yield(get_parent().get_node("self_mamon/anim"), "animation_finished")
		
		emit_signal("turn_end")

func _change_button_state():
	is_not_action = true
