class_name Player extends CharacterBody2D

""" Player Speed Variables """
const DASH_SPEED := 150
const WALK_SPEED := 60
var speed := WALK_SPEED

""" Player Hurtbox Reference"""
@onready var HURT_BOX := $HurtBox

""" Player Health Variable"""
var health := 3
signal tookDamage (currHealth : int)

""" Invincibility Variables"""
var invincible := false
var invincibleCounter := 0

""" Vector for Player Input """
var inputVector : Vector2 

""" Death Signal """
signal died

""" Dash Variables """
@onready var D_TIMER := $DashTimer
@onready var C_TIMER := $DashCooldown
var dashReady := true

""" Dash Signals """
signal dashUsed
signal dashAvailable

""" Audio """
@onready var AUDIO_PLAYER_HURT := $AudioHurt
@onready var AUDIO_PLAYER_DASH_READY := $AudioDashReady

"""
Purpose: 
	Called every frame at a fixed rate of 60 fps

Parameters: 
	delta - Length of time since last frame
"""
func _physics_process(delta):
	move(delta)
	update_invincible()

"""
Purpose:
	Handles input that does not need to be checked every frame
"""
func _input(event):
	if event.is_action_pressed("space") and dashReady:
		dash()

"""
Purpose:
	Check if enemies hitboxes are overlapping with the hurtbox. This is called
	once invincibily is over to see if the player should take damage right away.
"""
func check_for_enemy_touch():
	if HURT_BOX.has_overlapping_areas():
		take_damage()
		become_invincible()

"""
Purpose:
	Decrements invincibily counter by one every frame if active. Once over calls
	check_for_enemy_touch to check if currently being hit by enemy when invincibiliy
	ends.
"""
func update_invincible():
	if invincible:
		invincibleCounter -= 1
		if invincibleCounter == 0:
			invincible = false
			$Sprite2D.self_modulate.a = 1
			check_for_enemy_touch()

"""
Purpose: 
	Update the input vector based on WASD / Arrow keys
"""
func update_input_vector():
	inputVector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

"""
Purpose: 
	Move the player based on user input
"""
func move(delta):
	update_input_vector()
	velocity = inputVector * speed
	move_and_collide(velocity * delta)

"""
Purpose: 
	Decrements players health by 1. If health is then 0 initiate game over otherwise
	activate invincibility.
"""
func take_damage():
	health -= 1
	tookDamage.emit(health)
	AUDIO_PLAYER_HURT.play()
	if health == 0:
		emit_signal("died")

"""
Purpose:
	Make necessary changes to start invincible phase
"""
func become_invincible():
	invincible = true
	invincibleCounter = 200
	$Sprite2D.self_modulate.a = 0.4 # To show invinciblility

"""
Purpose:
	Response to signal recieved from hurt box when another area enters the hurt box.
	Checks for if the area is a hit box and if the player is not invincible. If not
	then the player takes damage.
"""
func hurt_box_entered(area):
	if area.name == "HitBox" and !invincible:
		take_damage()
		become_invincible()

func dash():
	emit_signal("dashUsed")
	speed = DASH_SPEED
	D_TIMER.start()
	dashReady = false
	set_collision_mask_value(3, false)
	set_collision_mask_value(5, false)
	set_collision_mask_value(6, false)
	HURT_BOX.set_collision_mask_value(7, false)

func _on_dash_timer_timeout():
	D_TIMER.stop()
	speed = WALK_SPEED
	C_TIMER.start()
	set_collision_mask_value(3, true)
	set_collision_mask_value(5, true)
	set_collision_mask_value(6, true)
	HURT_BOX.set_collision_mask_value(7, true)

func _on_dash_cooldown_timeout():
	emit_signal("dashAvailable")
	AUDIO_PLAYER_DASH_READY.play()
	C_TIMER.stop()
	dashReady = true
