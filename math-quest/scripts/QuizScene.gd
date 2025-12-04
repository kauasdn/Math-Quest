extends Control

var current_question : Dictionary


var current_quiz_questions: Array

var current_question_local_index: int = 0

func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	
	var kingdom = GameManager.current_kingdom
	
	current_quiz_questions = QuestionDatabase.get_questions_for_kingdom(kingdom)
	
	current_quiz_questions.shuffle()
	
	_load_question()

func _load_question():
	current_question = current_quiz_questions[current_question_local_index]
	
	$CanvasLayer/VBoxContainer/QuestionLabel.text = current_question["pergunta"]

	for i in range(4):
		var btn = $CanvasLayer/VBoxContainer/Answers.get_node("Answer%d" % i)
		btn.text = current_question["opcoes"][i]
		btn.set_meta("answer_index", i)
		if btn.pressed.is_connected(_on_answer_button_pressed):
			btn.pressed.disconnect(_on_answer_button_pressed)
		btn.pressed.connect(_on_answer_button_pressed.bind(btn))

func _on_answer_button_pressed(button: Button):
	var choice = button.get_meta("answer_index")
	_on_answer_selected(choice)

func _on_answer_selected(choice: int):
	var correct = current_question["correta"]
	if choice == correct:
		GameManager.score += 10

	current_question_local_index += 1

	if current_question_local_index < current_quiz_questions.size():
		_load_question()
	else:
		GameManager.unlock_next_kingdom()
		get_tree().change_scene_to_file("res://scenes/ResultScene.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("quit_game") or event.is_action_pressed("ui_cancel"):
		
		get_tree().get_root().set_input_as_handled()
		
		sair_do_quiz()

func sair_do_quiz():
	if not is_inside_tree():
		return

	print("Cancelando quiz e voltando ao mapa...")
	
	GameManager.score = 0
	
	if get_tree():
		get_tree().paused = false
		get_tree().change_scene_to_file(GameManager.return_scene)
