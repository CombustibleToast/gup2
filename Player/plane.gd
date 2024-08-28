extends CharacterBody3D

const SPEED = 5.0
const BOUNDS: Vector3 = Vector3(0,5,6)

func _physics_process(delta):
	update_movement(delta)
	clamp_to_bounds()

func update_movement(delta):
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("right", "left", "down", "up")
	var direction = Vector3(0, input_dir.y, input_dir.x).normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector3.ZERO 
	# Todo: make each key lerp to and from max speed values

	move_and_slide()

func clamp_to_bounds():
	position = position.clamp(-BOUNDS, BOUNDS)

	# print(position)