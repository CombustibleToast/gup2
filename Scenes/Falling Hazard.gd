extends RigidBody3D

var player_reference: Node3D # set by spawner
var ground_reference: Node3D # set by spawner
var fall_direction: Vector3 = Vector3(0,0,0) #Set by spawner when spawned, default is set here

@onready var clickable = true
@onready var hovered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Start falling and rotating
	linear_velocity = fall_direction
	angular_velocity = Vector3(randf_range(-1,1), randf_range(-1,1), randf_range(-1,1)).normalized()

	# Connect to onhit signal
	if player_reference != null :
		player_reference.connect("plane_hit", on_hit)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_click()

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
	fall_direction += Vector3(-20,-3,-5)
	axis_lock_linear_x = false

	# Make it clickable
	clickable = true

func handle_ground():
	get_parent().get_parent().hazard_hit_ground(self)

func handle_click():
	if hovered && Input.is_action_just_pressed("click"):
		print("Destroyed %s with click" % name)
		queue_free()

func _on_mouse_entered() -> void:
	print("Mouse entered %s" % name)
	hovered = true

func _on_mouse_exited() -> void:
	# print("Mouse exited %s" % name)
	hovered = false
