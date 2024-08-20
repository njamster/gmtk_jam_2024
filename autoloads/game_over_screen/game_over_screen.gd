extends CanvasLayer


var highest_weight := 0


func _ready() -> void:
	self.hide()
	self.process_mode = Node.PROCESS_MODE_ALWAYS


func open() -> void:
	get_tree().paused = true
	AudioManager.muffle_music = true
	%HighestWeight.text = str(highest_weight) + " kg"
	self.show()


func close() -> void:
	self.hide()
	AudioManager.muffle_music = false
	get_tree().paused = false


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	highest_weight = 0
	self.close()


func _input(event: InputEvent) -> void:
	Global._input(event)
