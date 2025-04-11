extends Control

@onready var FIRST := $Scores/First
@onready var SECOND := $Scores/Second
@onready var THIRD := $Scores/Third
@onready var FOURTH := $Scores/Fourth
@onready var FIFTH := $Scores/Fifth

func _ready():
	FIRST.text = str(GameGlobal.first)
	SECOND.text = str(GameGlobal.second)
	THIRD.text = str(GameGlobal.third)
	FOURTH.text = str(GameGlobal.fourth)
	FIFTH.text = str(GameGlobal.fifth)

func _on_item_chosen(item):
	match(item.name):
		"Play":
			get_tree().change_scene_to_file("res://Game/Game.tscn")
		"MainMenu":
			get_tree().change_scene_to_file("res://UI/Main/MainMenu.tscn")
		"Quit":
			get_tree().quit()
