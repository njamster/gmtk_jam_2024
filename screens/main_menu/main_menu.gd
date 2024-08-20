extends Control


const BASIC_BLOCK := preload("res://blocks/basic_block.tscn")


func _ready() -> void:
	_on_spawn_timer_timeout()
	%Play.grab_focus()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/game/game.tscn")


func _on_spawn_timer_timeout() -> void:
	const NUM_BLOCKS := 5.0
	for i in range(NUM_BLOCKS):
		var block := BASIC_BLOCK.instantiate()
		block.global_position.x = randf_range(i * 1920/NUM_BLOCKS, (i+1) * 1920/NUM_BLOCKS)
		block.global_position.y = randf_range(-100, -400)
		block.rotation_degrees = randi_range(-20, 20)
		block.state = block.States.MENU_SCREEN
		$Blocks.add_child(block)
