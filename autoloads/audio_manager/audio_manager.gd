extends Node


func play_sound(sound_stream: AudioStream) -> void:
	var player := AudioStreamPlayer.new()
	player.finished.connect(player.queue_free)
	player.stream = sound_stream
	player.autoplay = true
	player.bus = "SFX"
	$Sounds.add_child(player)
