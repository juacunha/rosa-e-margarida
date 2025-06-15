extends Sala

# Referência aos Nós filhos
@onready var porta_quarto: Door = $Portas/PortaQuarto
@onready var surgimento_quarto: Marker2D = $Surgimentos/Quarto


signal change_scene(scene: String)

func _ready() -> void:
	porta_quarto.door_opened.connect(change_scene_func)
	
func change_scene_func(dono) -> void:
	if porta_quarto == dono:
		change_scene.emit("Quarto")

# Função para inserir o jogador na posição correta
func move_player(last_room: String, player: Player) -> void:
	if last_room == "Quarto":
		player.global_position = surgimento_quarto.global_position
		
