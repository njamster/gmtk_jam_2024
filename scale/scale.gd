extends Node2D


const REBALANCE_SPEED := 60.0  # pixels per second

var total_weight_L := 0
var total_weight_R := 0


func _physics_process(delta: float) -> void:
	# step 1: move the trays
	if total_weight_L == total_weight_R:
		# return to equilibrium
		%LeftSide.position.y = move_toward(%LeftSide.position.y, 0, REBALANCE_SPEED * delta)
		%RightSide.position.y = move_toward(%RightSide.position.y, 0, REBALANCE_SPEED * delta)
	else:
		var weight_difference := total_weight_L - total_weight_R
		%LeftSide.position.y += 0.5 * weight_difference * delta
		%RightSide.position.y -= 0.5 * weight_difference * delta

	# step 2: rotate the connector
	$Connector.rotation = $LeftSide.position.direction_to($RightSide.position).angle()

	# step 3: update the total weight display
	$LeftSide/Total.text = str(total_weight_L) + " kg"
	$RightSide/Total.text = str(total_weight_R) + " kg"

	GameOverScreen.highest_weight = max(
		GameOverScreen.highest_weight,
		total_weight_L + total_weight_R
	)

	# step 4: reset the total weights (will be recalculated next frame)
	total_weight_L = 0
	total_weight_R = 0
