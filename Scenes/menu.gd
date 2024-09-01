extends Control

func _on_play_pressed():
	
	#change scene to game
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	



func _on_quit_pressed():
	get_tree().quit()

func _on_controls_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
