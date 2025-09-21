extends Area2D

var radians := 0.0
var speed := 100
var max_distance := 1000

var distance_travelled := 0.0
var velocity := Vector2.ZERO

func on_out_of_range():
	if distance_travelled > max_distance:
		queue_free()

func on_rotate():
	rotation = radians

func move(delta: float):
	velocity = Vector2.ZERO
	velocity.x = cos(radians) * speed
	velocity.y = sin(radians) * speed

	distance_travelled += velocity.length() * delta

	global_position += velocity * delta


func _process(delta: float) -> void:
	on_out_of_range()
	move(delta)
	on_rotate()
