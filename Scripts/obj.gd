extends StaticBody2D
class_name InteractableObject

@export_category("Informações")
@export var dialog: CompleteDialogData
@export var can_be_interacted: bool = true
#Aqui também terá que ser inserido as informações de cartas e fotos

signal interacted(data, dono)

func get_dialog() -> CompleteDialogData:
	if can_be_interacted:
		return dialog
	return null

func interact(_dono) -> void:
	interacted.emit(dialog, self)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.interaction.connect(interact)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.interaction.disconnect(interact)
