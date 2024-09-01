extends Node3D

# Spawning Object
@export var cloud_object: PackedScene
# const SPAWN_Z_RANGE: Array = [-7,7]
# const SPAWN_HEIGHT: float = 5
const SPAWN_HEIGHT: Array = [-7,7]
const SPAWN_Z: float = 15
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

	# Pick a location to spawn the cloud
	# var MAX_Z = player.BOUNDS.z
	# var spawn_location = Vector3(0, SPAWN_HEIGHT, randf_range(-MAX_Z, MAX_Z))
	var MAX_Y = player.BOUNDS.y
	var spawn_location = Vector3(0, randf_range(-MAX_Y, MAX_Y), SPAWN_Z)

	# set the cloud to move towards the left
	var direction = Vector3(0,0,-1)

	# Create a direction vector from the spawn location to the above point, normalize, and apply speed
	direction = direction.normalized()
	direction *= randf_range(FALL_VELOCITY_SPEED_RANGE[0], FALL_VELOCITY_SPEED_RANGE[1])

	# Spawn the cloud
	var new_cloud: Node3D = cloud_object.instantiate()
	new_cloud.position = spawn_location
	new_cloud.fall_direction = direction
	new_cloud.player_reference = player
	add_child(new_cloud)

	# Reset timer
	time_elapsed = 0
	next_spawn_time = randf_range(MIN_SPAWN_TIME, MAX_SPAWN_TIME)

	# print("Spawned cloud @ %s, next in %s seconds" % [new_cloud.position, next_spawn_time])
