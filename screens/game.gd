extends Node2D


const BASIC_BLOCK := preload("res://blocks/basic_block.tscn")

var next_block_scale : float


func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CONFINED)

	_pick_next_block_scale()


func _pick_next_block_scale() -> void:
	next_block_scale = 0.5 * randi_range(2, 8)
	$SpawnPreview.scale.x = next_block_scale


func _process(_delta: float) -> void:
	$SpawnPreview.global_position.x = get_global_mouse_position().x - (16 * next_block_scale)
	$SpawnPreview.modulate.a = $SpawnTimer.wait_time - $SpawnTimer.time_left - 0.8


func _on_spawn_timer_timeout() -> void:
	var block := BASIC_BLOCK.instantiate()
	block.global_position.x = get_global_mouse_position().x
	block.global_position.y = -100
	block.rescale(next_block_scale)
	$Blocks.add_child(block)

	_pick_next_block_scale()


func _on_level_border_body_entered(body: Node2D) -> void:
	if body.is_in_group("Block"):
		body.kill()


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_game"):
		PauseScreen.open()
