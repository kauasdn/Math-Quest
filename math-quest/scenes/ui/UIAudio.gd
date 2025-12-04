extends Node

@onready var hover_sound = $HoverSound
@onready var click_sound = $ClickSound

func _ready():
	await get_tree().process_frame
	
	var root_node = get_parent()
	
	conectar_botoes(root_node)

func conectar_botoes(node):
	for child in node.get_children():
		if child is Button:
			if not child.mouse_entered.is_connected(_on_hover):
				child.mouse_entered.connect(_on_hover)
			
			if not child.pressed.is_connected(_on_click):
				child.pressed.connect(_on_click)
		
		conectar_botoes(child)

func _on_hover():
	hover_sound.pitch_scale = randf_range(0.95, 1.05)
	hover_sound.play()

func _on_click():
	click_sound.play()
