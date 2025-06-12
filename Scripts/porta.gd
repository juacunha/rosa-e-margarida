extends Node2D

@onready var area_2d: Area2D = $Area2D

@export var next_room: PackedScene

signal door_opened(dono, next_room_scene)

func _ready() -> void:
	area_2d.monitoring = false
	area_2d.monitorable = false

func enable_door() -> void:
	area_2d.monitoring = true
	area_2d.monitorable = true

func change_room() -> void:
	TransitionScreen.transition()
	await  TransitionScreen.on_transition_finished
	door_opened.emit(self, next_room)
