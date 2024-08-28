extends Node3D

# Spawning Object
@export var hazard_object: PackedScene
const SPAWN_Z_RANGE: Array = [-7,7]
const SPAWN_HEIGHT: float = 5

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

	# Spawn the hazard
	var new_hazard: Node3D = hazard_object.instantiate()
	new_hazard.position = Vector3(0, SPAWN_HEIGHT, randf_range(SPAWN_Z_RANGE[0], SPAWN_Z_RANGE[1]))
	new_hazard.player_reference = player
	add_child(new_hazard)

	# Reset timer
	time_elapsed = 0
	next_spawn_time = randf_range(MIN_SPAWN_TIME, MAX_SPAWN_TIME)

	# print("Spawned hazard @ %s, next in %s seconds" % [new_hazard.position, next_spawn_time])
