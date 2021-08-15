extends Node

var transitions_anim_names: Dictionary = {
		0: "Circle",
		1: "Diagonal1",
		2: "Diagonal2",
		3: "Diagonal3",
		4: "Diagonal4",
		5: "Down-Top",
		6: "Fade",
		7: "LEFTandRIGHT",
		8: "Left-right",
		9: "Pixelation",
		10: "Right-Left",
		11: "Top-down"
}

enum transition_type {
	Circle = 0,
	Diagonal1,
	Diagonal2,
	Diagonal3,
	Diagonal4,
	DownTop,
	Fade,
	LEFTandRIGHT,
	LeftRight,
	Pixelation,
	RightLeft,
	TopDown
}

export (transition_type) var select_transition

export var scenes_node: NodePath

var new_scene_dir: String
var last_scene_dir: String
var load_state: int = 0


func load_state() -> void:
	match load_state:
		0:
			get_tree().paused = true
			if transitions_anim_names[select_transition] != "Pixelation":
				$trans_anim.play(transitions_anim_names[select_transition])
			else:
				$trans_anim.play(transitions_anim_names[ transition_type.Fade ])

			load_state = 1
			$timer.wait_time = $trans_anim.current_animation_length
			$timer.start()
		1:
			assert(get_tree().change_scene(new_scene_dir) == OK)
			$timer.wait_time = 0.05
			$timer.start()
			load_state = 2
		2:
			if transitions_anim_names[select_transition] != "Pixelation":
				$trans_anim.play_backwards(transitions_anim_names[select_transition])
			else:
				$trans_anim.play(transitions_anim_names[select_transition])

			$timer.wait_time = $trans_anim.current_animation_length
			$timer.start()
			load_state = 3
		3:
			load_state = 0
			print("chegou")
			get_tree().paused = false


func last_scene(lvl):
	new_scene_dir = ""


func next_scene(scene):
	new_scene_dir = scene


func _on_timer_timeout():
	load_state()
