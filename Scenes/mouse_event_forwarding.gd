# extends SubViewport
extends Node3D

@onready var bottom_screen_hovered = false

# copied from https://www.reddit.com/r/godot/comments/tx9x2b/a_guide_to_mouse_events_in_subviewports/

# extends ViewportContainer

func _ready():
	# set_process_unhandled_input(true)
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click") && bottom_screen_hovered:
		$"..".bottom_screen_clicked()

# func _input(event):
# 	# fix by ArdaE https://github.com/godotengine/godot/issues/17326#issuecomment-431186323
# 	for child in get_children():
# 		if event is InputEventMouse:
# 			var mouseEvent = event.duplicate()
# 			# mouseEvent.position = get_global_transform_with_canvas().affine_inverse() * event.position
# 			mouseEvent.position = get_final_transform().inverse() * event.position
# 			child.unhandled_input(mouseEvent)
# 		else:
# 			child.unhandled_input(event)


func mouse_entered_bottom_screen() -> void:
	bottom_screen_hovered = true
	pass # Replace with function body.


func mouse_exited_bottom_screen() -> void:
	bottom_screen_hovered = false
	pass # Replace with function body.
