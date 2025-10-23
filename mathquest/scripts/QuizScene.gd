extends Control

var current_question : Dictionary

func _ready():
	_load_question()

func _load_question():
	var kingdom = GameManager.current_kingdom
	var index = GameManager.current_question_index
	current_question = QuestionDatabase.get_question(kingdom, index)
	$QuestionLabel.text = current_question["pergunta"]

	for i in range(4):
		var btn = $Answers.get_node("Answer%d" % i)
		btn.text = current_question["opcoes"][i]

		# Guardamos o índice diretamente no botão
		btn.set_meta("answer_index", i)

		# Evita múltiplas conexões
		if btn.pressed.is_connected(_on_answer_button_pressed):
			btn.pressed.disconnect(_on_answer_button_pressed)

		# Conecta o botão, passando ele mesmo como argumento
		btn.pressed.connect(_on_answer_button_pressed.bind(btn))

func _on_answer_button_pressed(button: Button):
	# Lemos o índice armazenado no botão
	var choice = button.get_meta("answer_index")
	_on_answer_selected(choice)

func _on_answer_selected(choice: int):
	var correct = current_question["correta"]

	# Pontua apenas acertos
	if choice == correct:
		GameManager.score += 10

	# Avança para a próxima pergunta
	GameManager.current_question_index += 1

	# Se ainda tem perguntas, carrega a próxima
	if GameManager.current_question_index < GameManager.QUESTIONS_PER_KINGDOM:
		_load_question()
	else:
		# Se terminou as perguntas, vai para o resultado
		GameManager.unlock_next_kingdom()
		get_tree().change_scene_to_file("res://scenes/ResultScene.tscn")
