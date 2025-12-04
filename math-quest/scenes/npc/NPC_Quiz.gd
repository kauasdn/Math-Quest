extends StaticBody2D

@export var kingdom_name: String = "Adição"

# --- CONFIGURAÇÃO DE DIÁLOGO (NORMAL/INTRO) ---
@export_multiline var falas_do_npc: Array[String]
@export var audios_do_npc: Array[AudioStream]
@export var dialogue_scene: PackedScene

# --- CONFIGURAÇÃO VISUAL ---
const KINGDOM_SPRITES = {
	"Adição": "res://scenes/npc/assets/red_wizard.tres",
	"Subtração": "res://scenes/npc/assets/blue_wizard.tres",
	"Multiplicação": "res://scenes/npc/assets/black_wizard.tres",
	"Divisão": "res://scenes/npc/assets/purple_wizard.tres",
	"Extremo": "res://scenes/npc/assets/warrior_npc.tres"
}

@onready var interaction_area = $Area2D
@onready var animated_sprite_npc = $AnimatedSprite2D
@onready var interaction_hint = $InteractionHint

var player_in_range = false
var em_cooldown = false

# --- CONFIGURAÇÃO DE BLOQUEIO ---
var falas_bloqueado: Array[String] = [
	"Você ainda não é digno de me enfrentar!",
	"Vá primeiro tentar derrotar meus 4 magos, e ai, talvez te darei uma chance de mostrar seu valor."
]
@export var audios_bloqueado: Array[AudioStream]

@export_multiline var falas_vitoria_60: Array[String] = [
	"Você sobreviveu... impressionante.",
	"Mas vejo que ainda cometeu erros. Busque a perfeição se quiser minha verdadeira recompensa."
]
@export var audios_vitoria_60: Array[AudioStream]

@export_multiline var falas_vitoria_100: Array[String] = [
	"INCRÍVEL! Ninguém jamais chegou tão longe!",
	"Você dominou o caos absoluto. Curvem-se diante do novo Mestre da Matemática!"
]
@export var audios_vitoria_100: Array[AudioStream]

func _ready():
	_setup_npc_visual()
	
	interaction_area.body_entered.connect(_on_area_2d_body_entered)
	interaction_area.body_exited.connect(_on_area_2d_body_exited)
	
	if interaction_hint:
		interaction_hint.visible = false

func _setup_npc_visual():
	if KINGDOM_SPRITES.has(kingdom_name):
		var frames_npc = load(KINGDOM_SPRITES[kingdom_name])
		if frames_npc:
			animated_sprite_npc.sprite_frames = frames_npc
			animated_sprite_npc.play("idle")
	else:
		print("Aviso: SpriteFrames não encontrado para: ", kingdom_name)

# --- INTERAÇÃO ---
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"): 
		player_in_range = true
		if interaction_hint: interaction_hint.visible = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		if interaction_hint: interaction_hint.visible = false

func _unhandled_input(event):
	if event.is_action_pressed("interact") and player_in_range and not em_cooldown:
		get_tree().get_root().set_input_as_handled()
		if interaction_hint: interaction_hint.visible = false
		
		iniciar_dialogo()

# --- LÓGICA DE DIÁLOGO ---
func iniciar_dialogo():
	if not dialogue_scene:
		print("ERRO: DialogueBox.tscn não atribuído no Inspetor!")
		iniciar_quiz()
		return
	
	if kingdom_name == "Extremo":
		var melhor_score = GameManager.kingdom_best_scores.get("Extremo", 0)
		
		if melhor_score == 100:
			abrir_caixa_dialogo(falas_vitoria_100, audios_vitoria_100, false)
			return
			
		if melhor_score >= 60:
			abrir_caixa_dialogo(falas_vitoria_60, audios_vitoria_60, true)
			return

		if not verificar_requisitos_extremo():
			abrir_caixa_dialogo(falas_bloqueado, audios_bloqueado, false)
			return

	abrir_caixa_dialogo(falas_do_npc, audios_do_npc, true)

func abrir_caixa_dialogo(textos: Array[String], audios: Array[AudioStream], ir_para_quiz: bool):
	get_tree().paused = true
	
	var dialogo = dialogue_scene.instantiate()
	get_tree().get_root().add_child(dialogo)
	
	dialogo.iniciar(textos, audios)
	
	if ir_para_quiz:
		dialogo.dialogo_finalizado.connect(_on_dialogo_terminou)
	else:
		dialogo.dialogo_finalizado.connect(_on_dialogo_bloqueado_terminou)

func _on_dialogo_terminou():
	iniciar_quiz()

func _on_dialogo_bloqueado_terminou():
	em_cooldown = true
	get_tree().paused = false
	await get_tree().create_timer(0.5).timeout
	em_cooldown = false
	
	if player_in_range and interaction_hint:
		interaction_hint.visible = true

func verificar_requisitos_extremo() -> bool:
	var requisitos = ["Adição", "Subtração", "Multiplicação", "Divisão"]
	
	for reino in requisitos:
		if GameManager.kingdom_best_scores.get(reino, 0) < 60:
			return false 
			
	return true 

# --- QUIZ ---
func iniciar_quiz():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		GameManager.player_position_on_map = player.global_position
	
	GameManager.current_kingdom = kingdom_name
	GameManager.current_question_index = 0
	GameManager.score = 0
	GameManager.return_scene = "res://scenes/map.tscn"
	
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/QuizScene.tscn")
