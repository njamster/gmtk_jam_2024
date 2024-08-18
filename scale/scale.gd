extends Node2D


const MAX_HEIGHT := 500  # pixels
const DEFAULT_WEIGHT := 10.0  # kilogram
const MOVE_SPEED := 60.0  # pixels per second

var total_weight_L := DEFAULT_WEIGHT
var total_weight_R := DEFAULT_WEIGHT


func _physics_process(delta: float) -> void:
	if total_weight_L == total_weight_R:
		# return to equilibrium
		%LeftSide.position.y = move_toward(%LeftSide.position.y, 0, MOVE_SPEED * delta)
		%RightSide.position.y = move_toward(%RightSide.position.y, 0, MOVE_SPEED * delta)
	elif total_weight_L > total_weight_R:
		# move left side up & right side down
		var weight_ratio = total_weight_L / total_weight_R
		var height = clamp((weight_ratio - 1.0) * 100, 0, MAX_HEIGHT)
		var speed = weight_ratio * MOVE_SPEED * delta
		%LeftSide.position.y = move_toward(%LeftSide.position.y, height, speed)
		%RightSide.position.y = move_toward(%RightSide.position.y, -1 * height, speed)
	elif total_weight_L < total_weight_R:
		# move right side up & left side down
		var weight_ratio = total_weight_R / total_weight_L
		var height = clamp((weight_ratio - 1.0) * 100, 0, MAX_HEIGHT)
		var speed = weight_ratio * MOVE_SPEED * delta
		%LeftSide.position.y = move_toward(%LeftSide.position.y, -1 * height, speed)
		%RightSide.position.y = move_toward(%RightSide.position.y, height, speed)

	total_weight_L = DEFAULT_WEIGHT
	total_weight_R = DEFAULT_WEIGHT
