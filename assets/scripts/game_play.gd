extends Node2D

var Cactus := preload("res://assets/scenes/cactus.tscn")
var CactusMut1 := preload("res://assets/scenes/cactus_mut_1.tscn")
var CactusMut2 := preload("res://assets/scenes/cactus_mut_2.tscn")


func _ready():
	$rate.disabled = true 
	$rate.visible = false
	
	$dmg.disabled = true
	$dmg.visible = false
	
	$dir.disabled = true
	$dir.visible = false
	
	_on_cactii_spawn_timer_timeout()
	Globals.score = 0
	Globals.wave = 1
	Globals.bullet_damage = 1
	Globals.bullet_directions = 1
	Globals.bullet_rate = 1
	$Score.text = str(Globals.score) + "/" + str(Globals.END_GOAL)
	for cactus in %Cactii.get_children():
		cactus.queue_free()

func _process(delta):
	pass


func spawn_cactus():
	var ctype = Cactus
	
	if Globals.wave >= 3:
		if randf() < 0.2:
			ctype = CactusMut1
	if Globals.wave >= 5:
		var res := randf()
		if res < 0.25:
			ctype = CactusMut2
		elif res < 0.2:
			ctype = CactusMut1
			
	var cactus = ctype.instantiate()
	
	cactus.spawn()
	%Cactii.add_child(cactus)
	

func _on_cactii_spawn_timer_timeout() -> void:
	if Globals.paused:
		return
	
	spawn_cactus()
	$CactiiSpawnTimer.start()


func on_btn_press():
	$rate.disabled = true 
	$rate.visible = false
	
	$dmg.disabled = true
	$dmg.visible = false
	
	$dir.disabled = true
	$dir.visible = false
	Globals.paused = false
	$bgoverlay.visible = false

func _on_rate_pressed() -> void:
	on_btn_press()
	Globals.bullet_rate += 1
	$Player/ShootingCooldownTimer.wait_time *= 0.7

func _on_dmg_pressed() -> void:
	on_btn_press()
	Globals.bullet_damage += 1

func _on_dir_pressed() -> void:
	on_btn_press()
	Globals.bullet_directions += 1
