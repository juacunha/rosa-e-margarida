extends Control
class_name  DialogScreen

var _step: float = 0.05
var _id: int = 0
var data: CompleteDialogData

signal dialog_finished()

@onready var _faceset: TextureRect = $Background/HContainer/Border/Faceset
@onready var _name: Label = $Background/HContainer/VContainer/Name
@onready var _dialog: RichTextLabel = $Background/HContainer/VContainer/Dialog

var skip = false

func _ready() -> void:
	_initialize_dialog()

func _process(_delta: float) -> void:
	if ((Input.is_action_just_pressed("ui_accept")) or Input.is_action_just_pressed("left_mouse")) and _dialog.visible_ratio < 1:
		#_step = 0.00000001
		_dialog.set_visible_characters(-1)
		skip = true
		return
	
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("left_mouse"):
		_id += 1
		if _id == data.complete_dialog.size():
			queue_free()
			dialog_finished.emit()
			return
		_initialize_dialog()
		
	

func _initialize_dialog() -> void:
	_name.text = data.complete_dialog[_id].locutor # Nome do npc
	_dialog.text = data.complete_dialog[_id].dialog
	_faceset.texture = load(data.complete_dialog[_id].faceset_path)
	_faceset.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_faceset.stretch_mode = TextureRect.STRETCH_SCALE
	_faceset.custom_minimum_size = Vector2(160, 160) # Tamanho desejado
	_dialog.set_visible_characters(0)
	skip = false
	


func _on_timer_timeout() -> void:
	if not skip:
		_dialog.visible_characters += 1
