extends Sala # A Sala Cozinha é uma Sala.

# Referência aos Nós filhos
@onready var porta_quarto: Door = $Portas/PortaQuarto
@onready var porta_jardim: Door = $Portas/PortaJardim
@onready var quarto: Marker2D = $Surgimento/Quarto
@onready var jardim: Marker2D = $Surgimento/Jardim
@onready var objetos_interagiveis: Node2D = $ObjetosInteragiveis

var music_initialized: bool = false

# Sinal para avisar que pode trocar de cena, pois uma porta foi interagida
signal change_scene(scene: String)

# Conecta com os nós das portas, para saber quando elas forem interagidas
func _ready() -> void:
	porta_quarto.door_opened.connect(change_scene_func)
	porta_jardim.door_opened.connect(change_scene_func)

	#Só toca a música se não estiver já tocando ou se for reinício
	if not music_initialized:
		AudioManager.set_persistent_music(true)
		AudioManager.transition_music("res://Sfx/Songs/SO SAD MEU DEUS.mp3", -10.0, 0.0, 2.0)
		music_initialized = true
		
# Função que emite o sinal de troca de cena de acordo com a porta que foi interagida
func change_scene_func(dono) -> void:
	if porta_quarto == dono:
		AudioManager.set_persistent_music(false)
		change_scene.emit("Quarto")
	elif porta_jardim == dono:
		#Quando vai para o jardim, marca para não reininciar musica ao voltar
		AudioManager.set_persistent_music(true)
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
