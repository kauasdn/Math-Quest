extends Control

func _ready():
	$VBoxContainer/BackButton.pressed.connect(_on_back_pressed)
	_populate_kingdoms()

func _populate_kingdoms():
	var container = $VBoxContainer/KingdomList
	
	# Remove todos os filhos antes de recriar
	for child in container.get_children():
		child.queue_free()
	
	# Cria os botões dinamicamente
	for kingdom in GameManager.KINGDOMS:
		var btn = Button.new()
		btn.text = kingdom
		btn.name = kingdom
		btn.disabled = not GameManager.unlocked_kingdoms.has(kingdom)
		btn.pressed.connect(_on_kingdom_selected.bind(kingdom))
		container.add_child(btn)

func _on_kingdom_selected(kingdom: String):
	GameManager.current_kingdom = kingdom
	GameManager.current_question_index = 0
	get_tree().change_scene_to_file("res://scenes/QuizScene.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
