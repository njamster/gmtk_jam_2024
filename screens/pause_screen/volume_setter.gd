@tool
extends HBoxContainer


const STEP_SIZE := 10  # percent

@export_enum("Master", "Music", "SFX") var bus_name := 0:
	set(value):
		bus_name = value
		if is_inside_tree():
			match bus_name:
				0:
					$Name.text = "Master"
				1:
					$Name.text = "Music"
				2:
					$Name.text = "SFX"
			volume_in_percent = roundi(db_to_linear(AudioServer.get_bus_volume_db(bus_name)) * 100)
			$Mute.button_pressed = AudioServer.is_bus_mute(bus_name)

@export var volume_in_percent := 100:
	set(value):
		volume_in_percent = clamp(value, 0, 100)
		if is_inside_tree():
			var volume_in_db := linear_to_db(volume_in_percent / 100.0)
			AudioServer.set_bus_volume_db(bus_name, volume_in_db)
			$Decrease.disabled = (volume_in_percent == 0)
			$Value.text = str(volume_in_percent) + "%"
			$Increase.disabled = (volume_in_percent == 100)

@export var is_muted := false:
	set(value):
		is_muted = value
		if is_inside_tree():
			AudioServer.set_bus_mute(bus_name, is_muted)
			$Mute.button_pressed = is_muted


func _enter_tree() -> void:
	# trigger setters manually
	bus_name = bus_name


func _on_decrease_pressed() -> void:
	volume_in_percent -= STEP_SIZE


func _on_increase_pressed() -> void:
	volume_in_percent += STEP_SIZE


func _on_mute_toggled(toggled_on: bool) -> void:
	is_muted = toggled_on
