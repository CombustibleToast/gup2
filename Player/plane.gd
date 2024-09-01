extends CharacterBody3D

# Movement
const SPEED = 8.0
const BOUNDS: Vector3 = Vector3(0,5,6)

# Stats
const MAX_HEALTH: float = 10
@onready var health: float = MAX_HEALTH

# Interactions
signal plane_hit(name: String)

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

func body_entered(body:Node3D) -> void:
	# print("%s entered plane" % body.name)

	# Ignore own body
	if body.name == "Plane":
		return

	# Hit
	health -= 1
	emit_signal("plane_hit", body.name)
	print("Hit! Health is now %d" % health)