extends Sprite2D


const ROTATION_SPEED := 120  # degrees per second


func _process(delta: float) -> void:
	rotation_degrees -= ROTATION_SPEED * delta
