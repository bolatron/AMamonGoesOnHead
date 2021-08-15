extends Control

signal new_dialog()
signal pass_dialog()
	
onready var player_vars = get_node("/root/PlayerVariables")
onready var dialog_text = preload("res://Scenes/cut_scenes/dialog_text.tscn").instance()
onready var name_setter = preload("res://Scenes/cut_scenes/NameSetter.tscn").instance()

onready var text =  [	"Se aventure em um mundo ficticio, o continente de Androssa, ...",
				"cheio de criaturas que sao domadas por pessoas humanas intituladas de cacadores.",
				"Essas criaturas sao chamadas de mamons, ...",
				"que sao vistas com certo medo pelos humanos por serem mais fortes ...",
				"e possuirem poderes elementais.",
				"O nome do personagem eh ...",
				"Qual eh seu nome mesmo?",
				"Ah.. eh mesmo, seu nome eh ",
				"Um jovem que vivia em uma pequena vila ao oeste do continente.", 
				"Certo dia, o jovem acabou encontrando um mamon em sua ida para a floresta.",
				"Esse mamon estava extremamente ferido, ...", 
				"e possivelmente estava fugindo de um lugar bem distante.",
				"O jovem cuida do mamon, e como sinal de gratidao ele se submete ao jovem, ...",
				"transformando assim, o jovem em um cacador."
			]


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(2.0),"timeout")
	
	self.add_child(dialog_text)
	
	for dialog in text:
		get_node("container/frame/v_container/label").text = dialog
		
		if dialog == "Ah.. eh mesmo, seu nome eh ":
			get_node("container/frame/v_container/label").text = dialog + \
														player_vars.player_name
		
		emit_signal("new_dialog")
		
		if dialog == "Qual eh seu nome mesmo?":
			self.add_child(name_setter)
			yield(name_setter, "continue_cut_scene")
			name_setter.queue_free()
		else:
			yield(get_node("container/frame/v_container/label"), "end_dialog")

		yield(self, "pass_dialog")
		
	yield(get_tree().create_timer(1.0),"timeout")
	assert(get_tree().change_scene("res://Scenes/levels/level1.tscn") == OK)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("pass_dialog")
