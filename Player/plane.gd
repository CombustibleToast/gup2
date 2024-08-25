extends CharacterBody3D

const SPEED = 5.0

func _physics_process(delta):
	update_movement(delta)

func update_movement(delta):
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("right", "left", "down", "up")
	var direction = Vector3(0, input_dir.y, input_dir.x).normalized()
	print(direction)
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector3.ZERO #smooth/lerp this in the future

	move_and_slide()
