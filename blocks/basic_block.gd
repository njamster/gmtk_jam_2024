extends RigidBody2D


const MIN_SCALE := 0.5
const MAX_SCALE := 8.0

var _is_grounded := false


func rescale(factor : float) -> void:
	factor = clamp(factor, MIN_SCALE, MAX_SCALE)

	$Appearance.scale *= Vector2(factor, factor)
	$Hitbox.scale *= Vector2(factor, factor)
	mass *= factor


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
