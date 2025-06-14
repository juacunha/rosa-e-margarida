extends CharacterBody2D
class_name Player

@export var speed: float = 100.0 

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal interaction(dono)

var can_interact = false
var idle_direcao = "idle_right"
var can_be_played = true

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


func playable(order: bool) -> void:
	can_be_played = order

# Corpo Interagivel Entrou
func _on_interactable_area_body_entered(body: Node2D) -> void:
	# Conectar com o Corpo
	pass # Replace with function body.

# Corpo Interagivel Saiu
func _on_interactable_area_body_exited(body: Node2D) -> void:
	# Desconectar com o corpo
	pass # Replace with function body.

# Corpo Interagivel Entrou
func _on_interactable_area_area_entered(area: Area2D) -> void:
	can_interact = true
	print("can interact")
	pass # Replace with function body.

# Corpo Interagivel Saiu
func _on_interactable_area_area_exited(area: Area2D) -> void:
	can_interact = false
	pass # Replace with function body.
