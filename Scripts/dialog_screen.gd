extends Control
class_name  DialogScreen

var _step: float = 0.05
var _id: int = 0
var data: CompleteDialogData

signal dialog_finished()

@onready var _faceset: TextureRect = $Background/HContainer/Border/Faceset
@onready var _name: Label = $Background/HContainer/VContainer/Name
@onready var _dialog: RichTextLabel = $Background/HContainer/VContainer/Dialog

func _ready() -> void:
	_initialize_dialog()

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_accept") and _dialog.visible_ratio < 1:
		_step = 0.005
		return
	_step = 0.05
	if Input.is_action_just_pressed("ui_accept"):
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
	
	_dialog.visible_characters = 0
	while _dialog.visible_ratio < 1:
		await get_tree().create_timer(_step).timeout
		_dialog.visible_characters += 1
		pass
