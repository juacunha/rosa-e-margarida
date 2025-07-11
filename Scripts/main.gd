extends Node2D

const MENU = preload("res://Screens/menu.tscn")
const PAUSE = preload("res://Screens/pause.tscn")
#const HUD = preload("res://Screens/hud.tscn")

const PLAYER = preload("res://Scenes/player.tscn")

const CREDITOS = preload("res://Screens/creditos.tscn")
const BANHEIRO = preload("res://Scenes/banheiro.tscn")
const SALA = preload("res://Scenes/sala_cozinha.tscn")
const QUARTO = preload("res://Scenes/quarto.tscn")
const JARDIM = preload("res://Scenes/jardim.tscn")
@onready var cenas: Node2D = $Cenas
@onready var hud: Hud = $Hud

var LAST_ROOM: String
var CURRENT_ROOM: String
var player: Player

@export_category("Dialogos")
@export var dialogo_inicial: CompleteDialogData
@export var carta_inicial: CompressedTexture2D
func _ready() -> void:
	var menu = MENU.instantiate()
	cenas.add_child(menu)
	menu.change_scene.connect(change_scene)
	hud.finish_game.connect(change_scene)
	hud.change_menu.connect(change_scene)

func _create_dialog(data: CompleteDialogData) -> void:
	hud._create_dialog_screen(data)
	
func change_scene(new_scene: String) -> void:
	if player:
		player.playable(false)
	TransitionScreen.transition()
	await  TransitionScreen.on_transition_finished
	var new
	if new_scene == "Quarto":
		new = QUARTO.instantiate()
		CURRENT_ROOM = "Quarto"
		Input.mouse_mode =  Input.MOUSE_MODE_CAPTURED
	elif new_scene == "Banheiro":
		new = BANHEIRO.instantiate()
		CURRENT_ROOM = "Banheiro"
		Input.mouse_mode =  Input.MOUSE_MODE_CAPTURED
	elif new_scene == "Sala":
		new = SALA.instantiate()
		CURRENT_ROOM = "Sala"
		Input.mouse_mode =  Input.MOUSE_MODE_CAPTURED
	elif new_scene == "Jardim":
		new = JARDIM.instantiate()
		CURRENT_ROOM = "Jardim"
		Input.mouse_mode =  Input.MOUSE_MODE_CAPTURED
	elif new_scene == "Menu":
		new = MENU.instantiate()
		CURRENT_ROOM = "Menu"
		Input.mouse_mode =  Input.MOUSE_MODE_VISIBLE
		if player:
			player.queue_free()
			hud.hide()
	elif new_scene == "Creditos":
		new = CREDITOS.instantiate()
		CURRENT_ROOM = "Creditos"
		Input.mouse_mode =  Input.MOUSE_MODE_VISIBLE
		player.queue_free()
	
	
	for i in cenas.get_children():
		i.queue_free()
	
	cenas.add_child(new)
	new.change_scene.connect(change_scene)
	
	print(LAST_ROOM)
	if new is Sala:
		if not LAST_ROOM or LAST_ROOM == "Menu":
			LAST_ROOM = "Inicial"
			player = PLAYER.instantiate()
			add_child(player)
			player.playable(true)
			player.open_album.connect(abrir_album)
			object_interaction(dialogo_inicial, null, carta_inicial)
			
		else:
			player.playable(true)
		connect_to_objects(new)
		new.move_player(LAST_ROOM, player)
	LAST_ROOM = new.name

func abrir_album():
	if hud.get_album_visibility():
		Input.mouse_mode =  Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode =  Input.MOUSE_MODE_VISIBLE
	hud.open_album()

func connect_to_objects(scene) -> void:
	var objs = scene.get_obj()
	for obj in objs:
		if obj is InteractableObject:
			obj.interacted.connect(object_interaction)

func object_interaction(data: CompleteDialogData, dono: InteractableObject, first_letter: CompressedTexture2D = null) -> void:
	player.playable(false)
	if (dono and dono.letter):
		hud.new_letter(dono.letter)
		await hud.letter_ended
	elif first_letter:
		hud.new_letter(first_letter)
		await hud.letter_ended
		
		
	hud._create_dialog_screen(data)
	await hud.dialog_ended
	if first_letter:
		player.show_tab_tooltip()
	if dono:
		hud.new_photo(dono.photo_index)
	player.playable(true)
	
