extends StaticBody2D

# --- CONFIGURAÇÃO DE DIÁLOGO ---
@export_multiline var falas_do_npc: Array[String] = [
	"Olá, viajante! Preparado pra se aventurar por este reino?",
	"Vá, explore por ai, se voltar para falar comigo te darei recompensas por tuas conquistas!"
]

@export var audios_do_npc: Array[AudioStream]

@export var dialogue_scene: PackedScene

# --- CONFIGURAÇÃO DO MENU ---
@export var skin_menu_scene: PackedScene

@onready var interaction_hint = $InteractionHint
@onready var interaction_area = $Area2D

var player_in_range = false
var menu_instance = null

func _ready():
	interaction_area.body_entered.connect(_on_area_2d_body_entered)
	interaction_area.body_exited.connect(_on_area_2d_body_exited)
	
	if interaction_hint:
		interaction_hint.visible = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		if interaction_hint:
			interaction_hint.visible = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		if interaction_hint:
			interaction_hint.visible = false

func _unhandled_input(event):
	if event.is_action_pressed("interact") and player_in_range and menu_instance == null:
		
		get_tree().get_root().set_input_as_handled()
		
		if interaction_hint:
			interaction_hint.visible = false
			
		iniciar_dialogo()

# --- LÓGICA DO DIÁLOGO ---
func iniciar_dialogo():
	if not dialogue_scene:
		print("Aviso: Cena de diálogo não definida no SkinSelectorNPC.")
		abrir_menu_skins()
		return

	get_tree().paused = true
	
	var dialogo = dialogue_scene.instantiate()
	get_tree().get_root().add_child(dialogo)
	
	dialogo.iniciar(falas_do_npc, audios_do_npc)
	
	dialogo.dialogo_finalizado.connect(_on_dialogo_terminou)

func _on_dialogo_terminou():
	print("Diálogo terminou. Abrindo menu de skins...")
	abrir_menu_skins()

# --- LÓGICA DO MENU DE SKINS ---
func abrir_menu_skins():
	if skin_menu_scene == null:
		print("ERRO: A variável 'skin_menu_scene' está VAZIA (null)!")
		get_tree().paused = false
		return 

	get_tree().paused = true 
	
	print("Instanciando a cena do menu...")
	menu_instance = skin_menu_scene.instantiate()
	
	if menu_instance == null:
		print("ERRO: A instância do menu falhou ao ser criada!")
		get_tree().paused = false
		return
		
	menu_instance.menu_fechado.connect(_on_skin_menu_fechado)
	
	get_tree().get_root().add_child(menu_instance)

func _on_skin_menu_fechado():
	print("Menu fechado. Despausando jogo.")
	
	get_tree().paused = false
	
	menu_instance = null
	
	if player_in_range and interaction_hint:
		interaction_hint.visible = true
