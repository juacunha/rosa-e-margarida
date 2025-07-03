extends Control

signal change_scene()

@onready var hover = $hover
@onready var click = $click

func _on_menu_pressed():
	click.play()
	change_scene.emit("Menu")

func _on_sair_pressed():
	click.play()
	get_tree().quit()

func _on_menu_mouse_entered():
	hover.play()

func _on_sair_mouse_entered():
	hover.play()
