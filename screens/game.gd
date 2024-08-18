extends Node2D


const BASIC_BLOCK := preload("res://blocks/basic_block.tscn")

var button_pressed_time : float


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			button_pressed_time = Time.get_unix_time_from_system()
		else:
			var hold_time = Time.get_unix_time_from_system() - button_pressed_time

			var block := BASIC_BLOCK.instantiate()
			block.global_position.x = event.global_position.x
			block.global_position.y = -100
			block.rescale(4 * hold_time)
			$Blocks.add_child(block)


func _on_level_border_body_entered(body: Node2D) -> void:
	if body.is_in_group("Block"):
		body.kill()
