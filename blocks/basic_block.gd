extends CharacterBody2D

@export var weight := 5.0

var _carrier


func _physics_process(delta: float) -> void:
	if is_on_floor():
		if _carrier == null:
			var collider = get_slide_collision(0).get_collider()
			if not collider:
				return
			if "_carrier" in collider:
				_carrier = collider._carrier
			else:
				if collider.has_method("add_weight"):
					_carrier = collider
			if _carrier:
				_carrier.add_weight(weight)
	else:
		if _carrier:
			_carrier.subtract_weight(weight)
			_carrier = null
		velocity += get_gravity() * delta

	move_and_slide()
