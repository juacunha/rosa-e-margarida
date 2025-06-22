extends Node2D
class_name Door

@onready var area_2d: Area2D = $Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_player: AudioStreamPlayer2D = $SFX_Porta

@export var next_room: PackedScene
var current_interacting_body: Node2D = null

@export_category("Animações")
@export var animations: SpriteFrames

@export_category("Sons")
@export var door_open_sound: AudioStream

signal door_opened(dono, next_room_scene)

func _ready() -> void:
	animated_sprite_2d.sprite_frames = animations
	animated_sprite_2d.play("idle")
	audio_player.finished.connect(_on_sfx_porta_finished)

	
func enable_door() -> void:
	area_2d.monitoring = true
	area_2d.monitorable = true

func interact(_dono) -> void:
	print("Interagindo com a porta") 
	current_interacting_body = _dono  # Guarda referência ao jogador
	animated_sprite_2d.play("opening")
	_dono.playable(false)
	
	if door_open_sound:
		print("Som da porta carregado:", door_open_sound.resource_path)
		audio_player.stream = door_open_sound
		audio_player.play()  
		await audio_player.finished  # Espera o som terminar
	else:
		print("AVISO: Nenhum som definido para a porta!")
	
	await animated_sprite_2d.animation_finished
	change_room()

func change_room() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	door_opened.emit(self, next_room)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.interaction.connect(interact)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player && body != current_interacting_body:  # Só desconecta se não for o jogador atual
		body.interaction.disconnect(interact)
	elif body == current_interacting_body:
		print("Aguardando término da interação...")


func _on_sfx_porta_finished() -> void:
	pass # Replace with function body.
