class_name Personaje
extends CharacterBody2D

signal touch_obj()
const SPEED = 100.0
var inventario: Array[int] = []

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("izquierda", "derecha")
	var upDown : = Input.get_axis("arriba", "abajo")
	
	if upDown:
		velocity.y = upDown * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func recolectar():
	print("Recogido")
