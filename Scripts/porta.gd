extends Node2D
class_name Door

# Script responsável pelo objeto porta. 
# A Porta será filha de uma SALA, que será responsável por coordenar suas obrigações
#
# Obrigações da Porta:
# A porta deve funcionar só em caso de ser concedida a permissão para tal 
# A porta deve informar a sua Sala quando a porta for aberta
# A porta deve animar após a interação do jogador
#
# O que a porta não faz:
# Não armazena a próxima sala. A Sala é responsável por isso.
# Não bloqueia o jogador. A Main é responsável por isso.
# Não troca a cena. A Main é responsável por isso.

# Referência aos Ns filhos
@onready var area_2d: Area2D = $Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Exportações
@export var animations: SpriteFrames # Passe as animações da porta. Elas devem ter o nome 'idle' e 'opening'
@export var estado_inicial: bool = true # Se passado como falso a porta não irá detectar o jogador assim que surgir. Dessa forma, é necessário chamar o método 'enable_door()' para ativar a detecção da porta.

# Sinal para avisar a Sala que houve uma interação válida com o jogador
signal door_opened(dono)

# Função ready para definir estado inicial da Porta
func _ready() -> void:
	# Monitoramento inicial
	area_2d.monitoring = estado_inicial
	area_2d.monitorable = estado_inicial
	# Animação Inicial
	animated_sprite_2d.sprite_frames = animations
	animated_sprite_2d.play("idle")

# Função para ativar a detecção da porta
func enable_door() -> void:
	area_2d.monitoring = true
	area_2d.monitorable = true

# Callback para quando houver uma interação válida do jogador com a porta
func interact(_dono) -> void:
	# Animação de abertura
	animated_sprite_2d.play("opening")
	# Aviso para a Sala que a porta está sendo aberta
	door_opened.emit(self)
	

# Funções para detectar a presença do jogador
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.interaction.connect(interact)
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.interaction.disconnect(interact)


#func change_room() -> void:
#	TransitionScreen.transition()
#	await  TransitionScreen.on_transition_finished
#	door_opened.emit(self, next_room)
#
