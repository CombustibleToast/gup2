extends Node3D

# Connections 
@onready var player: Node3D = $"Plane"
@onready var hazard_spawner: Node3D = $"Hazard Spawner"
@onready var fire_label: Label = $"dual-pro v4/TopScreenView/Control/VBoxContainer/FireLabel"

# Statistics
@onready var fire_amount: float = 0
const FIRE_GROWTH_RATE: float = 0.1
const MAX_FIRE_THRESHOLD: float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	grow_fire_amount(delta)

	# TODO: update graphic that shows fire amount
	# TODO: update health graphic

	check_loss_conditions()

func grow_fire_amount(delta):
	fire_amount += FIRE_GROWTH_RATE * delta

func check_loss_conditions():
	if player.health <= 0:
		print("0 health")
		lose()
	
	if fire_amount >= MAX_FIRE_THRESHOLD:
		print("max fire")
		lose()

func lose():
	pass

func hazard_hit_ground(node: Node3D):
	# Increase fire amount
	fire_amount += 1
	fire_label.text = "FIRE: %d" % fire_amount
	print("fire hit ground, now %f" % fire_amount)

	# TODO: spawn the fire object where the hazard landed
	
	# Delete the hazard object
	node.queue_free()
