extends CharacterBody2D

var Bullet := preload("res://assets/scenes/bullet.tscn")
var shot_cooling_down := false



func _on_shooting_cooldown_timer_timeout() -> void:
	shot_cooling_down = false

func _ready() -> void:
	$WasdController.speed = 200.0

func launch_bullet(delta, radians):
	var bullet := Bullet.instantiate()
	bullet.radians = radians
	bullet.on_rotate()
	bullet.speed = 1000.0
	bullet.position = position

	for i in range(2):
		bullet.move(delta)


	%Bullets.add_child(bullet)	

func on_fire(delta):
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or shot_cooling_down:
		return

	var rad_to_mouse = get_local_mouse_position().angle();
	var delta_rad = (PI * 2) / Globals.bullet_directions
	for i in range(Globals.bullet_directions):
		launch_bullet(delta, rad_to_mouse + (i * delta_rad))

	shot_cooling_down = true
	$ShootingCooldownTimer.start()

func is_past_boundary(delta: float) -> bool:
	var nx = global_position.x + (velocity.x * delta)
	var ny = global_position.y + (velocity.y * delta)

	if nx < -300 or nx > 300:
		return true
	if ny < -200 or ny > 200:
		return true

	return false

func move(delta):
	velocity = $WasdController.velocity
	if not is_past_boundary(delta):
		move_and_slide()	

func _process(delta: float) -> void:
	if Globals.paused:		
		return
	on_fire(delta)
	move(delta)


func _on_area_2d_area_entered(_area: Area2D) -> void:
	Globals.current_game_state = "STATE_GAMEOVER"
	Globals.change_state = true
