extends Control

const QUARTO = preload("res://Scenes/quarto.tscn")

signal change_scene(scene: PackedScene)


func _on_iniciar_2_pressed() -> void:
	change_scene.emit(QUARTO)
	queue_free()
