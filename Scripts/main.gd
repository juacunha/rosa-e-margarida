extends Node2D

const MENU = preload("res://Screens/menu.tscn")
const PAUSE = preload("res://Screens/pause.tscn")
const HUD = preload("res://Screens/hud.tscn")
const PLAYER = preload("res://Scenes/player.tscn")

@onready var cenas: Node2D = $Cenas

var LAST_ROOM: String
var player: Player


func _ready() -> void:
	var menu = MENU.instantiate()
	cenas.add_child(menu)
	menu.change_scene.connect(change_scene)
	


func change_scene(new_scene: PackedScene) -> void:
	if new_scene:
		print("oi")
	TransitionScreen.transition()
	await  TransitionScreen.on_transition_finished
	
	var new = new_scene.instantiate()
	cenas.add_child(new)
	new.change_scene.connect(change_scene)
	
	if new is Sala:
		if not LAST_ROOM:
			LAST_ROOM = "Inicial"
			player = PLAYER.instantiate()
			add_child(player)
		new.move_player(LAST_ROOM, player)
		LAST_ROOM = new.name
	
	
