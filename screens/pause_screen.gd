extends CanvasLayer


func _enter_tree() -> void:
	self.hide()
	self.process_mode = Node.PROCESS_MODE_ALWAYS


func open() -> void:
	get_tree().paused = true
	%Resume.grab_focus()
	self.show()


func close() -> void:
	self.hide()
	get_tree().paused = false


func _on_resume_pressed() -> void:
	self.close()
