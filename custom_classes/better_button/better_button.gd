class_name BetterButton extends Button


func _enter_tree() -> void:
	self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

	pressed.connect(_play_press_sound)


func _play_press_sound() -> void:
	AudioManager.play_sound(preload("sounds/press.ogg"))
