extends Sala # O Quarto é uma Sala.

# Referência aos Nós filhos
@onready var porta_quarto: Door = $Portas/PortaQuarto
@onready var porta_jardim: Door = $Portas/PortaJardim
@onready var quarto: Marker2D = $Surgimento/Quarto
@onready var jardim: Marker2D = $Surgimento/Jardim



signal change_scene(scene: String)

func _ready() -> void:
	porta_quarto.door_opened.connect(change_scene_func)
	porta_jardim.door_opened.connect(change_scene_func)

func change_scene_func(dono) -> void:
	if porta_quarto == dono:
		change_scene.emit("Quarto")
	elif porta_jardim == dono:
		change_scene.emit("Jardim")
	
# Função para inserir o jogador na posição correta
func move_player(last_room: String, player: Player) -> void:
	if last_room == "Quarto":
		player.global_position = quarto.global_position
	elif last_room == "Jardim":
		player.global_position = jardim.global_position
