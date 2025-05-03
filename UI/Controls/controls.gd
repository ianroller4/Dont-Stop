extends Control

"""
Purpose:
	Change scene based on selected menu item
Parameters:
	The control item that was focused on when an option was selected.
"""
func _on_item_chosen(item):
	match(item.name):
		"Play":
			# Change scene to game scene
			get_tree().change_scene_to_file("res://Game/Game.tscn")
		"HighScore":
			# Change scene to high score scene
			get_tree().change_scene_to_file("res://UI/HighScore/HighScore.tscn")
		"MainMenu":
			# Change scene to main menu scene
			get_tree().change_scene_to_file("res://UI/Main/MainMenu.tscn")
		"Quit":
			# Exit the program
			get_tree().quit()
