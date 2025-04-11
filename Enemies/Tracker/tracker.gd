class_name Tracker extends CharacterBody2D

""" Player Reference Variable"""
var player : Player

""" Movement Speed """
@export var speed := 50

""" Navigation Agent """
@onready var NAV := $NavAgent as NavigationAgent2D

""" Ray Field Constants """
@onready var RAYFIELD := $RayField
@onready var N := $RayField/N
@onready var E := $RayField/E
@onready var S := $RayField/S
@onready var W := $RayField/W

""" Ray Field Variables """
var rayCount : int
var rays
var collisions : int

""" Vectors for Determining Movement Direction """
var directionVector := Vector2.ZERO
var correctionVector := Vector2.ZERO
var finalVector := Vector2.ZERO

"""
Purpose:
	Called when entering scene
"""
func _ready():
	rayCount = RAYFIELD.get_child_count() # Gets count of rays in ray field
	rays = RAYFIELD.get_children() # Array with references to all rays
	player = get_parent().get_node("Player") # Reference to the player

"""
Purpose: 
	Called every frame

Parameters: 
	delta - Length of time since last frame
"""
func _physics_process(delta):
	move(delta)

"""
Purpose:
	Puts all movement functions together and moves the character
"""
func move(delta):
	update_direction_vector()
	update_correction_vector()
	update_final_vector()
	velocity = finalVector * speed
	move_and_collide(velocity * delta)
	update_rotation()

""" 
Purpose:
	Updates direction vector based on path to target position
"""
func update_direction_vector():
	directionVector = to_local(NAV.get_next_path_position()).normalized()

""" 
Purpose:
	Checks for collisions and creates a vector pointing in the opposite direction of
	any collisions detected
"""
func update_correction_vector():
	correctionVector = Vector2.ZERO
	collisions = 0
	var collisionDirection : Vector2
	for i in rayCount: # Loop through all rays
		if rays[i].is_colliding(): # Check if current ray is colliding
			# Add to total collisions detected for calculating average vector
			collisions += 1 
			# Rotate a vector to be same direction as ray
			collisionDirection = Vector2.DOWN.rotated(rays[i].rotation) 
			correctionVector += collisionDirection # Add vector to correction vector
	if collisions > 0: # If any collisions occur
		# Average the vector, inverse it, and then normalize
		# This is done to so the character is pushed away from any obstacles
		correctionVector = -(correctionVector / collisions).normalized()

"""
Purpose:
	Determines the final direction the character will be moving in based on where it
	wants to go and any obstacles it detects.
"""
func update_final_vector():
	# Check if both north and south are colliding
	var ns_collisions = N.is_colliding() and S.is_colliding()
	# Check if both west and east are collising
	var we_collisions = W.is_colliding() and E.is_colliding()
	
	# If either N and S or W and E are colliding then the character is moving in
	# a corridor. Thus the character should use the direction vector to move straight.
	# If this is not included the character tends to bounce around in a corridor due to
	# collisions detected on either side when it just needs to go straight.
	if (ns_collisions or we_collisions):
		finalVector = directionVector
	else:
		# Even with the correction vector the character sometimes gets stuck on corners
		# This tends to happen when the resulting vector points into an obstacle since 
		# the 2 vectors are too far apart
		# when this happens the final vector gets inversed so that the character
		# moves away from the obstacle first before continuing on its path
		var radLimit = 135 * PI / 180
		# Get average of direction and correction vectors and normalize
		finalVector = ((directionVector + correctionVector) / 2).normalized()
		
		var angleBetween = abs(directionVector.angle_to(correctionVector))
		if  angleBetween > radLimit and collisions > 1:
			finalVector = -finalVector

"""
Purpose:
	Update the direction the sprite is facing
"""
func update_rotation():
	$Sprite2D.rotation = directionVector.angle()
	$CollisionPolygon2D.rotation = directionVector.angle()
	$HitBox/CollisionPolygon2D.rotation = directionVector.angle()

""" 
Purpose:
	Updates the target position to the current location of the player 
"""
func create_path():
	NAV.target_position = player.global_position

""" 
Purpose:
	Calls create_path every 0.1 seconds to update path 
"""
func nav_timer_timeout():
	create_path()
