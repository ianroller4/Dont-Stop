extends Control

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
