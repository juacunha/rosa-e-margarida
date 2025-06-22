extends CanvasLayer
class_name Hud

const DIALOG_SCREEN = preload("res://Screens/dialog_screen.tscn")
@onready var album: Control = $Album

signal dialog_ended()
signal finish_game(scene: String)
var can_open_album = true

func _ready() -> void:
	album.album_full.connect(end_game)

func open_album() -> void:
	if get_album_visibility():
		album.hide()
		return
	if can_open_album:
		album.show()

func end_game() -> void:
	finish_game.emit("Creditos")

func get_album_visibility() -> bool:
	if album.is_visible_in_tree():
		return true
	return false

func new_photo(index: int) -> void:
	album.get_new_image(index)
	

func _create_dialog_screen(data: CompleteDialogData) -> void:
	var ds = DIALOG_SCREEN.instantiate()
	ds.data = data
	add_child(ds)
	can_open_album = false
	await ds.dialog_finished
	can_open_album = true
	dialog_ended.emit()
