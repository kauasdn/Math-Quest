extends Node

# AutoLoad singleton to manage progression and score

const KINGDOMS := ["Adição", "Subtração", "Multiplicação", "Divisão", "Extremo"]
const QUESTIONS_PER_KINGDOM := 10

var current_kingdom: String = ""
var current_question_index: int = 0
var score: int = 0
var unlocked_kingdoms: Array = ["Adição"] # começa apenas com Adição desbloqueado

func _ready():
	# Ensure singletons loaded
	pass

func reset_game():
	score = 0
	current_question_index = 0
	unlocked_kingdoms = ["Adição"]

func unlock_next_kingdom():
	var idx = KINGDOMS.find(current_kingdom)
	if idx >= 0 and idx + 1 < KINGDOMS.size():
		var next_kingdom = KINGDOMS[idx + 1]
		if not unlocked_kingdoms.has(next_kingdom):
			unlocked_kingdoms.append(next_kingdom)
