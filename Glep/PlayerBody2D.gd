extends RigidBody2D

export (int) var speed = 200
export (float) var _friction = 5

var velocity = Vector2()

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('right'):
        velocity.x += 1
        return true
    if Input.is_action_pressed('left'):
        velocity.x -= 1
        return true
    if Input.is_action_pressed('down'):
        velocity.y += 1
        return true
    if Input.is_action_pressed('up'):
        velocity.y -= 1
        return true
    return false

func _physics_process(delta):
	get_input()
	velocity = velocity.normalized() * speed
	add_force(velocity, velocity*delta )
	print (velocity)
	print (linear_velocity * delta)


func applyFriction1():
	print("a")
	if linear_velocity.x > 0:
		velocity.x -= _friction
	if linear_velocity.x < 0:
		velocity.x += _friction
	if linear_velocity.y > 0:
		velocity.y -= _friction
	if linear_velocity.y < 0:
		velocity.y += _friction

func applyFriction2():
	print("a")
	if linear_velocity.x > 0:
		set_axis_velocity(Vector2(cubeRoot(linear_velocity.x), linear_velocity.y))
	if linear_velocity.x < 0:
		set_axis_velocity(Vector2(cubeRoot(linear_velocity.x), linear_velocity.y))
	if linear_velocity.y > 0:
		set_axis_velocity(Vector2(linear_velocity.x, cubeRoot(linear_velocity.y)))
	if linear_velocity.y < 0:
		set_axis_velocity(Vector2(linear_velocity.x, cubeRoot(linear_velocity.y)))
		
func cubeRoot(var x):
	if x>0: return x*(1.0/3.0)
	return -(-x)* (1.0/3.0)