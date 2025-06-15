extends Sala # O Quarto é uma Sala.

# Referência aos Nós filhos
@onready var porta_banheiro: 		Door 	 = $Portas/PortaBanheiro
@onready var porta_sala: 			Door 	 = $Portas/PortaSala
@onready var surgimento_banheiro: 	Marker2D = $Surgimentos/Banheiro
@onready var surgimento_sala: 		Marker2D = $Surgimentos/Sala
@onready var inicial: 				Marker2D = $Surgimentos/Inicial

# Categoria de Proximas cenas
@export_category("Próximas Cenas")
@export var banheiro: 	PackedScene
@export var sala: 		PackedScene

signal change_scene(scene: PackedScene)

func _ready() -> void:
	porta_banheiro.door_opened.connect(change_scene_func)
	porta_sala.door_opened.connect(change_scene_func)

func change_scene_func(dono) -> void:
	if porta_banheiro == dono:
		change_scene.emit(banheiro)
	elif porta_sala == dono:
		change_scene.emit(sala)
	
# Função para inserir o jogador na posição correta
func move_player(last_room: String, player: Player) -> void:
	if last_room == "Banheiro":
		player.global_position = surgimento_banheiro.global_position
	elif last_room == "Sala":
		player.global_position = surgimento_sala.global_position
	elif last_room == "Inicial":
		player.global_position = inicial.global_position
