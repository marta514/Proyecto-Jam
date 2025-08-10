class_name Personaje
extends CharacterBody2D

signal touch_obj()
const SPEED = 100.0
var inventario: Array[int] = []

@onready var animacion = $Sprite2D 

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("izquierda", "derecha")
	var direction_y = Input.get_axis("arriba", "abajo")
	
	var direction = Vector2(direction_x, direction_y).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED

		# Controla las animaciones
		if direction.x > 0:
			animacion.play("derecha")
		elif direction.x < 0:
			animacion.play("izquierda")
		elif direction.y > 0:
			animacion.play("abajo")
		elif direction.y < 0:
			animacion.play("arriba")
	else:
		# Si el personaje no se mueve, reproduce la animación "idle"
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		animacion.play("idle")
		
	move_and_slide()


func recolectar():
	print("Recogido")
