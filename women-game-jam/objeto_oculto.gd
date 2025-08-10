class_name ObjetoRO
extends Area2D

# Define una señal que será emitida cuando el objeto sea recolectado
signal recolectado

var can_interact = false
var body_in_area = null

# Llamada cuando un cuerpo entra en el Area2D
func _on_body_entered(body):
	if body.is_in_group("Personaje"):
		can_interact = true
		body_in_area = body
		print("Puedes interactuar con el objeto.")

# Llamada cuando un cuerpo sale del Area2D
func _on_body_exited(body):
	if body_in_area == body:
		can_interact = false
		body_in_area = null
		print("Ya no puedes interactuar con el objeto.")

# Llama a _input() para manejar la entrada
func _input(event):
	if can_interact and event.is_action_pressed("recolectar"):
		if body_in_area != null:
			# Emite la señal antes de eliminar el objeto
			#emit_signal("recolectado")
			# Elimina el objeto solo si el jugador presiona el botón de interacción
			queue_free()
			print("Objeto recolectado!")
