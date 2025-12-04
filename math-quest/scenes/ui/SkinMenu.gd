# res://cenas/ui/SkinMenu.gd
extends Control

# Sinal para avisar o NPC (que abriu este menu) que ele foi fechado
signal menu_fechado

@export var skin_button_scene: PackedScene

# Referências aos nós da cena
@onready var skin_container = $CanvasLayer/Panel/VBoxContainer/SkinContainer
@onready var close_button = $CanvasLayer/Panel/VBoxContainer/CloseButton

func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	
	close_button.pressed.connect(_on_close_button_pressed)
	
	popular_menu()

func popular_menu():
	var skins_liberadas = SkinManager.skins_desbloqueadas
	
	for skin_id in skins_liberadas:
		var novo_botao = skin_button_scene.instantiate()
		
		skin_container.add_child(novo_botao)
		
		novo_botao.setup(skin_id)
		
		novo_botao.skin_selecionada.connect(_on_skin_selecionada)

func _on_skin_selecionada(skin_id: String):
	SkinManager.set_skin_atual(skin_id)

func _on_close_button_pressed():
	menu_fechado.emit()
	self.queue_free()
