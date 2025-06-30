extends Control
class_name Letter

@export var letter_image: CompressedTexture2D
@onready var imagem_carta: TextureRect = $ImagemCarta
@onready var abrindo = $abrindo

signal letter_closed()

func _ready() -> void:
	imagem_carta.texture = letter_image
	abrindo.play()
	#imagem_carta.scale = Vector2(1.2, 1.2)
	#imagem_carta.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	#var screen_size = get_viewport_rect().size
	#imagem_carta.position = screen_size / 3

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("esc"):
		close_letter()

func close_letter() -> void:
	queue_free()
	letter_closed.emit()
