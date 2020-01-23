extends RigidBody

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

