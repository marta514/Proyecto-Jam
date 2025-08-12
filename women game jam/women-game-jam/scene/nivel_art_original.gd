extends Node2D

@onready var objetos_recolectables = get_children().filter(func(child): return child is Area2D and child.is_in_group("ObjetosRecolectables"))
@onready var objetos_ocultos = [get_node("ObjetoOculto1"), get_node("ObjetoOculto2")]

@onready var dialogo_panel = $CanvasLayer/Control
@onready var dialogo_label = $CanvasLayer/Control/HSplitContainer/Label
@onready var boton_dialogo = $CanvasLayer/Control/HSplitContainer/BotonCerrar

var objetos_recolectados = 0

func _ready():
	# Asegúrate de que los objetos ocultos no sean visibles al principio
	for objeto in objetos_ocultos:
		objeto.visible = false

	# Conecta la señal de cada objeto recolectable a la misma función: _on_objeto_recolectado
	for objeto in objetos_recolectables:
		if objeto.has_signal("recolectado"):
			# Asegúrate de que la señal envía el texto del diálogo
			objeto.connect("recolectado", _on_objeto_recolectado)


# Esta función ahora maneja TODO: contar objetos, mostrar diálogos y mostrar los objetos ocultos.
func _on_objeto_recolectado(texto_recibido) -> void:
	# 1. Actualiza el contador de objetos recolectados
	objetos_recolectados += 1
	print("Objetos recolectados: ", objetos_recolectados)

	# 2. Muestra el diálogo con el texto que recibiste
	dialogo_panel.show()
	dialogo_label.text = texto_recibido
	
	# 3. Conecta el botón para cerrar el diálogo
	if boton_dialogo.is_connected("pressed", _cerrar_dialogo):
		boton_dialogo.disconnect("pressed", _cerrar_dialogo)
	boton_dialogo.connect("pressed", _cerrar_dialogo)
	
	# 4. Verifica si se deben mostrar los objetos ocultos
	if objetos_recolectados >= 2:
		mostrar_objetos_ocultos()

func mostrar_objetos_ocultos():
	print("¡Todos los objetos recolectables han sido recogidos! Mostrando objetos ocultos.")
	for objeto in objetos_ocultos:
		objeto.visible = true

func _cerrar_dialogo():
	# Oculta el panel de diálogo
	dialogo_panel.hide()
	
	print("El diálogo se ha cerrado.")
