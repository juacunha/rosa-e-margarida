extends Node

var current_music: AudioStreamPlayer
var current_music_path: String = ""
var fade_tweens: Dictionary = {}  # Armazena tweens por instância
var is_transitioning: bool = false  # Controla estado de transição
var persistent_music: bool = false  # Se true, não interrompe música entre certas cenas

func play_music(music_path: String, volume_db: float = 0.0, fade_duration: float = 0.0, force_restart: bool = false) -> void:
	# Se já está tocando a mesma música e não for para forçar reinício
	if current_music_path == music_path and current_music and current_music.playing and not force_restart:
		return
	
	# Se já está em transição, cancela
	if is_transitioning:
		return
	
	is_transitioning = true
	
	# Para música atual com fade
	if current_music and current_music.playing:
		_stop_current_music(fade_duration)
		if fade_duration > 0:
			await get_tree().create_timer(fade_duration).timeout
	
	# Cria nova instância
	var new_music = AudioStreamPlayer.new()
	add_child(new_music)
	new_music.stream = load(music_path)
	new_music.bus = "Music"
	
	# Configura volume inicial
	if fade_duration > 0:
		new_music.volume_db = -80.0  # Começa silencioso
	else:
		new_music.volume_db = volume_db
	
	new_music.play()
	
	# Aplica fade in se necessário
	if fade_duration > 0:
		var tween = create_tween()
		tween.tween_property(new_music, "volume_db", volume_db, fade_duration)
		fade_tweens[new_music] = tween
	
	# Atualiza referências
	if current_music and is_instance_valid(current_music):
		current_music.queue_free()
	
	current_music = new_music
	current_music_path = music_path
	current_music.finished.connect(_on_music_finished.bind(new_music))
	
	is_transitioning = false

func _stop_current_music(fade_duration: float = 0.0) -> void:
	if not current_music or is_transitioning:
		return
	
	# Cancela qualquer fade existente nesta música
	if fade_tweens.has(current_music):
		var tween = fade_tweens[current_music]
		if tween and tween.is_running():
			tween.kill()
		fade_tweens.erase(current_music)
	
	if fade_duration > 0 and persistent_music == false:
		is_transitioning = true
		var tween = create_tween()
		tween.tween_property(current_music, "volume_db", -40.0, fade_duration)
		tween.tween_callback(_destroy_music_instance.bind(current_music))
		fade_tweens[current_music] = tween
	else:
		_destroy_music_instance(current_music)

func transition_music(new_music: String, volume_db: float, fade_out: float, fade_in: float, force_restart: bool = false) -> void:
	if is_transitioning:
		return
	
	if current_music and current_music_path == new_music and not force_restart:
		return  # Já está tocando a música solicitada
	
	if current_music and persistent_music == false:
		_stop_current_music(fade_out)
		if fade_out > 0:
			await get_tree().create_timer(fade_out).timeout
	
	play_music(new_music, volume_db, fade_in)

func _destroy_music_instance(instance: AudioStreamPlayer) -> void:
	if instance and is_instance_valid(instance):
		if instance.playing:
			instance.stop()
		instance.queue_free()
	
	if current_music == instance:
		current_music = null
		current_music_path = ""
	is_transitioning = false

func stop_music(fade_duration: float = 0.0) -> void:
	_stop_current_music(fade_duration)

func _on_music_finished(player: AudioStreamPlayer) -> void:
	player.play()  # Loop automático

func set_persistent_music(value: bool) -> void:
	persistent_music = value
