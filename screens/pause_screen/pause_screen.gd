extends CanvasLayer


const SETTINGS_PATH := "user://settings.cfg"

func _ready() -> void:
	self.hide()
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	_load_settings()


func open() -> void:
	get_tree().paused = true
	%Resume.grab_focus()
	self.show()


func close() -> void:
	self.hide()
	get_tree().paused = false
	_save_settings()


func _load_settings() -> void:
	if FileAccess.file_exists(SETTINGS_PATH):
		var settings := ConfigFile.new()
		settings.load(SETTINGS_PATH)
		%MasterVolume.volume_in_percent = settings.get_value("VOLUME", "master")
		%MasterVolume.is_muted = settings.get_value("VOLUME", "master_muted")

		%MusicVolume.volume_in_percent = settings.get_value("VOLUME", "music")
		%MusicVolume.is_muted = settings.get_value("VOLUME", "music_muted")

		%SFXVolume.volume_in_percent = settings.get_value("VOLUME", "sfx")
		%SFXVolume.is_muted = settings.get_value("VOLUME", "sfx_muted")


func _save_settings() -> void:
	var settings := ConfigFile.new()

	settings.set_value("VOLUME", "master", %MasterVolume.volume_in_percent)
	settings.set_value("VOLUME", "master_muted", %MasterVolume.is_muted)

	settings.set_value("VOLUME", "music", %MusicVolume.volume_in_percent)
	settings.set_value("VOLUME", "music_muted", %MusicVolume.is_muted)

	settings.set_value("VOLUME", "sfx", %SFXVolume.volume_in_percent)
	settings.set_value("VOLUME", "sfx_muted", %SFXVolume.is_muted)

	settings.save(SETTINGS_PATH)


func _on_resume_pressed() -> void:
	self.close()
