extends Node2D

@onready var quarto: Marker2D = $Surgimento/Quarto


func move_player(last_room: String, player: Player) -> void:
	if last_room == "Quarto":
		player.global_position = quarto.global_position
