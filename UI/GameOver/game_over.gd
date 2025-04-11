extends Control

func _ready():
	$Score.text = str(GameGlobal.currentScore)
	update_high_score()
	SaveLoad.save()

func update_high_score():
	if GameGlobal.currentScore > GameGlobal.first:
		GameGlobal.fifth = GameGlobal.fourth
		GameGlobal.fourth = GameGlobal.third
		GameGlobal.third = GameGlobal.second
		GameGlobal.second = GameGlobal.first
		GameGlobal.first = GameGlobal.currentScore
	elif GameGlobal.currentScore > GameGlobal.second:
		GameGlobal.fifth = GameGlobal.fourth
		GameGlobal.fourth = GameGlobal.third
		GameGlobal.third = GameGlobal.second
		GameGlobal.second = GameGlobal.currentScore
	elif GameGlobal.currentScore > GameGlobal.third:
		GameGlobal.fifth = GameGlobal.fourth
		GameGlobal.fourth = GameGlobal.third
		GameGlobal.third = GameGlobal.currentScore
	elif GameGlobal.currentScore > GameGlobal.fourth:
		GameGlobal.fifth = GameGlobal.fourth
		GameGlobal.fourth = GameGlobal.currentScore
	elif GameGlobal.currentScore > GameGlobal.fifth:
		GameGlobal.fifth = GameGlobal.currentScore

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
