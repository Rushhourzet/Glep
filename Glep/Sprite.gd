extends Sprite

export (int) var speed = 200

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		        velocity.x += 100
	if Input.is_action_pressed('left'):
		velocity.x -= 100
	if Input.is_action_pressed('down'):
		velocity.y += 100
	if Input.is_action_pressed('up'):
		velocity.y -= 100
		print("up")
	velocity = velocity * speed

func _physics_process(delta):
	get_input()
	$PlayerBody2D.add_central_force(velocity)
	print(velocity)