extends Control
class_name Icon

@onready var texture_rect: TextureRect = $TextureRect

@export var icon_idle: CompressedTexture2D
@export var icon_warning: CompressedTexture2D

func _ready() -> void:
	texture_rect.texture = icon_idle
func warning() -> void:
	texture_rect.texture = icon_warning

func read() -> void:
	texture_rect.texture = icon_idle
