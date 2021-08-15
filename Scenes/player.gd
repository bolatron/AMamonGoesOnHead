extends KinematicBody2D

export var speed = 96

signal start_dialogue()
signal end_dialogue()

onready var sprite = $sprite
var UP = Vector2(0, -1)
var move_direction = Vector2(0, 0)

var flag = 1

func _process(delta):
	
	if Input.is_action_pressed("ui_right"):
		sprite.play("walk_side")
		sprite.flip_h = true
	elif Input.is_action_pressed("ui_left"):
		sprite.play("walk_side")
		sprite.flip_h = false
	elif Input.is_action_pressed("ui_down"):
		sprite.play("walk_down")
	elif Input.is_action_pressed("ui_up"):
		sprite.play("walk_upper")
	else:
		sprite.stop()

	move_direction = Vector2(
					int(Input.is_action_pressed("ui_right")) - \
					int(Input.is_action_pressed("ui_left")),
					int(Input.is_action_pressed("ui_down")) - \
					int(Input.is_action_pressed("ui_up"))
						)
	
	var collision = move_and_collide(move_direction * delta * speed)
	
	if Input.is_action_pressed("ui_accept"):
		if get_node("Area2D2").get_overlapping_areas() != [] && flag:
			flag = 0
	
			emit_signal("start_dialogue")
			yield(get_tree().create_timer(2.0),"timeout")
			flag = 1
	
func _ready():
	pass

func _on_house_enter_area_shape_entered(area_id, area, area_shape, local_shape):
	get_node("/root/game/sceneChanger/anim").play("fade")
	yield(get_node("/root/game/sceneChanger/anim"), "animation_finished")
	assert(get_tree().change_scene("res://Scenes/house_interior.tscn") == OK)
	get_node("/root/game/sceneChanger/anim").play_backwards("fade")



func _on_interact_area_body_exited(body):
	if get_parent().has_node("dialog_ballon"):
		emit_signal("end_dialogue")
