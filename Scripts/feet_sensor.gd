extends Area2D

signal to_level1()
signal to_level2()
signal to_level3()
signal to_level4()
signal to_level5()
signal to_level6()
signal to_level7()
signal to_level8()

signal House1()
signal House2()
signal House3()
signal House4()
signal House5()
signal House6()
signal House7()

signal grass()
signal grass2()
signal grass3()

signal dialog_joice()
signal dialog_joice_exited()

signal dialog_jaiminho()
signal dialog_jaiminho_exited()

signal dialog_rita()
signal dialog_rita_exited()

signal dialog_anciao()
signal dialog_anciao_exited()

signal dialog_anciao2()
signal dialog_anciao2_exited()

signal dialog_mamon()
signal dialog_mamon_exited()

signal Item()
signal Item_exited()

signal dialog_jacinto()
signal dialog_jacinto_exited()

signal dialog_inimigo1()
signal dialog_inimigo1_exited()

signal dialog_inimigo2()
signal dialog_inimigo2_exited()

signal dialog_chefe()
signal dialog_chefe_exited()

func _ready():
	pass


func _on_feet_sensor_area_shape_entered(area_id, area, area_shape, local_shape):
	print(area.name)
	emit_signal(area.name)


func _on_feet_sensor_body_entered(body):
	emit_signal(body.name)


func _on_feet_sensor_area_exited(area):
	emit_signal(area.name + "_exited")
