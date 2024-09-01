# extends SubViewport
extends Node3D

@onready var viewport: SubViewport = $"TopScreenView"
@onready var camera: Camera3D = $"TopScreenView/TopScreenCam"

# copied from https://www.reddit.com/r/godot/comments/tx9x2b/a_guide_to_mouse_events_in_subviewports/

# extends SubViewportContainer

func _ready():
	set_process_unhandled_input(true)

func _input(event):
	# fix by ArdaE https://github.com/godotengine/godot/issues/17326#issuecomment-431186323
	# print("Event!")
	if event is InputEventMouse:
		viewport.push_input(event, true)
		var mouseEvent: InputEventMouse = event.duplicate()
		var eventNewPos: Vector3 = Vector3(event.position.x, event.position.y, 0)
		eventNewPos = camera.global_transform.affine_inverse() * eventNewPos
		mouseEvent.position = Vector2(eventNewPos.x, eventNewPos.y)
		# viewport._unhandled_input(mouseEvent)
		viewport.push_input(mouseEvent)
	else:
		pass
		# child._unhandled_input(event)
