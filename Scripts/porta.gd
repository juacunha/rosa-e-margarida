extends Node2D
class_name Door
@onready var area_2d: Area2D = $Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@export var next_room: PackedScene

@export_category("Animações")
@export var animations: SpriteFrames

signal door_opened(dono, next_room_scene)

func _ready() -> void:
	#area_2d.monitoring = false
	#area_2d.monitorable = false
	animated_sprite_2d.sprite_frames = animations
	animated_sprite_2d.play("idle")

func enable_door() -> void:
	area_2d.monitoring = true
	area_2d.monitorable = true

func interact(_dono) -> void:
	animated_sprite_2d.play("opening")
	_dono.playable(false)
	await animated_sprite_2d.animation_finished
	change_room()
	#animated_sprite_2d.sprite_frames = opening
	

func change_room() -> void:
	TransitionScreen.transition()
	await  TransitionScreen.on_transition_finished
	door_opened.emit(self, next_room)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.interaction.connect(interact)
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.interaction.disconnect(interact)
