extends Node

var speed := 100.0
var velocity := Vector2.ZERO

func _process(_delta: float) -> void:
	velocity = Vector2.ZERO

	velocity.x = Input.get_axis("move_left", "move_right")
	velocity.y = Input.get_axis("move_up", "move_down")

	if velocity != Vector2.ZERO:
		velocity = velocity.normalized()
	
	velocity *= speed

	
