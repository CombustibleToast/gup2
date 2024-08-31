extends Node3D

@export var pieces : Array # Contains pieces of the ground as PackedScenes.
const NUM_AT_TIME : int = 3 # Defines the number of pieces which are allowed to spawn at once. `pieces` needs to be at least 1 larger.
const VELOCITY : Vector3 = Vector3(0,0,1) 

var num_spawned : int
var is_flying : bool

var old_pieces : Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	old_pieces = range(NUM_AT_TIME)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_flying: 
		if num_spawned < NUM_AT_TIME: handle_spawning(delta)

func handle_spawning(delta: float) -> void:
	if pieces.size() <= NUM_AT_TIME:
		return
	
