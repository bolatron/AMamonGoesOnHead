extends Node2D

signal ready_finished()

signal self_turn_end()
signal enemy_turn_end()

signal enemy_hp_changed()
signal self_hp_changed()

enum Action {Attack, Heal}

var i = 0

onready var player_vars = get_node("/root/PlayerVariables")
onready var mamon = preload("res://Scenes/battle/mamon.tscn")
onready var scn_changer = preload("res://scenes/Transitions/Transitions.tscn").instance()


var random = RandomNumberGenerator.new()
var is_not_action = true	# Check if a button is already on action

func _ready():
	
	random.randomize()
	var self_mamon = mamon.instance()
	
	self_mamon.set_name("SelfMamon")
	self_mamon.get_node("Sprite").region_rect = \
					 		self_mamon.sprite_rect[player_vars.mamons]

	var w_offset = self_mamon.get_node("Sprite").get_rect().size.x / 2
	var h_offset = self_mamon.get_node("Sprite").get_rect().size.y / 2
	
	self_mamon.set_position(Vector2(48 - w_offset, 200 - h_offset))
	self_mamon.get_node("Sprite").flip_h = true
	self_mamon.nome = self_mamon.Name.keys()[player_vars.mamons]
	self_mamon.set_current_hp(player_vars.current_mamon_hp)
	
	add_child(self_mamon)
	
	var enemy_mamon = mamon.instance()
	
	var choose = random.randi_range(0, 10)
	
	enemy_mamon.set_name("EnemyMamon")
	enemy_mamon.set_position(Vector2(224, 24))
	enemy_mamon.get_node("Sprite").region_rect = \
					 		enemy_mamon.sprite_rect[choose]
	enemy_mamon.nome = enemy_mamon.Name.keys()[choose]
	enemy_mamon.set_current_hp(200)
	
	add_child(enemy_mamon)

	# Connecting signals
	var BtnAttackPath = "HUD/ContainerButtons/GridContainer/BtnAttack"
	get_node(BtnAttackPath).connect("pressed", self, "_BtnAttack_pressed")

	var BtnHealPath = "HUD/ContainerButtons/GridContainer/BtnHeal"
	get_node(BtnHealPath).connect("pressed", self, "_BtnHeal_pressed")
	
	var BtnItem = "HUD/ContainerButtons/GridContainer/BtnItem"
	get_node(BtnItem).connect("pressed", self, "_BtnItem_pressed")
	
	var BtnRun = "HUD/ContainerButtons/GridContainer/BtnRun"
	get_node(BtnRun).connect("pressed", self, "_BtnRun_pressed")
	
	connect("self_turn_end", self, "_enemy_turn")
	connect("enemy_turn_end", self, "_enable_buttons")
	
	emit_signal("ready_finished")


func _enable_buttons():
	player_vars.current_mamon_hp = get_node("SelfMamon").get_current_hp()
	is_not_action = true


func _BtnAttack_pressed():

	if is_not_action:
		is_not_action = false
		
		random.randomize()
		var damage = random.randi_range(-80, -140)

		var InfoTextPath = "HUD/ContainerInfoText/InfoText"
		get_node(InfoTextPath).text = 	"Voce selecionou atacar!\n\n" + \
										"Voce deu " + str(abs(damage)) + \
										" de dano!"
		
		get_node("EnemyMamon/Anim").play("hit")
		yield(get_node("EnemyMamon/Anim"), "animation_finished")
		
		get_node("EnemyMamon").set_current_hp(damage)
		emit_signal("enemy_hp_changed")
		
		if get_node("EnemyMamon").get_current_hp() == 0:
			
			get_node(InfoTextPath).text = "Voce ganhou!"
			yield(get_tree().create_timer(2.0),"timeout")
			get_tree().change_scene("res://Scenes/levels/" + player_vars.level_returner + ".tscn")
		
		yield(get_tree().create_timer(1.0),"timeout")
		emit_signal("self_turn_end")
	
func _BtnHeal_pressed():

	if is_not_action:
		is_not_action = false

		random.randomize()
		var heal = random.randi_range(20, 100)

		var InfoTextPath = "HUD/ContainerInfoText/InfoText"
		get_node(InfoTextPath).text = 	"Voce se curou em " + str(heal) + "!"

		get_node("SelfMamon/Anim").play("heal")
		yield(get_node("SelfMamon/Anim"), "animation_finished")

		get_node("SelfMamon").set_current_hp(heal)
		emit_signal("self_hp_changed")

		yield(get_tree().create_timer(1.0),"timeout")
		emit_signal("self_turn_end")

func _BtnItem_pressed():
	
	if is_not_action:
		is_not_action = false
		
		var InfoTextPath = "HUD/ContainerInfoText/InfoText"
		if player_vars.qtd_itens == 0:
			get_node(InfoTextPath).text = 	"Voce nao possui itens!"
		else:
			player_vars.qtd_itens -= 1
			
			get_node(InfoTextPath).text = 	"Voce utilizou um item!\n" + \
											"Voce curou 140HP!\n" +\
											"Restam " + \
											str(player_vars.qtd_itens) + "!"
			
			get_node("SelfMamon").set_current_hp(140)
			get_node("SelfMamon/Anim").play("use_item")
			yield(get_node("SelfMamon/Anim"), "animation_finished")
			emit_signal("self_hp_changed")
			
			yield(get_tree().create_timer(1.0),"timeout")
			emit_signal("self_turn_end")
	
func _BtnRun_pressed():
	
	var InfoTextPath = "HUD/ContainerInfoText/InfoText"
	get_node(InfoTextPath).text = 	"Voce fugiu da batalha!"
	
	yield(get_tree().create_timer(2.0),"timeout")
	add_child(scn_changer)
	scn_changer.next_scene("res://Scenes/levels/" + player_vars.level_returner + ".tscn")
	scn_changer.load_state()


func _enemy_turn():
	random.randomize()
	var action = random.randi_range(0, 1)
	
	match action:
		0:	_enemy_attack()
		1:	_enemy_heal()


func _enemy_attack():
	random.randomize()
	var damage = random.randi_range(-60, -100)

	var InfoTextPath = "HUD/ContainerInfoText/InfoText"
	get_node(InfoTextPath).text = 	"Inimigo atacou!\n\n" + \
									"Inimigo deu " + str(abs(damage)) + \
									" de dano!"
	
	get_node("SelfMamon/Anim").play("hit")
	yield(get_node("SelfMamon/Anim"), "animation_finished")
	
	get_node("SelfMamon").set_current_hp(damage)
	emit_signal("self_hp_changed")
	
	if get_node("SelfMamon").get_current_hp() == 0:
		
		get_node(InfoTextPath).text = "Voce perdeu!"
		yield(get_tree().create_timer(2.0),"timeout")
		get_tree().change_scene("res://Scenes/cut_scenes/LoseCutScene.tscn")
	
	yield(get_tree().create_timer(1.0),"timeout")
	emit_signal("enemy_turn_end")


func _enemy_heal():
	random.randomize()
	var heal = random.randi_range(40, 100)

	var InfoTextPath = "HUD/ContainerInfoText/InfoText"
	get_node(InfoTextPath).text = 	"Inimigo se curou em " + str(heal) + "!"
	
	get_node("EnemyMamon/Anim").play("heal")
	yield(get_node("EnemyMamon/Anim"), "animation_finished")
	
	get_node("EnemyMamon").set_current_hp(heal)
	emit_signal("enemy_hp_changed")
	
	yield(get_tree().create_timer(1.0),"timeout")
	emit_signal("enemy_turn_end")
