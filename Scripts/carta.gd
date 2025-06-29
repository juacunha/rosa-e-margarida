extends Control
class_name Letter

@export var letter_image: CompressedTexture2D
@onready var imagem_carta: TextureRect = $ImagemCarta

signal letter_closed()

func _ready() -> void:
	imagem_carta.texture = letter_image

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("esc"):
		close_letter()

func close_letter() -> void:
	queue_free()
	letter_closed.emit()
