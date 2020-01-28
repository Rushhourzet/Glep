extends RigidBody

var moveSpeed = 20
var jumpForce = 40
var rotationSpeed = 0.01
var velocity = Vector3()
var dashFactor = 5
var jump = false
var doubleJump = true




func _physics_process(delta):
	apply_impulse(Vector3(), get_input() * delta * moveSpeed)
	
	#Grounded or on Wall
	if contacts_reported > 1:
		jump = true
	#jump
	if Input.is_action_just_pressed("jump") and jump and $jumpCD.is_stopped():
		apply_impulse(Vector3(), Vector3.UP * jumpForce)
		$jumpCD.start()
		jump = false
	#doublejump
	if Input.is_action_just_pressed("jump") and contacts_reported == 0 and doubleJump:
		apply_impulse(Vector3(), Vector3.UP * jumpForce)
		doubleJump = false
	if Input.is_action_just_pressed("dash") and $dashCD.is_stopped():
		apply_impulse(Vector3(), get_input() * delta * moveSpeed * dashFactor)
		

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Camera.rotate_x(-event.relative.y * rotationSpeed)
		rotate_y(-event.relative.x * rotationSpeed)
	
func get_input():
	velocity = Vector3()
	if Input.is_action_pressed("move_forward"):
		velocity -= global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		velocity += global_transform.basis.z
	if Input.is_action_pressed("strafe_left"):
		velocity -= global_transform.basis.x
	if Input.is_action_pressed("strafe_right"):
		velocity += global_transform.basis.x
	velocity = velocity.normalized()
	return velocity