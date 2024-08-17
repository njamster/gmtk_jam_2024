extends AnimatableBody2D


var total_weight := 10.0


func add_weight(weight : float) -> void:
	total_weight += weight


func subtract_weight(weight : float) -> void:
	total_weight -= weight
