extends CanvasLayer

@onready var H_ONE := $HeartOne
@onready var H_TWO := $HeartTwo
@onready var H_THREE := $HeartThree
@onready var DASH := $DashReady
@onready var SCORE := $Score

@export var PLAYER : Player

func _on_score_timer_timeout():
	SCORE.text = str(GameGlobal.currentScore)

func _on_player_dash_available():
	DASH.show()

func _on_player_dash_used():
	DASH.hide()


func _on_player_took_damage(currHealth):
	match (currHealth):
		2:
			H_THREE.hide()
		1:
			H_TWO.hide()
