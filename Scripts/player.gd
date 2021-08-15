extends KinematicBody2D

signal start_dialog()
onready var player_vars = get_node("/root/PlayerVariables")
export var speed = 96

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
					Input.get_action_strength("ui_right") - \
					Input.get_action_strength("ui_left"),
					Input.get_action_strength("ui_down") - \
					Input.get_action_strength("ui_up")
						)
	
	move_and_collide(move_direction * delta * speed)
	
	
	if Input.is_action_pressed("ui_accept"):
		pass
	
func _ready():
	pass
