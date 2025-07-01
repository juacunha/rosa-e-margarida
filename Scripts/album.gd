extends Control

@onready var espaco_foto: TextureRect = $EspacoFoto
@onready var texto_foto: RichTextLabel = $TextoFoto
@onready var fotos: HBoxContainer = $Fotos
@onready var foto_1: TextureRect = $Fotos/Foto1
@onready var foto_2: TextureRect = $Fotos/Foto2
@onready var foto_3: TextureRect = $Fotos/Foto3
@onready var proximo: TextureButton = $Proximo
@onready var anterior: TextureButton = $Anterior
@onready var drag: TextureRect = $Drag
@onready var pages = $pages

@export_category("Fotos")
@export var image_1: CompressedTexture2D
@export var image_2: CompressedTexture2D
@export var image_3: CompressedTexture2D
@export var imagem_vazia: CompressedTexture2D


@export_category("Textos")
@export_multiline var text_1: String
@export_multiline var text_2: String
@export_multiline var text_3: String


var index_atual: int = 1
var images_inventory = {"Foto 1": false, "Foto 2": false, "Foto 3": false}
var album_inventory = {"Foto 1": false, "Foto 2": false, "Foto 3": false}
var dragging: int = 0
var drag_offset: Vector2 = Vector2.ZERO
var mouse_on_area: bool = false

signal album_full()

func _ready() -> void:
	foto_1.texture = imagem_vazia
	foto_2.texture = imagem_vazia
	foto_3.texture = imagem_vazia
	update_screen()

func _process(delta: float) -> void:
	if dragging == 1 and images_inventory["Foto 1"]:
		drag.global_position = get_global_mouse_position() - drag_offset
		drag.texture = image_1
		drag.show()
	elif dragging == 2 and images_inventory["Foto 2"]:
		drag.global_position = get_global_mouse_position() - drag_offset
		drag.texture = image_2
		drag.show()
	elif dragging == 3 and images_inventory["Foto 3"]:
		drag.global_position = get_global_mouse_position() - drag_offset
		drag.texture = image_3
		drag.show()
	else:
		drag.hide()
	

func update_screen() -> void:
	if index_atual == 1:
		if album_inventory["Foto 1"]:
			espaco_foto.texture = image_1
		else:
			espaco_foto.texture = imagem_vazia
		texto_foto.text = text_1
	elif index_atual == 2:
		if album_inventory["Foto 2"]:
			espaco_foto.texture = image_2
		else:
			espaco_foto.texture = imagem_vazia
		texto_foto.text = text_2
	elif index_atual == 3:
		if album_inventory["Foto 3"]:
			espaco_foto.texture = image_3
		else:
			espaco_foto.texture = imagem_vazia
		texto_foto.text = text_3

func previous_image() -> void:
	pages.play()
	index_atual -= 1
	if index_atual == 0:
		index_atual = 3
	update_screen()

func next_image() -> void:
	pages.play()
	index_atual += 1
	if index_atual == 4:
		index_atual = 1
	update_screen()


func get_new_image(index: int) -> void:
	if index == 1 and not album_inventory["Foto 1"]:
		foto_1.texture = image_1
		images_inventory["Foto 1"] = true
	elif index == 2 and not  album_inventory["Foto 2"]:
		foto_2.texture = image_2
		images_inventory["Foto 2"] = true
	elif index == 3 and not  album_inventory["Foto 3"]:
		foto_3.texture = image_3
		images_inventory["Foto 3"] = true
	
		

func _on_foto_1_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and images_inventory["Foto 1"]:
		# Se o botão foi pressionado, começamos o arrasto.
		if event.is_pressed():
			dragging = 1
			drag_offset = get_global_mouse_position() - foto_1.global_position
		# Se o botão foi solto, paramos o arrasto.
		else:
			released_dragged()

func _on_foto_2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and images_inventory["Foto 2"]:
		# Se o botão foi pressionado, começamos o arrasto.
		if event.is_pressed():
			dragging = 2
			drag_offset = get_global_mouse_position() - foto_2.global_position
		# Se o botão foi solto, paramos o arrasto.
		else:
			released_dragged()

func _on_foto_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and images_inventory["Foto 3"]:
		# Se o botão foi pressionado, começamos o arrasto.
		if event.is_pressed():
			dragging = 3
			drag_offset = get_global_mouse_position() - foto_3.global_position
		# Se o botão foi solto, paramos o arrasto.
		else:
			released_dragged()


func released_dragged() -> void:
	print(dragging, index_atual, mouse_on_area)
	if dragging == index_atual and mouse_on_area:
		match dragging:
			1:
				images_inventory["Foto 1"] = false
				album_inventory["Foto 1"] = true
				foto_1.texture = imagem_vazia
			2:
				images_inventory["Foto 2"] = false
				album_inventory["Foto 2"] = true
				foto_2.texture = imagem_vazia					
			3:
				images_inventory["Foto 3"] = false
				album_inventory["Foto 3"] = true
				foto_3.texture = imagem_vazia
		if is_album_full():
			album_full.emit()
			hide()
		dragging = 0
		update_screen()
		return
	dragging = 0
			

func _on_espaco_foto_mouse_entered() -> void:
	mouse_on_area = true
	print("enter")

func _on_espaco_foto_mouse_exited() -> void:
	mouse_on_area = false

func is_album_full() -> bool:
	for photo in album_inventory:
		
		if not album_inventory[photo]:
			return false
	return true

func _on_sair_pressed():
	get_tree().quit()

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Screens/menu.tscn")
