extends Control




func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/nivel_art_original.tscn")


func _on_salir_pressed() -> void:
	pass # Replace with function body.
	get_tree().quit()


func _on_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/control.tscn")


func _on_ajustes_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/ajustes.tscn")
