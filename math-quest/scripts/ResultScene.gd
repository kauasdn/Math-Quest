extends Control

const KINGDOM_SKINS_DATABASE = {
	"Adição": "RedWarrior",
	"Subtração": "BlueWarrior",
	"Multiplicação": "YellowWarrior",
	"Divisão": "BlackArcher",
	"Extremo": "RedMonk"
}

func _ready():
	$VBoxContainer/ScoreLabel.text = "Pontuação: %d" % GameManager.score
	$VBoxContainer/ContinueButton.pressed.connect(_on_continue_pressed)
	
	GameManager.update_best_score(GameManager.current_kingdom, GameManager.score)
	
	_check_for_perfect_score()

func _check_for_perfect_score():
	var score_atual = GameManager.score
	var kingdom_atual = GameManager.current_kingdom
	
	var pontuacao_perfeita = GameManager.QUESTIONS_PER_KINGDOM * 10
	
	if score_atual != pontuacao_perfeita:
		return
		
	if KINGDOM_SKINS_DATABASE.has(kingdom_atual):
		var skin_id = KINGDOM_SKINS_DATABASE[kingdom_atual]
		
		print("PONTUAÇÃO PERFEITA! Desbloqueando skin: ", skin_id)
		
		SkinManager.desbloquear_skin(skin_id)

func _on_continue_pressed():
	get_tree().change_scene_to_file(GameManager.return_scene)
