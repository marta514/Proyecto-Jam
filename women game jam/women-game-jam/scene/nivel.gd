extends Node2D

@onready var objetos_recolectables = get_children().filter(func(child): return child is Area2D and child.is_in_group("ObjetosRecolectables"))
@onready var objetos_ocultos = [get_node("ObjetoOculto1"), get_node("ObjetoOculto2")]

@onready var dialogo_panel = $CanvasLayer/Control
@onready var dialogo_label = $CanvasLayer/Control/HSplitContainer/Label
@onready var boton_dialogo = $CanvasLayer/Control/HSplitContainer/BotonCerrar

var objetos_recolectados = 0
var es_dialogo_final = false

func _ready():
	# Asegúrate de que los objetos ocultos no sean visibles al principio
	for objeto in objetos_ocultos:
		if is_instance_valid(objeto):
			objeto.visible = false

	# Conecta la señal de cada objeto recolectable
	for objeto in objetos_recolectables:
		if objeto.has_signal("recolectado"):
			objeto.connect("recolectado", _on_objeto_recolectado)
	
	# Asegúrate de conectar también los objetos ocultos
	# (aunque la conexión se hace efectiva solo cuando se hacen visibles)
	for objeto in objetos_ocultos:
		if is_instance_valid(objeto) and objeto.has_signal("recolectado"):
			objeto.connect("recolectado", _on_objeto_recolectado_oculto)

func _on_objeto_recolectado(texto_recibido) -> void:
	objetos_recolectados += 1
	print("Objetos recolectados: ", objetos_recolectados)

	dialogo_panel.show()
	dialogo_label.text = texto_recibido
	
	_conectar_boton_dialogo()
	
	if objetos_recolectados >= 2:
		mostrar_objetos_ocultos()

func mostrar_objetos_ocultos():
	print("¡Todos los objetos recolectables han sido recogidos! Mostrando objetos ocultos.")
	for objeto in objetos_ocultos:
		if is_instance_valid(objeto):
			objeto.visible = true

func _on_objeto_recolectado_oculto(texto_recibido) -> void:
	# Esta función se llama solo cuando se recoge un objeto oculto.
	print("Objeto oculto recolectado. Mostrando diálogo final.")
	
	dialogo_panel.show()
	dialogo_label.text = texto_recibido
	
	es_dialogo_final = true
	_conectar_boton_dialogo()

func _conectar_boton_dialogo():
	# Desconecta para evitar múltiples conexiones
	if boton_dialogo.is_connected("pressed", _cerrar_dialogo):
		boton_dialogo.disconnect("pressed", _cerrar_dialogo)
	
	# Conecta la señal del botón a la función que cierra el diálogo
	boton_dialogo.connect("pressed", _cerrar_dialogo)

func _cerrar_dialogo():
	dialogo_panel.hide()
	print("El diálogo se ha cerrado.")
	
	if es_dialogo_final:
		print("Cambiando a la escena del menú...")
		# Aquí cargas la escena de tu menú. Reemplaza "res://menu.tscn" con la ruta correcta.
		get_tree().change_scene_to_file("res://scene/menú.tscn")
