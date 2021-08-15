extends NinePatchRect

export var width = 0 setget set_width, get_width
export var height = 400 setget set_height, get_height


# Called when the node enters the scene tree for the first time.
func _ready():
	set_size(Vector2(width, height))
	#set_position(Vector2(-width / 2, -height / 2))
	pass

func _draw():
	self.set_size(Vector2(width, height))
	self.set_position(Vector2(-width / 2, -height / 2))

func set_width(value):
	width = value
	_draw()

func get_width():
	return width
	
func set_height(value):
	height = value
	_draw()
	
func get_height():
	return height
