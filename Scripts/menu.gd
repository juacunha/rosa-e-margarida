extends Control

signal change_scene(scene: String)

@onready var ost_sound: AudioStreamPlayer = $"menu_ost"

func _ready()-> void:
	ost_sound.volume_db = -20
	ost_sound.play()
	
	var tween := create_tween()
	tween.tween_property(ost_sound, "volume_db", -10, 4.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _on_iniciar_2_pressed() -> void:
	change_scene.emit("Quarto")
	queue_free()
