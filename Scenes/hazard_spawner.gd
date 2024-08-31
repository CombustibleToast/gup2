extends Node3D

# Spawning Object
@export var hazard_object: PackedScene
const SPAWN_Z_RANGE: Array = [-7,7]
const SPAWN_HEIGHT: float = 5
const FALL_DIRECTION_MAX_PLANE_RADIUS: float = 1
const FALL_VELOCITY_SPEED_RANGE: Array = [2,5]

# Spawn Time
@onready var spawning: bool = true # used to pause the countdown timer for spawning
const MIN_SPAWN_TIME: float = 1
const MAX_SPAWN_TIME: float = 3
@onready var next_spawn_time = 0
@onready var time_elapsed = 0

# Connections
@onready var player: Node3D = $"../Plane"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_spawning(delta)

func handle_spawning(delta):
	# Do nothing if no spawning
	if !spawning:
		return

	time_elapsed += delta

	# If the time elapsed hasn't been passed, finish here
	if time_elapsed < next_spawn_time:
		return

	# Pick a location to spawn the hazard
	var MAX_Z = player.BOUNDS.z
	var spawn_location = Vector3(0, SPAWN_HEIGHT, randf_range(-MAX_Z, MAX_Z))

	# Pick a direction to fall towards, i.e. pick a spot near the plane and fall in that direction
	# Randomly generate a polar coordinate around the plane
	var r: float = randf_range(0, FALL_DIRECTION_MAX_PLANE_RADIUS)
	var theta: float = randf_range(0, 2 * PI)
	var point: Vector3 = Vector3(0, r * sin(theta), r * cos(theta)) + player.position

	# Create a direction vector from the spawn location to the above point, normalize, and apply speed
	var direction = point - spawn_location
	direction = direction.normalized()
	direction *= randf_range(FALL_VELOCITY_SPEED_RANGE[0], FALL_VELOCITY_SPEED_RANGE[1])

	# Spawn the hazard
	var new_hazard: Node3D = hazard_object.instantiate()
	new_hazard.position = spawn_location
	new_hazard.fall_direction = direction
	new_hazard.player_reference = player
	add_child(new_hazard)

	# Reset timer
	time_elapsed = 0
	next_spawn_time = randf_range(MIN_SPAWN_TIME, MAX_SPAWN_TIME)

	# print("Spawned hazard @ %s, next in %s seconds" % [new_hazard.position, next_spawn_time])
