extends Control

""" High Score Text Labels """
@onready var FIRST := $Scores/First
@onready var SECOND := $Scores/Second
@onready var THIRD := $Scores/Third
@onready var FOURTH := $Scores/Fourth
@onready var FIFTH := $Scores/Fifth

"""
Purpose:
	Called when entering scene
"""
func _ready():
	FIRST.text = str(GameGlobal.first) # Set top score
	SECOND.text = str(GameGlobal.second) # Set second score
	THIRD.text = str(GameGlobal.third) # Set third score
	FOURTH.text = str(GameGlobal.fourth) # Set fourth score
	FIFTH.text = str(GameGlobal.fifth) # Set fifth score

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
		"MainMenu":
			# Change scene to main menu
			get_tree().change_scene_to_file("res://UI/Main/MainMenu.tscn")
		"Quit":
			# Quit the program
			get_tree().quit()
