extends Node2D


const BASIC_BLOCK := preload("res://blocks/basic_block.tscn")


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_released():
			var block := BASIC_BLOCK.instantiate()
			block.global_position.x = event.global_position.x
			block.global_position.y = -100
			$Blocks.add_child(block)


func _on_level_border_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().reload_current_scene.call_deferred()
	elif body.is_in_group("Block"):
		body.queue_free()
