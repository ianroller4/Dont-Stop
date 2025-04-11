extends Node

""" Positions Where Blockers will Sit """
var BLOCKER_SPOTS = [Vector2(-24.0, 120.0), Vector2(24.0, 120.0), Vector2(-120.0, 24.0), 
					Vector2(-120.0, -24.0), Vector2(120.0, 24.0), Vector2(120.0, -24.0), 
					Vector2(-24.0, -120.0), Vector2(24.0, -120.0), Vector2(-8.0, 40.0), 
					Vector2(40.0, 8.0), Vector2(-40.0, -8.0), Vector2(8.0, -40.0)]

""" High Score Variables """
var currentScore := 0

var first := 0
var second := 0
var third := 0
var fourth := 0
var fifth := 0
