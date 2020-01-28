extends RigidBody

var moveSpeed = 200
var jumpForce = 400
var rotationSpeed = 0.4
var velocity = Vector3()




func _physics_process(delta):
	apply_impulse(Vector3(), get_input() * delta * moveSpeed)

func _unhandled_input(event):
	pass
	
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