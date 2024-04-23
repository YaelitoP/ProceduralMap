extends CharacterBody2D


const SPEED = 300.0
@onready var sprites: = $bunnySprite
@onready var camera: = $Camera2D
var auxX: = 0
var auxY: = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("left", "right")
	
	var directionY = Input.get_axis("up", "down")
	
	if directionX:
		auxY = 0
		velocity.x = directionX * SPEED
		
		if directionX > 0:
			sprites.play("right")
			auxX = directionX
		if directionX < 0:
			sprites.play("left")
			auxX = directionX
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if auxX > 0:
			sprites.play("idleR")
		if auxX < 0:
			sprites.play("idleL")
			
		
	if directionY:
		velocity.y = directionY * SPEED
		auxX = 0
		if directionY > 0:
			sprites.play("down")
			auxY = directionY
			
		if directionY < 0:
			auxY = directionY
			sprites.play("up")
			
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		if auxY > 0:
			sprites.play("idleD")
		if auxY < 0:
			sprites.play("idleU")
			
	move_and_slide()
	
	if Input.is_action_just_pressed("zoomIn"):
		camera.set_zoom(Vector2(camera.get_zoom().x + 0.1, camera.get_zoom().y + 0.1))
	
	if Input.is_action_just_pressed("zoomOut"):
		camera.set_zoom(Vector2(camera.get_zoom().x - 0.1, camera.get_zoom().y - 0.1))
		
