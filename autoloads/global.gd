extends Node



func take_screenshot() -> void:
	var capture = get_viewport().get_texture().get_image()
	var _time = Time.get_datetime_string_from_system()
	var filename = "user://screenshot_{0}.png".format({"0":_time})
	capture.save_png(filename)


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.key_label == KEY_F12 and event.pressed:
		take_screenshot()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			Input.set_custom_mouse_cursor(
				preload("res://theme/mouse_cursors/hand_point_click.png"),
				Input.CURSOR_ARROW, Vector2(10, 5)
			)
		else:
			Input.set_custom_mouse_cursor(
				preload("res://theme/mouse_cursors/hand_point.png"),
				Input.CURSOR_ARROW, Vector2(8, 7)
			)
