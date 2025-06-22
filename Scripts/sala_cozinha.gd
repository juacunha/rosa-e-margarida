extends Sala # A Sala Cozinha é uma Sala.

# Referência aos Nós filhos
@onready var porta_quarto: Door = $Portas/PortaQuarto
@onready var porta_jardim: Door = $Portas/PortaJardim
@onready var quarto: Marker2D = $Surgimento/Quarto
@onready var jardim: Marker2D = $Surgimento/Jardim
@onready var objetos_interagiveis: Node2D = $ObjetosInteragiveis

# Sinal para avisar que pode trocar de cena, pois uma porta foi interagida
signal change_scene(scene: String)

# Conecta com os nós das portas, para saber quando elas forem interagidas
func _ready() -> void:
	porta_quarto.door_opened.connect(change_scene_func)
	porta_jardim.door_opened.connect(change_scene_func)

# Função que emite o sinal de troca de cena de acordo com a porta que foi interagida
func change_scene_func(dono) -> void:
	if porta_quarto == dono:
		change_scene.emit("Quarto")
	elif porta_jardim == dono:
		change_scene.emit("Jardim")

# Função que retorna todos os objetos interagiveis
# Essa função é chamada pela Main para conseguir se conectar aos objetos e poder chamar as funções de dialogo, cartas e fotos
func get_obj():
	return objetos_interagiveis.get_children()
	
# Função para inserir o jogador na posição correta de acordo com a ultima sala que ele esteve
func move_player(last_room: String, player: Player) -> void:
	if last_room == "Quarto":
		player.global_position = quarto.global_position
	elif last_room == "Jardim":
		player.global_position = jardim.global_position
