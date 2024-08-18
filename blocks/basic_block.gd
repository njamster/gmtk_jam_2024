extends RigidBody2D


const MIN_SCALE := 1.0
const MAX_SCALE := 8.0

var _is_grounded := false


func rescale(factor : float) -> void:
	factor = clamp(factor, MIN_SCALE, MAX_SCALE)

	$ExplosionEffect.scale *= Vector2(factor, factor)
	$ExplosionEffect.scale_amount_min = 1.0 + 0.125 * factor
	$ExplosionEffect.scale_amount_max = 1.0 + 0.500 * factor
	$ExplosionEffect.amount *= factor

	$Appearance.scale *= Vector2(factor, factor)
	$Hitbox.scale *= Vector2(factor, factor)

	mass *= factor


func kill() -> void:
	$Appearance.hide()
	_is_grounded = false
	$ExplosionEffect.emitting = true
	await $ExplosionEffect.finished
	queue_free()


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Block") and not body._is_grounded:
		return
	$AirTimer.stop()
	_is_grounded = true


func _on_body_exited(_body: Node) -> void:
	$AirTimer.start()


func _physics_process(_delta: float) -> void:
	if _is_grounded:
		if position.x < 960:
			get_tree().get_root().get_node("Game/Scale").total_weight_L += mass
		else:
			get_tree().get_root().get_node("Game/Scale").total_weight_R += mass


func _on_air_timer_timeout() -> void:
	_is_grounded = false


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if _is_grounded:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_released():
				self.kill()
