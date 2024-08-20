extends RigidBody2D


const MIN_SCALE := 1.0
const MAX_SCALE := 8.0

var _is_grounded := false


func _enter_tree() -> void:
	$Appearance.self_modulate = Color(
		randf_range(0.5, 0.9), randf_range(0.5, 0.9), randf_range(0.5, 0.9)
	)
	$ExplosionEffect.color = $Appearance.self_modulate


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


func _on_body_entered(_body: Node) -> void:
	$AirTimer.stop()
	_is_grounded = true


func _on_body_exited(_body: Node) -> void:
	$AirTimer.start()


func _physics_process(_ydelta: float) -> void:
	if _is_grounded:
		if position.x < 960:
			get_tree().get_root().get_node("Game/Scale").total_weight_L += mass
		else:
			get_tree().get_root().get_node("Game/Scale").total_weight_R += mass


func _on_air_timer_timeout() -> void:
	_is_grounded = false
