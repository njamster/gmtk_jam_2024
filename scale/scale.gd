extends Node2D

const MAX_HEIGHT := 500   # pixels
const MOVE_SPEED := 60.0  # pixels per second


func _physics_process(delta: float) -> void:
	if %LeftSide.total_weight == %RightSide.total_weight:
		# return to equilibrium
		%LeftSide.position.y = move_toward(%LeftSide.position.y, 0, MOVE_SPEED * delta)
		%RightSide.position.y = move_toward(%RightSide.position.y, 0, MOVE_SPEED * delta)
	elif %LeftSide.total_weight > %RightSide.total_weight:
		# move left side up & right side down
		var weight_ratio = %LeftSide.total_weight / %RightSide.total_weight
		var height = clamp((weight_ratio - 1.0) * 100, 0, MAX_HEIGHT)
		var speed = weight_ratio * MOVE_SPEED * delta
		%LeftSide.position.y = move_toward(%LeftSide.position.y, height, speed)
		%RightSide.position.y = move_toward(%RightSide.position.y, -1 * height, speed)
	elif %LeftSide.total_weight < %RightSide.total_weight:
		# move right side up & left side down
		var weight_ratio = %RightSide.total_weight / %LeftSide.total_weight
		var height = clamp((weight_ratio - 1.0) * 100, 0, MAX_HEIGHT)
		var speed = weight_ratio * MOVE_SPEED * delta
		%LeftSide.position.y = move_toward(%LeftSide.position.y, -1 * height, speed)
		%RightSide.position.y = move_toward(%RightSide.position.y, height, speed)
