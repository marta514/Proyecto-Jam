extends Node2D

@onready var objetos_recolectables = get_children().filter(func(child): return child is Area2D and child.is_in_group("ObjetosRecolectables"))
@onready var objetos_ocultos = [get_node("ObjetoOculto1"), get_node("ObjetoOculto2"), get_node("ObjetoOculto3")]

var objetos_recolectados = 0

func _ready():
	# Asegúrate de que los objetos ocultos no sean visibles al principio
	for objeto in objetos_ocultos:
		objeto.visible = false

	# Conecta la señal de cada objeto recolectable al script de la escena
	for objeto in objetos_recolectables:
		if objeto.has_signal("recolectado"):
			objeto.connect("recolectado", _on_objeto_recolectado)

func _on_objeto_recolectado():
	objetos_recolectados += 1
	print("Objetos recolectados: ", objetos_recolectados)
	if objetos_recolectados >= 3:
		mostrar_objetos_ocultos()

func mostrar_objetos_ocultos():
	print("¡Todos los objetos recolectables han sido recogidos! Mostrando objetos ocultos.")
	for objeto in objetos_ocultos:
		objeto.visible = true
