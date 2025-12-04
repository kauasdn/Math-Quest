extends CanvasLayer

signal dialogo_finalizado

@onready var text_label = $Background/Panel/TextLabel
@onready var audio_player = $AudioPlayer 

@onready var som_padrao_bip = audio_player.stream

var linhas_de_dialogo: Array[String] = []
var lista_de_audios: Array[AudioStream] = []
var linha_atual: int = 0
var esta_digitando: bool = false
var velocidade_digitacao: float = 0.08

func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	$Background.visible = false

func iniciar(texto: Array[String], audios: Array[AudioStream] = []):
	linhas_de_dialogo = texto
	lista_de_audios = audios
	linha_atual = 0
	$Background.visible = true
	mostrar_texto_atual()

func mostrar_texto_atual():
	if linha_atual < linhas_de_dialogo.size():
		text_label.text = linhas_de_dialogo[linha_atual]
		text_label.visible_characters = 0
		digitar_texto()
	else:
		terminar_dialogo()

func digitar_texto():
	esta_digitando = true
	var total_caracteres = text_label.text.length()
	
	var tem_audio_especifico = false

	if linha_atual < lista_de_audios.size() and lista_de_audios[linha_atual] != null:
		print("TENTANDO TOCAR AUDIO ESPECIAL: ", lista_de_audios[linha_atual].resource_path) # <--- ADICIONE ISTO
		tem_audio_especifico = true
	
	if linha_atual < lista_de_audios.size() and lista_de_audios[linha_atual] != null:
		tem_audio_especifico = true
		audio_player.stream = lista_de_audios[linha_atual]
		audio_player.pitch_scale = 1.0
		audio_player.play()
	
	while text_label.visible_characters < total_caracteres:
		if not esta_digitando:
			text_label.visible_characters = total_caracteres
			break
			
		text_label.visible_characters += 1
		
		if not tem_audio_especifico:
			if audio_player.stream != som_padrao_bip:
				audio_player.stream = som_padrao_bip
			
			audio_player.pitch_scale = randf_range(0.9, 1.1)
			audio_player.play()
		
		await get_tree().create_timer(velocidade_digitacao).timeout
	
	esta_digitando = false

func terminar_dialogo():
	$Background.visible = false
	dialogo_finalizado.emit()
	queue_free()

func _input(event):
	if event.is_action_pressed("interact") and $Background.visible:
		if esta_digitando:
			esta_digitando = false
		else:
			linha_atual += 1
			mostrar_texto_atual()
