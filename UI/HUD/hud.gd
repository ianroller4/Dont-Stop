extends CanvasLayer

""" References to Icons and Score """
@onready var H_ONE := $HeartOne
@onready var H_TWO := $HeartTwo
@onready var H_THREE := $HeartThree
@onready var DASH := $DashReady
@onready var SCORE := $Score

"""
Purpose:
	Update score on hud when score increases
"""
func _on_score_timer_timeout():
	SCORE.text = str(GameGlobal.currentScore)

"""
Purpose:
	Show dash icon when dash is available again
"""
func _on_player_dash_available():
	DASH.show()

"""
Purpose:
	Hide dash icon when used
"""
func _on_player_dash_used():
	DASH.hide()

"""
Purpose:
	Update health icons to show current health
"""
func _on_player_took_damage(currHealth):
	match (currHealth):
		2:
			H_THREE.hide()
		1:
			H_TWO.hide()
