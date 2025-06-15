extends Control

signal change_scene(scene: String)


func _on_iniciar_2_pressed() -> void:
	change_scene.emit("Quarto")
	queue_free()
