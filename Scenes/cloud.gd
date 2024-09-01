extends RigidBody3D

var player_reference: Node3D # set by spawner
# set fall direction to the left
var fall_direction: Vector3 = Vector3(-1,0,0) #Set by spawner when spawned, default is set here

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Start falling and rotating
	linear_velocity = fall_direction
	angular_velocity = Vector3(randf_range(-1,1), randf_range(-1,1), randf_range(-1,1)).normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	linear_velocity = fall_direction

# destroy the object when it leaves the frame
func _on_Falling_Hazard_body_exited(body: Node) -> void:
	queue_free()

# destroy self when 