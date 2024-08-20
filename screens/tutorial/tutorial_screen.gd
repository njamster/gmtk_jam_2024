extends Control



func _enter_tree() -> void:
	%Part1.visible_ratio = 1
	%Part2.visible_ratio = 0
	%Part3.visible_ratio = 0

	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		# if runnig the web version on a mobile device, adapt the tutorial
		%Part2.text = %Part2.text.replace("Move the mouse", "Press and hold")
		%Part2.text = %Part2.text.replace("Click to", "Release to")


func _on_continue_pressed() -> void:
	if %Part1.visible_ratio != 1:
		%Part1.visible_ratio = 1
	elif %Part2.visible_ratio != 1:
		%Part2.visible_ratio = 1
	elif %Part3.visible_ratio != 1:
		%Part3.visible_ratio = 1
	else:
		get_tree().change_scene_to_file("res://screens/game/game.tscn")
