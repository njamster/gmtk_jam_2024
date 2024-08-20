class_name BetterButton extends Button


func _enter_tree() -> void:
	pressed.connect(_play_press_sound)


func _play_press_sound() -> void:
	AudioManager.play_sound(preload("sounds/press.ogg"))
