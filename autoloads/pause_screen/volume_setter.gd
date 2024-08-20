@tool
extends HBoxContainer


const STEP_SIZE := 10  # percent

@export_enum("Master", "Music", "SFX") var bus_name := 0:
	set(value):
		bus_name = value
		if is_inside_tree():
			match bus_name:
				0:
					$Name.text = "Master Volume"
				1:
					$Name.text = "Music Volume"
				2:
					$Name.text = "SFX Volume"

@export var volume_in_percent := 80:
	set(value):
		volume_in_percent = clamp(value, 0, 100)
		if is_inside_tree():
			var volume_in_db := linear_to_db(volume_in_percent / 100.0)
			AudioServer.set_bus_volume_db(bus_name, volume_in_db)
			$Decrease.disabled = (volume_in_percent == 0)
			$Value.text = str(volume_in_percent) + "%"
			$Increase.disabled = (volume_in_percent == 100)


func _enter_tree() -> void:
	# trigger setters manually
	bus_name = bus_name
	volume_in_percent = volume_in_percent


func _on_decrease_pressed() -> void:
	volume_in_percent -= STEP_SIZE


func _on_increase_pressed() -> void:
	volume_in_percent += STEP_SIZE
