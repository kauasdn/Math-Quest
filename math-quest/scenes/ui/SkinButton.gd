extends Button

signal skin_selecionada(skin_id)

@onready var texture_rect = $HBoxContainer/TextureRect
@onready var label = $HBoxContainer/Label

var skin_id: String

func setup(id: String):
	skin_id = id
	label.text = skin_id.capitalize()
	
	var textura = SkinManager.get_preview_icon_por_id(skin_id)

	if textura:
		texture_rect.texture = textura
		texture_rect.custom_minimum_size = Vector2(64, 64) 
		texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

func _ready():
	self.pressed.connect(_on_pressed)

func _on_pressed():
	skin_selecionada.emit(skin_id)
