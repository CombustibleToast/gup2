extends RigidBody3D

var player_reference: Node3D # set by spawner
var fall_direction: Vector3 = Vector3(0,-1,0) #Set by spawner when spawned, default is set here

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Start falling and rotating
	linear_velocity = fall_direction
	angular_velocity = Vector3(randf_range(-1,1), randf_range(-1,1), randf_range(-1,1)).normalized()

	# Connect to onhit signal
	print(player_reference)
	if !player_reference:
		queue_free() #TODO: remove this after removing the single cube that isn't spawned
	player_reference.connect("plane_hit", on_hit)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_hit(incoming_name: String):
	print("%s received signal!" % name)
	#Ignore if hit wasn't this instance
	if incoming_name != name:
		return

	
	# For now, just destroy
	queue_free()