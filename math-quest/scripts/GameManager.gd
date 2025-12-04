extends Node

const KINGDOMS := ["Adição", "Subtração", "Multiplicação", "Divisão", "Extremo"]
const QUESTIONS_PER_KINGDOM := 10

var current_kingdom: String = ""
var current_question_index: int = 0
var score: int = 0
var unlocked_kingdoms: Array = ["Adição"]

var return_scene: String = "res://scenes/MainMenu.tscn"
var player_position_on_map: Vector2 = Vector2.ZERO
var player_last_position: Vector2 = Vector2.ZERO

var kingdom_best_scores = {
	"Adição": 0,
	"Subtração": 0,
	"Multiplicação": 0,
	"Divisão": 0,
	"Extremo": 0
}

func _ready():
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

func _unhandled_input(event):
	if event.is_action_pressed("quit_game"):

		var cena_atual = get_tree().current_scene

		if cena_atual.scene_file_path != "res://scenes/MainMenu.tscn":
			print("Voltando para o Menu Principal...")
			get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func update_best_score(kingdom: String, points: int):
	if kingdom_best_scores.has(kingdom):
		if points > kingdom_best_scores[kingdom]:
			kingdom_best_scores[kingdom] = points
			print("Novo recorde para %s: %d" % [kingdom, points])
