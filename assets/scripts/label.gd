extends Label

var acc := 0.0
var old := 10
@onready var anim: AnimationPlayer = get_node("/root/Main/GamePlay/AnimationPlayer")

func _process(delta):
	acc += delta
	var res = int(acc * 10)
	
	if res != old and res % 5 == 0:
		visible = not visible
		old = res
		
	if acc > 3.0:
		visible = false
