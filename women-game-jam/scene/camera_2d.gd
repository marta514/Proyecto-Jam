extends Camera2D

@export var object_to_follow:Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if object_to_follow != null:
		position = object_to_follow.position
	pass
	
func _physics_process(delta: float) -> void:
	pass
