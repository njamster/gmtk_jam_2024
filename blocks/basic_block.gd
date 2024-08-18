extends RigidBody2D


var _is_grounded := false


func _on_body_entered(_body: Node) -> void:
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
