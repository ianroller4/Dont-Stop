extends Node

""" Save Variables """
const SAVE_PATH := "user://DontStopSave.json" # Save file path

#Data to save
var saveData := {"first" : 0, "second" : 0, "third" : 0, "fourth" : 0, "fifth" : 0}

"""
Purpose:
	Create a file at the save path and store the save data by writing it to the file
"""
func create_save():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(saveData)
	file.close()

"""
Purpose:
	Save the score data to the save data variable and write save data to the file
	at the save path
"""
func save():
	saveData["first"] = GameGlobal.first
	saveData["second"] = GameGlobal.second
	saveData["third"] = GameGlobal.third
	saveData["fourth"] = GameGlobal.fourth
	saveData["fifth"] = GameGlobal.fifth
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(saveData)
	file.close()

"""
Purpose:
	Open file at save path and read save data into correct variables
"""
func load_save():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = file.get_var()
	file.close()
	
	GameGlobal.first = data["first"]
	GameGlobal.second = data["second"]
	GameGlobal.third = data["third"]
	GameGlobal.fourth = data["fourth"]
	GameGlobal.fifth = data["fifth"]
