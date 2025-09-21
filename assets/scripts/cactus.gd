extends Area2D

var target: Vector2
var speed := 50.0
@onready var player = get_node("/root/Main/GamePlay/Player")
@onready var anim: AnimationPlayer = get_node("/root/Main/GamePlay/AnimationPlayer")
@onready var score_label: Label = get_node("/root/Main/GamePlay/Score")

@onready var bg_overlay: Sprite2D = get_node("/root/Main/GamePlay/bgoverlay")
@onready var rate_btn: Button = get_node("/root/Main/GamePlay/rate")
@onready var dmg_btn: Button = get_node("/root/Main/GamePlay/dmg")
@onready var dir_btn: Button = get_node("/root/Main/GamePlay/dir")

@onready var spawn_timer: Timer = get_node("/root/Main/GamePlay/CactiiSpawnTimer")

var health := 2

func spawn():
	var x = randi_range(-300, 300)
	var y = randi_range(-200, 200)
	
	var ch = randi_range(1, 4)

	if ch == 1:  # left wall
		global_position = Vector2(-332, y)
	elif ch == 2:  # right wall
		global_position = Vector2(332, y)
	elif ch == 3:  # up wall
		global_position = Vector2(x, -232)
	elif ch == 4:
		global_position = Vector2(x, 232)

func upgrade():
	Globals.paused =  true
	bg_overlay.visible = true
	rate_btn.visible = true
	rate_btn.disabled = false
	
	dir_btn.visible = true
	dir_btn.disabled = false
	
	dmg_btn.visible = true
	dmg_btn.disabled = false
	
	
func on_death():
	if health <= 0:
		queue_free()
		anim.play("wobble")
		Globals.score += 1
		score_label.text = str(Globals.score) + "/" + str(Globals.END_GOAL)

		
		if Globals.score == Globals.END_GOAL:
			Globals.current_game_state = "STATE_WIN"
			Globals.change_state = true
			return
			
		if Globals.score in [5, 15, 30, 50, 100, 200]:
		#if Globals.score in [1, 2, 3, 4, 5, 6, 7, 8]:
			Globals.wave += 1
			spawn_timer.wait_time *= 0.6
			
			upgrade()
			

func _process(delta: float):
	if Globals.paused:
		return
	global_position = global_position.move_toward(player.global_position, speed * delta)
	on_death()

func _on_area_entered(area: Area2D) -> void:
	if area.z_index != 1:
		return
	health -= 1 * Globals.bullet_damage
	area.queue_free()
