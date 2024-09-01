extends RigidBody3D

var player_reference: Node3D # set by spawner
var ground_reference: Node3D # set by spawner
var fall_direction: Vector3 = Vector3(0,-2,0) #Set by spawner when spawned, default is set here

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Start falling and rotating
	linear_velocity = fall_direction
	angular_velocity = Vector3(randf_range(-1,1), randf_range(-1,1), randf_range(-1,1)).normalized()

	# Connect to onhit signal
	if !player_reference:
		queue_free() #TODO: remove this after removing the single cube that isn't spawned
	player_reference.connect("plane_hit", on_hit)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	linear_velocity = fall_direction

func on_hit(incoming_name: String):
	#Ignore if hit wasn't this instance
	if incoming_name != name:
		return

	# print("%s received signal!" % name)
	
	# For now, just destroy
	queue_free()

func _on_area_entered(area:Area3D) -> void:
	var aname = area.name

	# if aname != "Hazard teleport trigger" && aname != "Hazard ground trigger":
	# 	return

	# print("%s entered %s" % [name, aname])

	if aname == "Hazard teleport trigger":
		handle_teleport()

	if aname == "Hazard ground trigger":
		handle_ground()

func handle_teleport():
	# Hazard needs to fall towards the center of the ground plane, otherwise it will fall out of the screen
	fall_direction += Vector3(-20,-5,-5)
	axis_lock_linear_x = false

func handle_ground():
	pass
