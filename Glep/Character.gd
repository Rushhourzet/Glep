extends RigidBody

signal createSubtractingMesh

var moveSpeed = 100
var jumpForce = 40
var rotationSpeed = 0.01
var velocity = Vector3()
var dashFactor = 5
var jump = false
var doubleJump = true
var camera = Camera
var rayCast = RayCast
var ray_length = 100
var rc_position = Vector3()

func _ready():
	camera = $PlayerCamera
	rayCast = $PlayerCamera/RayCast
	
func _physics_process(delta):
	#move
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
	#dash
	if Input.is_action_just_pressed("dash") and $dashCD.is_stopped():
		apply_impulse(Vector3(), get_input() * delta * moveSpeed * dashFactor)
	#Lock and Unlock mouse
	if Input.is_action_just_pressed("ui_cancel") and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("shoot") and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#Raycast
	if rayCast.collide_with_bodies and Input.is_action_just_pressed("shoot"):
		#print(rayCast.get_collider().get_script())
		GlobalVars.rc_position = rayCast.get_collision_point()
		emit_signal("createSubtractingMesh")

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		$PlayerCamera.rotate_x(-event.relative.y * rotationSpeed)
		rotate_y(-event.relative.x * rotationSpeed)
		$PlayerCamera.rotation_degrees.x = clamp($PlayerCamera.rotation_degrees.x, -90, 90)

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
