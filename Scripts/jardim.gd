extends Sala # O Quarto é uma Sala.

# Referência aos Nós filhos
@onready var porta_sala: Door = $Portas/PortaSala
@onready var sala: Marker2D = $Surgimentos/Sala
@onready var objetos_interagiveis: Node2D = $ObjetosInteragiveis


signal change_scene(scene: String)

func _ready() -> void:
	porta_sala.door_opened.connect(change_scene_func)

func change_scene_func(dono) -> void:
	if porta_sala == dono:
		change_scene.emit("Sala")

	
# Função para inserir o jogador na posição correta
func move_player(last_room: String, player: Player) -> void:
	if last_room == "Sala":
		player.global_position = sala.global_position
func get_obj():
	return objetos_interagiveis.get_children()
