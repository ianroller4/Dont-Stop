extends Control

"""
Purpose:
	Called when entering scene
"""
func _ready():
	if not FileAccess.file_exists(SaveLoad.SAVE_PATH): # Check if save exists
		SaveLoad.create_save() # Create new save
	else:
		SaveLoad.load_save() # Load save if one exists

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
			# Change scene to high score menu
			get_tree().change_scene_to_file("res://UI/HighScore/HighScore.tscn")
		"Controls":
			# Change scene to controls scene
			get_tree().change_scene_to_file("res://UI/Controls/Controls.tscn")
		"Quit":
			# Quit the program
			get_tree().quit()
