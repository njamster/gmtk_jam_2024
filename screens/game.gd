extends Node2D

const BASIC_BLOCK := preload("res://blocks/basic_block.tscn")


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_released():
		if event.button_index == MOUSE_BUTTON_LEFT:
			var block := BASIC_BLOCK.instantiate()
			block.global_position.x = randf_range(242, 778)
			block.global_position.y = -100
			$Blocks.add_child(block)
		if event.button_index == MOUSE_BUTTON_RIGHT:
			var block := BASIC_BLOCK.instantiate()
			block.global_position.x = randf_range(1142, 1678)
			block.global_position.y = -100
			$Blocks.add_child(block)
