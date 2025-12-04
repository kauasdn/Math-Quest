extends Node

var questions = {

	"Adição": [
		{ "pergunta": "5 + 3 = ?", "opcoes": ["6", "7", "8", "9"], "correta": 2 },
		{ "pergunta": "10 + 4 = ?", "opcoes": ["12", "14", "15", "11"], "correta": 1 },
		{ "pergunta": "7 + 6 = ?", "opcoes": ["12", "13", "14", "15"], "correta": 1 },
		{ "pergunta": "2 + 9 = ?", "opcoes": ["9", "10", "11", "12"], "correta": 2 },
		{ "pergunta": "15 + 5 = ?", "opcoes": ["20", "19", "21", "18"], "correta": 0 },
		{ "pergunta": "0 + 7 = ?", "opcoes": ["7", "0", "1", "6"], "correta": 0 },
		{ "pergunta": "4 + 4 = ?", "opcoes": ["7", "8", "9", "6"], "correta": 1 },
		{ "pergunta": "13 + 2 = ?", "opcoes": ["14", "15", "16", "13"], "correta": 1 },
		{ "pergunta": "6 + 6 = ?", "opcoes": ["11", "10", "12", "13"], "correta": 2 },
		{ "pergunta": "9 + 8 = ?", "opcoes": ["16", "17", "18", "15"], "correta": 1 },
	],

	"Subtração": [
		{ "pergunta": "9 - 4 = ?", "opcoes": ["3", "4", "5", "6"], "correta": 2 },
		{ "pergunta": "10 - 2 = ?", "opcoes": ["7", "8", "9", "6"], "correta": 1 },
		{ "pergunta": "15 - 5 = ?", "opcoes": ["11", "10", "9", "8"], "correta": 1 },
		{ "pergunta": "7 - 7 = ?", "opcoes": ["0", "1", "7", "-1"], "correta": 0 },
		{ "pergunta": "20 - 3 = ?", "opcoes": ["16", "17", "18", "19"], "correta": 1 },
		{ "pergunta": "6 - 2 = ?", "opcoes": ["2", "3", "4", "5"], "correta": 2 },
		{ "pergunta": "14 - 6 = ?", "opcoes": ["8", "7", "9", "6"], "correta": 0 },
		{ "pergunta": "5 - 9 = ?", "opcoes": ["-4", "4", "-3", "3"], "correta": 0 },
		{ "pergunta": "12 - 4 = ?", "opcoes": ["7", "8", "6", "9"], "correta": 1 },
		{ "pergunta": "18 - 9 = ?", "opcoes": ["7", "8", "9", "10"], "correta": 2 },
	],

	"Multiplicação": [
		{ "pergunta": "3 × 6 = ?", "opcoes": ["18", "12", "16", "20"], "correta": 0 },
		{ "pergunta": "5 × 5 = ?", "opcoes": ["10", "20", "25", "30"], "correta": 2 },
		{ "pergunta": "4 × 7 = ?", "opcoes": ["28", "24", "21", "14"], "correta": 0 },
		{ "pergunta": "6 × 2 = ?", "opcoes": ["8", "12", "10", "14"], "correta": 1 },
		{ "pergunta": "9 × 3 = ?", "opcoes": ["27", "26", "29", "24"], "correta": 0 },
		{ "pergunta": "7 × 7 = ?", "opcoes": ["42", "49", "56", "36"], "correta": 1 },
		{ "pergunta": "8 × 5 = ?", "opcoes": ["35", "40", "45", "30"], "correta": 1 },
		{ "pergunta": "2 × 9 = ?", "opcoes": ["18", "11", "16", "20"], "correta": 0 },
		{ "pergunta": "10 × 3 = ?", "opcoes": ["30", "13", "33", "20"], "correta": 0 },
		{ "pergunta": "11 × 2 = ?", "opcoes": ["22", "21", "20", "23"], "correta": 0 },
	],

	"Divisão": [
		{ "pergunta": "12 ÷ 3 = ?", "opcoes": ["2", "3", "4", "6"], "correta": 2 },
		{ "pergunta": "10 ÷ 2 = ?", "opcoes": ["3", "5", "4", "6"], "correta": 1 },
		{ "pergunta": "9 ÷ 3 = ?", "opcoes": ["2", "3", "4", "6"], "correta": 1 },
		{ "pergunta": "20 ÷ 4 = ?", "opcoes": ["4", "5", "6", "3"], "correta": 1 },
		{ "pergunta": "15 ÷ 5 = ?", "opcoes": ["2", "3", "4", "5"], "correta": 1 },
		{ "pergunta": "8 ÷ 2 = ?", "opcoes": ["2", "3", "4", "5"], "correta": 2 },
		{ "pergunta": "6 ÷ 3 = ?", "opcoes": ["1", "2", "3", "0"], "correta": 1 },
		{ "pergunta": "18 ÷ 6 = ?", "opcoes": ["2", "3", "4", "5"], "correta": 1 },
		{ "pergunta": "14 ÷ 7 = ?", "opcoes": ["2", "3", "4", "1"], "correta": 0 },
		{ "pergunta": "21 ÷ 7 = ?", "opcoes": ["2", "3", "4", "5"], "correta": 1 },
	],

	"Extremo": [
		{ "pergunta": "15 × 2 - 10 = ?", "opcoes": ["20", "25", "30", "40"], "correta": 1 },
		{ "pergunta": "(8 + 2) × 3 = ?", "opcoes": ["24", "20", "30", "25"], "correta": 0 },
		{ "pergunta": "18 ÷ (3 + 3) = ?", "opcoes": ["2", "3", "1", "6"], "correta": 0 },
		{ "pergunta": "7 × (5 - 2) = ?", "opcoes": ["21", "24", "18", "15"], "correta": 0 },
		{ "pergunta": "(6 + 4) ÷ 2 = ?", "opcoes": ["4", "5", "3", "6"], "correta": 0 },
		{ "pergunta": "3 × 4 + 5 = ?", "opcoes": ["17", "20", "15", "12"], "correta": 0 },
		{ "pergunta": "20 - 3 × 2 = ?", "opcoes": ["14", "8", "16", "12"], "correta": 2 },
		{ "pergunta": "(9 - 3) × (2 + 1) = ?", "opcoes": ["18", "16", "12", "20"], "correta": 0 },
		{ "pergunta": "(5 + 5) × (2 + 1) = ?", "opcoes": ["30", "25", "20", "35"], "correta": 0 },
		{ "pergunta": "12 + 18 ÷ 6 = ?", "opcoes": ["14", "15", "16", "20"], "correta": 1 },
	],
}

func get_question(kingdom: String, index: int) -> Dictionary:
	return questions[kingdom][index]

func get_questions_for_kingdom(kingdom: String) -> Array:
	if questions.has(kingdom):
		return questions[kingdom].duplicate()
	else:
		print("Erro: Reino não encontrado no QuestionDatabase: ", kingdom)
		return []
