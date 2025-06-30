extends Sala # O Quarto é uma Sala.

# Referência aos Nós filhos
@onready var porta_banheiro: 		Door 	 = $Portas/PortaBanheiro
@onready var porta_sala: 			Door 	 = $Portas/PortaSala
@onready var surgimento_banheiro: 	Marker2D = $Surgimentos/Banheiro
@onready var surgimento_sala: 		Marker2D = $Surgimentos/Sala
@onready var inicial: 				Marker2D = $Surgimentos/Inicial
@onready var objetos_interagiveis: Node2D = $ObjetosInteragiveis



signal change_scene(scene: String)

func _ready() -> void:
	porta_banheiro.door_opened.connect(change_scene_func)
	porta_sala.door_opened.connect(change_scene_func)
	AudioManager.play_music("res://Sfx/Songs/melancholic happy-loopable.mp3", -10.0)

func get_obj():
	return objetos_interagiveis.get_children()

func change_scene_func(dono) -> void:
	if porta_banheiro == dono:
		change_scene.emit("Banheiro")
	elif porta_sala == dono:
		change_scene.emit("Sala")
	
# Função para inserir o jogador na posição correta
func move_player(last_room: String, player: Player) -> void:
	if last_room == "Banheiro":
		player.global_position = surgimento_banheiro.global_position
	elif last_room == "Sala":
		player.global_position = surgimento_sala.global_position
	elif last_room == "Inicial":
		player.global_position = inicial.global_position
