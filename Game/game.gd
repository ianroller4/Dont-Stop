extends Node2D

@onready var BLOCKER := preload("res://Enemies/Blocker/Blocker.tscn")
@onready var TRACKER := preload("res://Enemies/Tracker/Tracker.tscn")
@onready var SLIDER := preload("res://Enemies/Slider/Slider.tscn")

var enemyCount := 0
var blockerCount := 0
const BLOCKER_MAX := 12

@onready var PAUSE := $Pause

const SPAWN_POSITIONS = [Vector2(120.0, 120.0), Vector2(-120.0, -120.0),
					  Vector2(120.0, -120.0), Vector2(-120.0, 120.0)]

var gameOver := false

func _ready():
	$Player/HUD.show()
	gameOver = false
	GameGlobal.currentScore = 0
	PAUSE.hide()
	var pos = SPAWN_POSITIONS[randi_range(0, SPAWN_POSITIONS.size()-1)]
	var t := TRACKER.instantiate()
	t.position = pos
	add_child(t)
	enemyCount += 1

func _physics_process(_delta):
	if gameOver:
		end_game()

"""
Purpose:
	Handles input that does not need to be checked every frame
"""
func _input(event):
	if event.is_action_pressed("pause"):
		pause()
	if event.is_action_pressed("q"):
		add_enemy()

func pause():
	PAUSE.show()
	$Pause/VerticalMenu.configure_focus()
	get_tree().paused = true

func add_enemy():
	var pos = SPAWN_POSITIONS[randi_range(0, SPAWN_POSITIONS.size()-1)]
	
	if blockerCount < BLOCKER_MAX:
		var enemy = randi_range(0, 2)
		match (enemy):
			0:
				var t := TRACKER.instantiate()
				t.position = pos
				add_child(t)
			1:
				var s := SLIDER.instantiate()
				s.position = pos
				add_child(s)
			2:
				var b := BLOCKER.instantiate()
				b.position = pos
				add_child(b)
				blockerCount += 1
			
	else:
		var enemy = randi_range(0, 1)
		match (enemy):
			0:
				var t := TRACKER.instantiate()
				t.position = pos
				add_child(t)
			1:
				var s := SLIDER.instantiate()
				s.position = pos
				add_child(s)
	
	enemyCount += 1

func end_game():
	get_tree().change_scene_to_file("res://UI/GameOver/GameOver.tscn")

func _on_player_died():
	gameOver = true

func _on_score_timer_timeout():
	GameGlobal.currentScore += enemyCount


func _on_spawn_timer_timeout():
	add_enemy()
