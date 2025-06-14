extends Node2D

const MENU = preload("res://Screens/menu.tscn")
const PAUSE = preload("res://Screens/pause.tscn")
const HUD = preload("res://Screens/hud.tscn")
@onready var cenas: Node2D = $Cenas

func _ready() -> void:
	var menu = MENU.instantiate()
	cenas.add_child(menu)
	menu.change_scene.connect(change_scene)


func change_scene(new_scene: PackedScene) -> void:
	var new = new_scene.instantiate()
	cenas.add_child(new)
