extends Node2D

func _process(delta: float):
	if Input.is_action_just_pressed("ui_accept"):
		Globals.current_game_state = "STATE_GAME"
		Globals.change_state = true
