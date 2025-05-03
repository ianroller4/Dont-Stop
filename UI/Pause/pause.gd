extends CanvasLayer

"""
Purpose:
	Handle menu input when paused
Parameters:
	The control item that was focused on when an option was selected.
"""
func _on_item_chosen(item):
	match(item.name):
		"Resume":
			hide() # Hide the pause screen
			get_tree().paused = false # Disable pausing
		"Quit":
			get_tree().paused = false # Disable pausing
			# Change scene to main menu
			get_tree().change_scene_to_file("res://UI/Main/MainMenu.tscn")
