extends Node2D

# Mamon names
enum Name {
	AuAon, Pigozzon, Jaimon, Pedron, Skonkon, Emon, 
	Smon, Cebolon, Antarticon, Pitachon, Brennon
}

# Sprite region
var sprite_rect =   {
	Name.AuAon: Rect2(0, 0, 48, 48),
	Name.Pigozzon: Rect2(48, 0, 80, 48),
	Name.Jaimon: Rect2(128, 0, 64, 64),
	Name.Pedron: Rect2(192, 0, 48, 48),
	Name.Skonkon: Rect2(240, 0, 64, 48),
	Name.Emon: Rect2(304, 0, 64, 80),
	Name.Smon: Rect2(368, 0, 48, 80),
	Name.Cebolon: Rect2(0, 64, 64, 80),
	Name.Antarticon: Rect2(64, 64, 96, 64),
	Name.Pitachon: Rect2(160, 64, 96, 80),
	Name.Brennon: Rect2(256, 80, 64, 48)
}


var total_hp = 200 setget, get_total_hp
var current_hp = 0 setget set_current_hp, get_current_hp
var nome

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func get_total_hp():
	return total_hp


func get_current_hp():
	return current_hp


func set_current_hp(value):
	current_hp = clamp(current_hp + value, 0, total_hp)
