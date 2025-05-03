extends Control

"""
Purpose:
	Called when entering scene
"""
func _ready():
	$Score.text = str(GameGlobal.currentScore)
	update_high_score()
	SaveLoad.save()
	$VerticalMenu.hide()
	$Pointer.hide()

"""
Purpose:
	Show menu items and enable menu interactions after a one second period
"""
func _on_timer_timeout():
	$Timer.stop()
	$VerticalMenu.show()
	$Pointer.show()
	$VerticalMenu.configure_focus()

"""
Purpose:
	Upon game over check if score is in top 5 and if so adjust score accordingly by 
	shifting lower scores down.
"""
func update_high_score():
	if GameGlobal.currentScore > GameGlobal.first: # Score is new top score
		GameGlobal.fifth = GameGlobal.fourth
		GameGlobal.fourth = GameGlobal.third
		GameGlobal.third = GameGlobal.second
		GameGlobal.second = GameGlobal.first
		GameGlobal.first = GameGlobal.currentScore
		
	elif GameGlobal.currentScore > GameGlobal.second: # Score is new second
		GameGlobal.fifth = GameGlobal.fourth
		GameGlobal.fourth = GameGlobal.third
		GameGlobal.third = GameGlobal.second
		GameGlobal.second = GameGlobal.currentScore
		
	elif GameGlobal.currentScore > GameGlobal.third: # Score is new third
		GameGlobal.fifth = GameGlobal.fourth
		GameGlobal.fourth = GameGlobal.third
		GameGlobal.third = GameGlobal.currentScore
		
	elif GameGlobal.currentScore > GameGlobal.fourth: # Score is new fourth
		GameGlobal.fifth = GameGlobal.fourth
		GameGlobal.fourth = GameGlobal.currentScore
		
	elif GameGlobal.currentScore > GameGlobal.fifth: # Score is new fifth
		GameGlobal.fifth = GameGlobal.currentScore

"""
Purpose:
	Change scene based on selected menu item
Parameters:
	The control item that was focused on when an option was selected.
"""
func _on_item_chosen(item):
	match(item.name):
		"Play":
			get_tree().change_scene_to_file("res://Game/Game.tscn")
		"HighScore":
			get_tree().change_scene_to_file("res://UI/HighScore/HighScore.tscn")
		"MainMenu":
			get_tree().change_scene_to_file("res://UI/Main/MainMenu.tscn")
		"Quit":
			get_tree().quit()
