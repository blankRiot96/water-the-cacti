extends Label

func _ready() -> void:
	text = "You watered " + str(Globals.score) + " Cactii!!"
