extends CharacterBody2D

@export var move_speed = 125


func _physics_process(delta):
	var input_axis = Input.get_axis("mov-izquierda","mov-derecha")
	velocity.x = input_axis * move_speed
	move_and_slide()
