extends Control


const BASIC_BLOCK := preload("res://blocks/basic_block.tscn")
const SAW_BLADE := preload("res://sawblade/saw_blade.tscn")

var _game_is_on := false

var next_block


func _init() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CONFINED)


func _enter_tree() -> void:
	for y in [0, 1080]:
		for x in range(32, 1920, 64):
			var saw_blade := SAW_BLADE.instantiate()
			saw_blade.global_position = Vector2(x, y)
			$Sawblades.add_child(saw_blade)


func _ready() -> void:
	_spawn_next_block()


func _spawn_next_block() -> void:
	if next_block:
		next_block.modulate.a = 1.0
		next_block.state = next_block.States.DROPPING

	next_block = BASIC_BLOCK.instantiate()
	$Blocks.add_child(next_block)

	next_block.global_position.x = clamp(get_global_mouse_position().x, 80, 1840)
	next_block.global_position.y = 30 + 16 * (next_block.scale_factor + 1)

	next_block.landed.connect(func(): _game_is_on = true)
	next_block.killed.connect(_on_block_killed)


func _on_block_killed(killed_block: Node) -> void:
	if not _game_is_on:
		return

	var game_over := true # assumption

	for block in $Blocks.get_children():
		if block._is_grounded:
			game_over = false
			break # we already know it's not over

	if game_over:
		await killed_block.get_node("ExplosionEffect").finished
		GameOverScreen.open()


func _process(_delta: float) -> void:
	if next_block:
		next_block.global_position.x = clamp(get_global_mouse_position().x, 80, 1840)
		next_block.modulate.a = ($SpawnTimer.wait_time - $SpawnTimer.time_left - 0.5) / $SpawnTimer.wait_time


func _on_spawn_timer_timeout() -> void:
	_spawn_next_block()


func _on_level_border_body_entered(body: Node2D) -> void:
	if body.is_in_group("Block"):
		body.kill()


func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT) or \
		(event is InputEventKey and event.key_label == KEY_SPACE):
			if event.is_released():
				if ($SpawnTimer.wait_time - $SpawnTimer.time_left) > 0.6:
					_spawn_next_block()
					$SpawnTimer.start($SpawnTimer.wait_time)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_game"):
		PauseScreen.open()


func _on_pause_button_pressed() -> void:
	PauseScreen.open()
