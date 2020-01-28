extends RigidBody2D

export (int) var speed = 500

var velocity = Vector2()

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('right'):
        velocity.x += 1
    if Input.is_action_pressed('left'):
        velocity.x -= 1
    if Input.is_action_pressed('down'):
        velocity.y += 1
    if Input.is_action_pressed('up'):
        velocity.y -= 1

func _physics_process(delta):
	get_input()
	velocity = velocity.normalized() * speed * delta
	apply_impulse(Vector2(), velocity)
	print (velocity)
	print (linear_velocity * delta)
