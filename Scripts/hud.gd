extends CanvasLayer
class_name Hud

const CARTA = preload("res://Screens/carta.tscn")
const DIALOG_SCREEN = preload("res://Screens/dialog_screen.tscn")
@onready var album: Control = $Album
@onready var icon_album: Icon = $IconAlbum

signal dialog_ended()
signal letter_ended()
signal finish_game(scene: String)
signal change_menu(scene: String)
var can_open_album = true

func _ready() -> void:
	album.album_full.connect(end_game)
	album.sair.connect(go_to_menu)

func open_album() -> void:
	if get_album_visibility():
		album.hide()
		visibility_ui(true)
		return
	if can_open_album:
		album.show()
		visibility_ui(false)
		icon_album.read()

func end_game() -> void:
	finish_game.emit("Creditos")

func go_to_menu() -> void:
	change_menu.emit("Menu")
	queue_free()

func get_album_visibility() -> bool:
	if album.is_visible_in_tree():
		return true
	return false

func new_photo(index: int) -> void:
	album.get_new_image(index)
	icon_album.warning()
	
func _create_dialog_screen(data: CompleteDialogData) -> void:
	var ds = DIALOG_SCREEN.instantiate()
	ds.data = data
	add_child(ds)
	can_open_album = false
	await ds.dialog_finished
	can_open_album = true
	dialog_ended.emit()

func new_letter(image: CompressedTexture2D) -> void:
	var lt = CARTA.instantiate()
	lt.letter_image = image
	add_child(lt)
	can_open_album = false
	visibility_ui(false)
	await lt.letter_closed
	visibility_ui(true)
	can_open_album = true
	letter_ended.emit()

func visibility_ui(order: bool) -> void:
	if order:
		icon_album.show()
		return
	icon_album.hide()
