class_name Slide extends CharacterBody2D

""" Movement Speed """
@export var speed := 50

"""
Purpose:
	Called when entering scene
"""
func _ready():
	# Set initial direction with a random vector
	velocity = Vector2(randf(), randf()).normalized() * speed

"""
Purpose: 
	Called every frame at a fixed rate of 60 fps

Parameters: 
	delta - Length of time since last frame
"""
func _physics_process(delta):
	dvdBounce(delta)

"""
Purpose:
	Checks if slider has collided with an outer wall or player and adjusts direction
"""
func dvdBounce(delta):
	var collided = move_and_collide(velocity * delta)
	if collided:
		velocity = velocity.bounce(collided.get_normal())
