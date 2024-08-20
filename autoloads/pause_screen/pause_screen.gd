extends CanvasLayer


const SETTINGS_PATH := "user://settings.cfg"

func _ready() -> void:
	self.hide()
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	_load_settings()


func open() -> void:
	get_tree().paused = true
	AudioManager.muffle_music = true
	%Resume.grab_focus()
	self.show()


func close() -> void:
	self.hide()
	AudioManager.muffle_music = false
	get_tree().paused = false
	_save_settings()


func _load_settings() -> void:
	if FileAccess.file_exists(SETTINGS_PATH):
		var settings := ConfigFile.new()
		settings.load(SETTINGS_PATH)
		%MasterVolume.volume_in_percent = settings.get_value("VOLUME", "master")
		%MusicVolume.volume_in_percent = settings.get_value("VOLUME", "music")
		%SFXVolume.volume_in_percent = settings.get_value("VOLUME", "sfx")


func _save_settings() -> void:
	var settings := ConfigFile.new()

	settings.set_value("VOLUME", "master", %MasterVolume.volume_in_percent)
	settings.set_value("VOLUME", "music", %MusicVolume.volume_in_percent)
	settings.set_value("VOLUME", "sfx", %SFXVolume.volume_in_percent)

	settings.save(SETTINGS_PATH)


func _on_resume_pressed() -> void:
	self.close()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	self.close()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_MOUSE_EXIT or what == NOTIFICATION_APPLICATION_FOCUS_OUT or \
		what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
			if get_tree().current_scene.name == "Game":
				self.open()


func _input(event: InputEvent) -> void:
	Global._input(event)
