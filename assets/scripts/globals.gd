extends Node

const GameState =  {
	"STATE_MENU" = preload("res://assets/scenes/main_menu.tscn"), 
	"STATE_GAME" = preload("res://assets/scenes/game_play.tscn"), 
	"STATE_GAMEOVER" = preload("res://assets/scenes/game_over.tscn"),
	"STATE_WIN" = preload("res://assets/scenes/game_win.tscn"),
}

var current_game_state := "STATE_GAME"
var change_state := false
var score := 0
var wave := 1
var paused := false
var bullet_rate := 1
var bullet_directions := 1
var bullet_damage := 1

var END_GOAL := 300
