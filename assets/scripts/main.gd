extends Node2D

func _ready() -> void:
	change_scene()

func change_scene():
	for c in get_children():
		c.queue_free()

	var state = Globals.GameState[Globals.current_game_state].instantiate()
	add_child(state)

func _process(_delta: float) -> void:
	if Globals.change_state:
		change_scene()
		Globals.change_state = false
