extends CanvasLayer
class_name Hud

const DIALOG_SCREEN = preload("res://Screens/dialog_screen.tscn")

signal dialog_ended()
	
func _create_dialog_screen(data: CompleteDialogData) -> void:
	var ds = DIALOG_SCREEN.instantiate()
	ds.data = data
	add_child(ds)
	await ds.dialog_finished
	dialog_ended.emit()
