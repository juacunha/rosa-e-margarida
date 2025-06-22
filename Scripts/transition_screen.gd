extends CanvasLayer

# Esse script é responsável por gerenciar a transição de tela.
# Em resumo ele apenas muda a visibilidade ed um ColorRect para dar um efeito de fade in e fade out

# Sinal para avisar que a transição acabou
signal on_transition_finished

# Referência aos nós da cena
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Função ready, torna o color rect invisivel e conecta o sinal de fim da animacao do animation player
func _ready() -> void:
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)

# Decide qual animação deve iniciar de acordo com a que acabou.
# Se estava tocando a fade to black, comece a animacao fade to normal e emite o sinal de fim da transição
# Dessa forma, a cena Main irá saber quando deve trocar a cena
func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		on_transition_finished.emit()
		animation_player.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		color_rect.visible = false

# Função que inicia a transição
func transition():
	color_rect.visible = true
	animation_player.play("fade_to_black")	
