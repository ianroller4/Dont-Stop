extends Control

func _ready():
	if not FileAccess.file_exists(SaveLoad.SAVE_PATH):
		SaveLoad.create_save()
	else:
		SaveLoad.load_save()


func _on_item_chosen(item):
	match(item.name):
		"Play":
			get_tree().change_scene_to_file("res://Game/Game.tscn")
		"HighScore":
			get_tree().change_scene_to_file("res://UI/HighScore/HighScore.tscn")
		"Controls":
			get_tree().change_scene_to_file("res://UI/Controls/Controls.tscn")
		"Quit":
			get_tree().quit()
