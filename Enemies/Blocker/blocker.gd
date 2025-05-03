class_name Blocker extends CharacterBody2D

"""Movement Speed """
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

""" Vector for Determining Movement Direction """
var directionVector := Vector2.ZERO
var correctionVector := Vector2.ZERO
var finalVector := Vector2.ZERO

""" Target Variables """
var targetPosition : Vector2 # Final destination
var reachedTarget := false # Bool if final destination reached

"""
Purpose:
	Called when entering scene
"""
func _ready():
	rayCount = RAYFIELD.get_child_count() # Gets count of rays in ray field
	rays = RAYFIELD.get_children() # Array with references to all rays
	GameGlobal.BLOCKER_SPOTS.shuffle() # Randomize the spots for blockers
	targetPosition = GameGlobal.BLOCKER_SPOTS[0] # Get the first element
	GameGlobal.BLOCKER_SPOTS.remove_at(0) # Remove that position
	NAV.target_position = targetPosition # Set NAV target to target position

"""
Purpose: 
	Called every frame at a fixed rate of 60 fps

Parameters: 
	delta - Length of time since last frame
"""
func _physics_process(delta):
	if !reachedTarget:
		move(delta)
		target_reached_check()

"""
Purpose:
	Check if blocker has reached its final destination
"""
func target_reached_check():
	# Check to see if the Blocker is in the general area of target destination
	if position.x > targetPosition.x -0.5 and position.x < targetPosition.x + 0.5:
		if position.y > targetPosition.y -0.5 and position.y < targetPosition.y + 0.5:
			reachedTarget = true
			# Adjusts scale of Blocker to fill area
			$Sprite2D.scale = Vector2(1, 1)
			$CollisionShape2D.scale = Vector2(2.5, 2.5)
			$HitBox/CollisionShape2D.scale = Vector2(1.7, 1.7)

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
		# Average the vector, inverse it (opposite direction of collisions), and then normalize
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
	
	# To prevent character bouncing when moving through a corridor
	if (ns_collisions or we_collisions):
		finalVector = directionVector
	else:
		# Get average of direction and correction vectors and normalize
		finalVector = ((directionVector + correctionVector) / 2).normalized()
