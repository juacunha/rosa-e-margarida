extends CharacterBody2D
class_name Player

@export var speed: float = 50.0 

@onready var camera_2d = $Camera2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var buttons = $Buttons
@onready var tempo_tab: Timer = $TempoTab
@onready var footstep_sounds = [
	load("res://Sfx/passos_madeira/0.ogg"),
	load("res://Sfx/passos_madeira/1.ogg"),
	load("res://Sfx/passos_madeira/2.ogg"),
	load("res://Sfx/passos_madeira/3.ogg"),
	load("res://Sfx/passos_madeira/4.ogg"),
	load("res://Sfx/passos_madeira/5.ogg"),
	load("res://Sfx/passos_madeira/6.ogg"),
	load("res://Sfx/passos_madeira/7.ogg"),
	load("res://Sfx/passos_madeira/0.ogg"),
]

signal interaction(dono)
signal open_album()

var can_interact = true
var idle_direcao = "idle_right"
var can_be_played = true

var area_atual: Area2D = null

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	if direction and can_be_played:
		velocity = direction * speed
		if direction.x > 0: # Movendo direita
			animated_sprite_2d.play("walk_right")
			idle_direcao = "idle_right"
		elif direction.x < 0: # Movendo esquerda
			animated_sprite_2d.play("walk_left")
			idle_direcao = "idle_left"
		elif direction.y < 0: # Movendo para cima
			animated_sprite_2d.play("walk_up")
			idle_direcao = "idle_up"
		elif direction.y > 0: # Movendo para baixo
			animated_sprite_2d.play("walk_down")
			idle_direcao = "idle_down"
	else:
		velocity = Vector2.ZERO
		animated_sprite_2d.play(idle_direcao)
	
	
	
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact and can_be_played:
		interaction.emit(self)
		print("emissao interaction")
	if Input.is_action_just_pressed("open_album") or Input.is_action_just_pressed("esc"):
		open_album.emit()
	

func playable(order: bool) -> void:
	can_be_played = order

func show_tab_tooltip() -> void:
	tempo_tab.start()
	buttons.play("Press tab")
	buttons.show()
	await tempo_tab.timeout
	buttons.hide()
	

# Corpo Interagivel Entrou
func _on_interactable_area_body_entered(body: Node2D) -> void:
	pass


# Corpo Interagivel Saiu
func _on_interactable_area_body_exited(body: Node2D) -> void:
	# Desconectar com o corpo
	pass # Replace with function body.

# Corpo Interagivel Entrou
func _on_interactable_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is InteractableObject or area.get_parent() is Door:
		buttons.show()
		buttons.play("Press e")
	

# Corpo Interagivel Saiu
func _on_interactable_area_area_exited(area: Area2D) -> void:
	if area.get_parent() is InteractableObject or area.get_parent() is Door:
		buttons.hide()
	
