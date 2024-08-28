extends RigidBody3D
var fall_direction: Vector3 = Vector3(0,-1,0) #Set by spawner when spawned, default is set here

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_velocity = fall_direction
	angular_velocity = Vector3(randf_range(0,1), randf_range(0,1), randf_range(0,1)).normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
