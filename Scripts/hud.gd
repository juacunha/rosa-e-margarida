extends CanvasLayer
class_name Hud

const DIALOG_SCREEN = preload("res://Screens/dialog_screen.tscn")
@export var data: CompleteDialogData

func _ready() -> void:
	var ds = DIALOG_SCREEN.instantiate()
	ds.data = data
	add_child(ds)
