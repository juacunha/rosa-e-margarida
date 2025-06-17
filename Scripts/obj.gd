extends StaticBody2D
class_name InteractableObject

@export_category("Informações")
@export var dialog: CompleteDialogData

#Aqui também terá que ser inserido as informações de cartas e fotos


func get_dialog() -> CompleteDialogData:
	return dialog
