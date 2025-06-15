extends Node2D

const MENU = preload("res://Screens/menu.tscn")
const PAUSE = preload("res://Screens/pause.tscn")
const HUD = preload("res://Screens/hud.tscn")

const PLAYER = preload("res://Scenes/player.tscn")

const BANHEIRO = preload("res://Scenes/banheiro.tscn")
const SALA = preload("res://Scenes/sala_cozinha.tscn")
const QUARTO = preload("res://Scenes/quarto.tscn")
const JARDIM = preload("res://Scenes/jardim.tscn")
@onready var cenas: Node2D = $Cenas

var LAST_ROOM: String
var player: Player


func _ready() -> void:
	var menu = MENU.instantiate()
	cenas.add_child(menu)
	menu.change_scene.connect(change_scene)
	


func change_scene(new_scene: String) -> void:
	if player:
		player.playable(false)
	TransitionScreen.transition()
	await  TransitionScreen.on_transition_finished
	
	var new
	if new_scene == "Quarto":
		new = QUARTO.instantiate()
	elif new_scene == "Banheiro":
		new = BANHEIRO.instantiate()
	elif new_scene == "Sala":
		new = SALA.instantiate()
	elif new_scene == "Jardim":
		new = JARDIM.instantiate()
	elif new_scene == "Menu":
		new = MENU.instantiate()
	
	for i in cenas.get_children():
		i.queue_free()
	
	cenas.add_child(new)
	new.change_scene.connect(change_scene)
	
	if new is Sala:
		if not LAST_ROOM:
			LAST_ROOM = "Inicial"
			player = PLAYER.instantiate()
			add_child(player)
		new.move_player(LAST_ROOM, player)
		player.playable(true)
		LAST_ROOM = new.name
	
	
