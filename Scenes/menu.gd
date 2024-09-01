extends Control

func _on_play_pressed():
	#play click sound effect
	#$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	



func _on_quit_pressed():
	get_tree().quit()

func _on_controls_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
