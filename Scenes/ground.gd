extends Node3D

@onready var pieces : Array = [$Plane2, $Plane] # Contains the mesh pieces of the ground
@onready var current_piece_index: int = 0 # Index of the currently displayed piece
@onready var current_piece_distance_moved: float = 500
const DISTANCE_BEFORE_SWAP: float = 955
const SWAP_TO_LOCATION: Vector3 = Vector3(-955 * 1.5,0,0)
const VELOCITY : Vector3 = Vector3(50,0,0) 

var num_spawned : int
var is_flying : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_swap()
	
func handle_movement(delta: float):
	if !is_flying:
		return

	# Move all pieces and update the running total for distance moved
	for piece in pieces:
		piece.position += VELOCITY * delta
	current_piece_distance_moved += (VELOCITY * delta).length()

func handle_swap():
	if !(current_piece_distance_moved > DISTANCE_BEFORE_SWAP):
		return
	
	# Get the index of the next piece in the list and update the value
	current_piece_index = (current_piece_index + 1) % pieces.size()

	# Move the next piece to the move location
	var new_piece: MeshInstance3D = pieces[current_piece_index]
	new_piece.position = SWAP_TO_LOCATION
	# print("Moving %s to %s" % [new_piece.name, SWAP_TO_LOCATION])

	# Reset the running movement tracker
	current_piece_distance_moved = 0