extends CharacterBody2D


const MOVE_SPEED = 300.0
const JUMP_VELOCITY = -700.0

@export var weight := 5.0

var _carrier

var _can_double_jump := false


func _physics_process(delta: float) -> void:
	if is_on_floor():
		_can_double_jump = true
		if _carrier == null:
			var collider = get_slide_collision(0).get_collider()
			if "_carrier" in collider:
				_carrier = collider._carrier
			else:
				_carrier = collider
			_carrier.add_weight(weight)
	else:
		if _carrier:
			_carrier.subtract_weight(weight)
			_carrier = null
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif _can_double_jump:
			velocity.y = 0.75 * JUMP_VELOCITY
			_can_double_jump = false

	var direction := Input.get_axis("walk_left", "walk_right")
	if direction:
		velocity.x = direction * MOVE_SPEED
	else:
		velocity.x = 0

	move_and_slide()
