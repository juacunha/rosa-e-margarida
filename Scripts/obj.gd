extends StaticBody2D
class_name InteractableObject

@export_category("Informações")
@export var dialog: CompleteDialogData
@export var letter: CompressedTexture2D = null
@export var can_be_interacted: bool = true
@export var timer_animacao_brilho: float = 6.0
@export_range(0, 3) var photo_index: int = 0
#Aqui também terá que ser inserido as informações de cartas e fotos



@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

var already_interacted = false

signal interacted(data, dono)

func _ready() -> void:
	timer.wait_time = timer_animacao_brilho

func get_dialog() -> CompleteDialogData:
	if can_be_interacted:
		return dialog
	return null

func interact(_dono) -> void:
	interacted.emit(dialog, self)
	already_interacted = true
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.interaction.connect(interact)
		print("obj conectado")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.interaction.disconnect(interact)


func _on_timer_timeout() -> void:
	if can_be_interacted and not already_interacted:
		animated_sprite_2d.play("shine")
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.play("idle")
		
