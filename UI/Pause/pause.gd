extends CanvasLayer

func _on_item_chosen(item):
	match(item.name):
		"Resume":
			hide()
			get_tree().paused = false
		"Quit":
			get_tree().paused = false
			get_tree().change_scene_to_file("res://UI/Main/MainMenu.tscn")
