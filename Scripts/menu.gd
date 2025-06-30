extends Control

signal change_scene(scene: String)

@onready var ost_sound: AudioStreamPlayer = $"menu_ost"

var is_transitioning: bool = false  # Controla se já está em transição

func _ready()-> void:
	ost_sound.volume_db = -20
	ost_sound.play()
	
	var tween := create_tween()
	tween.tween_property(ost_sound, "volume_db", -5, 4.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _on_iniciar_2_pressed() -> void:
	# Evita múltiplos cliques durante a transição
	if is_transitioning:
		return
	is_transitioning = true
	
	# Cria fade out suave
	var fade_out_tween := create_tween()
	fade_out_tween.tween_property(ost_sound, "volume_db", -0.0, 2.0) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	
	# Espera o fade out terminar antes de mudar de cena
	await fade_out_tween.finished
	# Emite o sinal para mudar de cena
	change_scene.emit("Quarto")
	# Libera a cena atual
	queue_free()

func _on_sair_pressed() -> void:
	 # Fade out da música antes de sair
	
	var fade_out_tween := create_tween()
	fade_out_tween.tween_property(ost_sound, "volume_db", -40.0, 1.0) \
	.set_trans(Tween.TRANS_SINE) \
	.set_ease(Tween.EASE_IN_OUT)
	
	await fade_out_tween.finished
	get_tree().quit() 

#Garante que a música pare se a cena for destruída abruptamente
func _exit_tree():
	if ost_sound.playing:
		ost_sound.stop()
