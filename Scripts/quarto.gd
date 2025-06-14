extends Node2D

@onready var banheiro: Marker2D = $Surgimentos/Banheiro

# Adicionar aqui lógica para inserir o jogador na posição correta
func move_player(last_room: String, player: Player) -> void:
	if last_room == "Banheiro":
		player.global_position = banheiro.global_position
