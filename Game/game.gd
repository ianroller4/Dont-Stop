extends Node2D

""" Enemy Scenes for Easy Creating of Enemies """
@onready var BLOCKER := preload("res://Enemies/Blocker/Blocker.tscn")
@onready var TRACKER := preload("res://Enemies/Tracker/Tracker.tscn")
@onready var SLIDER := preload("res://Enemies/Slider/Slider.tscn")

""" Enemy Variables """
var enemyCount := 0
var blockerCount := 0
const BLOCKER_MAX := 12

const SPAWN_POSITIONS = [Vector2(120.0, 120.0), Vector2(-120.0, -120.0),
					  Vector2(120.0, -120.0), Vector2(-120.0, 120.0)]

""" Pause Menu """
@onready var PAUSE := $Pause

""" Game Control Variable """
var gameOver := false

"""
Purpose:
	Called when entering scene
"""
func _ready():
	GameGlobal.currentScore = 0
	var pos = SPAWN_POSITIONS[randi_range(0, SPAWN_POSITIONS.size()-1)]
	var t := TRACKER.instantiate()
	t.position = pos
	add_child(t)
	enemyCount += 1

"""
Purpose: 
	Called every frame at a fixed rate of 60 fps

Parameters: 
	delta - Length of time since last frame
"""
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

"""
Purpose:
	Show pause menu and pause gameplay
"""
func pause():
	PAUSE.show()
	$Pause/VerticalMenu.configure_focus()
	get_tree().paused = true

"""
Purpose:
	Add an enemy to arena
"""
func add_enemy():
	# Get spawn position
	var pos = SPAWN_POSITIONS[randi_range(0, SPAWN_POSITIONS.size()-1)]
	
	# Check if Blockers have reached their limit
	if blockerCount < BLOCKER_MAX:
		# Get a random number (0, 1, or 2)
		var enemy = randi_range(0, 2)
		# Match the number and spawn the corresponding enemy
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
		# Get a random number (0, or 1)
		var enemy = randi_range(0, 1)
		# Match the number and spawn the corresponding enemy
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

"""
Purpose:
	Chance scene to game over menu when game ends
"""
func end_game():
	get_tree().change_scene_to_file("res://UI/GameOver/GameOver.tscn")

"""
Purpose:
	When player loses health and dies receive signal and set gameOver to true
"""
func _on_player_died():
	gameOver = true

"""
Purpose:
	Update score on score timer timeout, every 2 seconds
"""
func _on_score_timer_timeout():
	GameGlobal.currentScore += enemyCount

"""
Purpose:
	Spawn enemy on spawn timer timeout, every 5 seconds
"""
func _on_spawn_timer_timeout():
	add_enemy()
