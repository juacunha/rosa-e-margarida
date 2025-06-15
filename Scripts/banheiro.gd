extends Sala

# Referência aos Nós filhos
@onready var porta_quarto: Door = $Portas/PortaQuarto
@onready var surgimento_quarto: Marker2D = $Surgimentos/Quarto


# Categoria de Proximas cenas
@export_category("Próximas Cenas")
@export var quarto: 	PackedScene


signal change_scene(scene: PackedScene)

func _ready() -> void:
	porta_quarto.door_opened.connect(change_scene_func)
	
func change_scene_func(dono) -> void:
	if porta_quarto == dono:
		change_scene.emit(quarto)

# Função para inserir o jogador na posição correta
func move_player(last_room: String, player: Player) -> void:
	if last_room == "Quarto":
		player.global_position = surgimento_quarto.global_position
		
