extends Control

signal change_scene()

@onready var hover = $hover
@onready var click = $click
@onready var petala_1 = $"petala/petala 1"
@onready var petala_2 = $"petala 2/petala 2"

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

func _on_animation_player_animation_finished(zoom):
	petala_1.play("petala caindo")
	petala_2.play("caindo")
