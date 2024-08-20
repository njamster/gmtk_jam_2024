extends Node

var muffle_tween : Tween

var muffle_music := false:
	set(value):
		muffle_music = value
		if is_inside_tree():
			if muffle_tween:
				muffle_tween.kill()
			muffle_tween = create_tween()
			if muffle_music:
				muffle_tween.tween_property(
					AudioServer.get_bus_effect(1, 0), "cutoff_hz", 300, 0.8
				).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
			else:
				muffle_tween.tween_property(
					AudioServer.get_bus_effect(1, 0), "cutoff_hz", 20500, 0.8
				).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)


func fade_in_music(fade_in_duration := 3.0) -> void:
	$MusicPlayer.volume_db = -80
	$MusicPlayer.play()
	var tween = create_tween()
	tween.tween_property(
		$MusicPlayer, "volume_db", 0, fade_in_duration
	).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)


func play_sound(sound_stream: AudioStream) -> void:
	var player := AudioStreamPlayer.new()
	player.finished.connect(player.queue_free)
	player.stream = sound_stream
	player.autoplay = true
	player.bus = "SFX"
	$Sounds.add_child(player)
