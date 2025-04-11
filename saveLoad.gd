extends Node

const SAVE_PATH := "user://DontStopSave.json"

var saveData := {"first" : 0, "second" : 0, "third" : 0, "fourth" : 0, "fifth" : 0}

func create_save():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(saveData)
	file.close()

func save():
	saveData["first"] = GameGlobal.first
	saveData["second"] = GameGlobal.second
	saveData["third"] = GameGlobal.third
	saveData["fourth"] = GameGlobal.fourth
	saveData["fifth"] = GameGlobal.fifth
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(saveData)
	file.close()

func load_save():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = file.get_var()
	file.close()
	
	GameGlobal.first = data["first"]
	GameGlobal.second = data["second"]
	GameGlobal.third = data["third"]
	GameGlobal.fourth = data["fourth"]
	GameGlobal.fifth = data["fifth"]
